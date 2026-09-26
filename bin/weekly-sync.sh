#!/usr/bin/env bash
# weekly-sync.sh — pull @isaac_flath items newer than posts/watermark.txt, transcribe them
# into posts/ (one markdown file per item, same format as the existing files), then update
# posts/manifest.json and posts/watermark.txt.
#
# Last stdout line on success: NEW_POSTS=<n>
# On failure:                  ERROR=<reason>   (exit 1)
# Diagnostics go to stderr.
#
# Instagram API calls per run: 1 (accounts) + 1 per post-type group per page (normally 3,
# capped at 3 groups x 8 pages) + up to 3 x ceil(new / 10) (media-understanding retries).
# A normal week is well under 20 calls.

set -uo pipefail

REPO="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
POSTS="$REPO/posts"

die() { echo "ERROR=$1"; exit 1; }

command -v instagram-cli >/dev/null 2>&1 || die "instagram_cli_not_found"
command -v python3       >/dev/null 2>&1 || die "python3_not_found"
[ -f "$POSTS/watermark.txt" ] || die "missing_watermark_file"
[ -f "$POSTS/manifest.json" ] || die "missing_manifest_file"

out="$(python3 - "$POSTS" <<'PY'
import json, os, re, subprocess, sys
from datetime import datetime, timezone

POSTS      = sys.argv[1]
USERNAME   = "isaac_flath"
TYPE_GROUPS = ["POST,REEL", "HIGHLIGHT", "STORY"]
MAX_PAGES  = 8      # per type group
PAGE_LIMIT = 100
MU_BATCH   = 10     # media ids per media-understanding call
MU_TRIES   = 3      # attempts before giving up on an empty description
TODAY      = datetime.now().strftime("%Y-%m-%d")

def log(msg):
    sys.stderr.write("weekly-sync: %s\n" % msg)

def fail(reason):
    print("ERROR=%s" % re.sub(r"[^A-Za-z0-9_]+", "_", reason).strip("_")[:80])
    sys.exit(1)

def cli(*args):
    try:
        p = subprocess.run(["instagram-cli", *args], capture_output=True, text=True, timeout=300)
    except subprocess.TimeoutExpired:
        fail("instagram_cli_timeout_%s" % args[0])
    except Exception as e:
        fail("instagram_cli_exec_%s" % type(e).__name__)
    if p.returncode != 0:
        msg = " ".join((p.stderr or p.stdout or "no output").strip().splitlines())
        log("instagram-cli %s failed: %s" % (args[0], msg[:400]))
        fail("instagram_cli_%s_exit_%d" % (args[0], p.returncode))
    try:
        return json.loads(p.stdout)
    except ValueError:
        fail("instagram_cli_%s_bad_json" % args[0])

def norm_ts(s):
    """'2026-08-04T19:03:58+00:00' / '2026-08-04 19:03:58' -> '2026-08-04 19:03:58'."""
    if not isinstance(s, str) or not s.strip():
        return None
    s = s.strip().replace("Z", "+00:00")
    try:
        dt = datetime.fromisoformat(s)
    except ValueError:
        return None
    if dt.tzinfo is not None:
        dt = dt.astimezone(timezone.utc).replace(tzinfo=None)
    return dt.strftime("%Y-%m-%d %H:%M:%S")

# ---------------------------------------------------------------- existing state
try:
    with open(os.path.join(POSTS, "manifest.json")) as fh:
        manifest = json.load(fh)
except Exception as e:
    fail("manifest_unreadable_%s" % type(e).__name__)
items = manifest.get("items")
if not isinstance(items, list):
    fail("manifest_missing_items")

with open(os.path.join(POSTS, "watermark.txt")) as fh:
    watermark = fh.read().strip()
if not re.match(r"^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$", watermark):
    fail("watermark_unparseable")

known_ids  = {str(i.get("post_id")) for i in items if i.get("post_id")}
known_urls = {i.get("url") for i in items if i.get("url")}

# ---------------------------------------------------------------- account
acct_data = cli("accounts")
accounts  = acct_data.get("accounts") if isinstance(acct_data, dict) else None
if not accounts:
    fail("no_instagram_account_linked")
if len(accounts) > 1:
    log("%d accounts linked; using the first" % len(accounts))
acct = str(accounts[0].get("user_fbid") or "")
if not acct:
    fail("no_account_id")

# ---------------------------------------------------------------- fetch
def fetch(post_types):
    """All items of these types created on/after the watermark day. The CLI reports
    has_next_page without always returning a cursor, so when no cursor comes back we
    advance --since to the newest timestamp seen and stop once a page adds nothing."""
    got, seen = [], set()
    since, cursor = watermark[:10], None
    for _ in range(MAX_PAGES):
        args = ["posts", "--account-id", acct, "--username", USERNAME,
                "--since", since, "--sort-order", "asc", "--limit", str(PAGE_LIMIT),
                "--post-types", post_types, "--retries", "2"]
        if cursor:
            args += ["--after", cursor]
        data  = cli(*args)
        posts = data.get("posts") or []
        fresh = [p for p in posts if str(p.get("post_id")) not in seen]
        for p in fresh:
            seen.add(str(p.get("post_id")))
        got += fresh
        if not data.get("has_next_page") or not fresh:
            break
        cursor = data.get("next_cursor") or (data.get("page_info") or {}).get("end_cursor")
        if not cursor:
            newest = max((norm_ts(p.get("created_at")) or "" for p in posts), default="")
            if not newest or newest <= since:
                break
            since = newest
    else:
        log("page cap (%d) reached for %s; more may remain" % (MAX_PAGES, post_types))
    return got

raw = []
for group in TYPE_GROUPS:
    raw += fetch(group)

SHORT_RE = re.compile(r"/(?:reel|reels|p|tv)/([A-Za-z0-9_-]+)")

def classify(url):
    m = re.search(r"story_media_id=(\d+)", url)
    if m:
        return "highlight", "highlight-" + m.group(1)
    m = re.search(r"/stories/[^/]+/(\d+)", url)
    if m:
        return "story", "story-" + m.group(1)
    m = SHORT_RE.search(url)
    if m:
        return ("reel" if re.search(r"/reels?/", url) else "post"), m.group(1)
    return "post", None

new, seen = [], set()
for post in raw:
    pid  = str(post.get("post_id") or "")
    url  = post.get("url") or ""
    when = norm_ts(post.get("created_at")) or norm_ts((post.get("post_created_at") or {}).get("utc"))
    if not when or when <= watermark:
        continue
    if not pid or pid in known_ids or pid in seen or (url and url in known_urls):
        continue
    typ, shortcode = classify(url)
    seen.add(pid)
    new.append({"post": post, "date": when, "type": typ, "url": url, "post_id": pid,
                "shortcode": shortcode or ("id-" + pid)})
new.sort(key=lambda r: r["date"])
log("%d item(s) newer than %s" % (len(new), watermark))

# ---------------------------------------------------------------- visual descriptions
descriptions = {}
pending = [r["post_id"] for r in new]
for attempt in range(1, MU_TRIES + 1):
    if not pending:
        break
    for i in range(0, len(pending), MU_BATCH):
        chunk = pending[i:i + MU_BATCH]
        data  = cli("media-understanding", "--account-id", acct,
                    "--media-ids", ",".join(chunk), "--retries", "2")
        for m in (data.get("media") or []):
            mid  = str(m.get("media_id") or "")
            text = m.get("narrative_summary")
            if mid in chunk and isinstance(text, str) and text.strip():
                descriptions[mid] = text.strip()
            elif mid in chunk and m.get("error"):
                log("media-understanding error for one item (attempt %d): %s"
                    % (attempt, str(m["error"])[:200]))
    pending = [pid for pid in pending if pid not in descriptions]
if pending:
    log("%d item(s) still without a visual description after %d attempts" % (len(pending), MU_TRIES))

# ---------------------------------------------------------------- render
QUOTE_RE = re.compile(r"[\"“]([^\"“”]{1,400})[\"”]")
NOT_VISIBLE = ("[not visible] The media-understanding service returned an empty description "
               "for this item after three attempts, and the CLI exposes no media URL, so the "
               "visual content could not be transcribed. Only the caption above is available.")
SOURCE_NOTE = ("Source: automated media description returned by instagram-cli "
               "`media-understanding`. The CLI exposes no media file or frame, so the "
               "video/image was not viewed directly; the description below is the only "
               "visual evidence and is reproduced as returned.")

def render(rec):
    post    = rec["post"]
    caption = (post.get("post_caption") or "").strip()
    head    = next((l.strip() for l in caption.splitlines() if l.strip()), "")
    title   = head[:90] if head else "%s %s" % (rec["type"], rec["shortcode"])
    user    = post.get("username") or USERNAME
    name    = post.get("author_name")
    author  = "@%s (%s)" % (user, name) if name else "@%s" % user
    likes, comments = post.get("likes"), post.get("comments")
    counts  = "%s / %s" % (likes, comments) if likes is not None and comments is not None \
              else "[not available]"
    media   = post.get("media_type")
    if not isinstance(media, str) or not media.strip():
        media = "image" if rec["type"] in ("highlight", "story") else "video"
    desc = descriptions.get(rec["post_id"])

    out = ["# %s" % title, "",
           "- URL: %s" % (rec["url"] or "[not available]"),
           "- Date: %s (as returned by instagram-cli `created_at`)" % rec["date"],
           "- Type: %s" % rec["type"],
           "- Media type: %s" % media.lower(),
           "- Author: %s" % author,
           "- Likes / comments at collection (%s): %s" % (TODAY, counts),
           "", "## Caption", "", caption if caption else "[no caption]",
           "", "## Visual content", ""]
    if desc:
        quotes = list(dict.fromkeys(q.strip() for q in QUOTE_RE.findall(desc) if q.strip()))
        out += [SOURCE_NOTE, "", desc, "",
                "### On-screen or spoken text quoted in the description", ""]
        out += ['- "%s"' % q for q in quotes] or ["- [none quoted]"]
        out += ["", "### Gaps", "",
                "- Exact slide/overlay text, terminal output, table cells, and chart values "
                "beyond what the description quotes: [not visible]"]
    else:
        out += [NOT_VISIBLE]
    return "\n".join(out) + "\n"

written = []
for rec in new:
    fname = "%s-%s.md" % (rec["date"][:10], rec["shortcode"])
    try:
        with open(os.path.join(POSTS, fname), "w") as fh:
            fh.write(render(rec))
    except OSError as e:
        fail("write_failed_%s" % type(e).__name__)
    written.append(fname)
    items.append({"url": rec["url"], "date": rec["date"], "type": rec["type"],
                  "post_id": rec["post_id"], "shortcode": rec["shortcode"],
                  "local_file": fname,
                  "has_visual_description": rec["post_id"] in descriptions})

# ---------------------------------------------------------------- manifest + watermark
if written:
    counts = {}
    for i in items:
        counts[i.get("type", "unknown")] = counts.get(i.get("type", "unknown"), 0) + 1
    dates = [i["date"] for i in items if i.get("date")]
    reels = [i["date"] for i in items if i.get("type") == "reel" and i.get("date")]
    manifest["collected_at"] = TODAY
    manifest["newest_created_at"] = max(dates)
    if reels:
        manifest["newest_reel_created_at"] = max(reels)
    manifest["counts"] = counts
    manifest["items_without_visual_description"] = sum(
        1 for i in items if not i.get("has_visual_description"))
    manifest["items"] = items

    tmp = os.path.join(POSTS, "manifest.json.tmp")
    try:
        with open(tmp, "w") as fh:
            json.dump(manifest, fh, indent=1, ensure_ascii=False)
            fh.write("\n")
        os.replace(tmp, os.path.join(POSTS, "manifest.json"))
        with open(os.path.join(POSTS, "watermark.txt"), "w") as fh:
            fh.write(max(dates) + "\n")
    except OSError as e:
        fail("state_update_failed_%s" % type(e).__name__)
    for f in written:
        log("wrote posts/%s" % f)

print(len(written))
PY
)"
rc=$?

if [ "$rc" -ne 0 ]; then
  case "$out" in
    *ERROR=*) printf '%s\n' "$out" | grep -m1 '^ERROR=' ;;
    *)        echo "ERROR=sync_failed_rc_${rc}" ;;
  esac
  exit 1
fi

n="$(printf '%s\n' "$out" | tail -n 1)"
case "$n" in
  ''|*[!0-9]*) die "bad_count_from_sync" ;;
esac

echo "NEW_POSTS=$n"
