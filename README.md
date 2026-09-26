# isaac-flath-pdf-skill

A Claude skill on getting information out of PDFs, scans and forms reliably, distilled from
the Instagram posts of Isaac Flath (@isaac_flath), plus the evidence it was built from and
the tooling that keeps it current.

## Layout

- `SKILL.md` — the skill. Written for someone who sets up and tests document-extraction
  agents in a product UI, not someone who picks OCR engines or writes code.
- `posts/` — one markdown file per Instagram item, named `YYYY-MM-DD-<id>.md`. Each holds
  the URL, date, type (reel, post, highlight, story), full caption, and the visual
  description returned by the Instagram CLI's media-understanding service. Items where that
  service returned nothing say so and carry the caption only.
- `posts/manifest.json` — index of every item in `posts/` with counts, newest timestamps and
  a `has_visual_description` flag per item.
- `posts/watermark.txt` — timestamp of the newest item collected. The sync starts from here.
- `raw/` — unedited JSON responses from `instagram-cli` captured during the first collection
  (post pages, highlights, stories, media-understanding output). Kept for audit only.
- `working/` — interim synthesis notes used to write `SKILL.md`.

## Weekly sync

`bin/weekly-sync.sh` reads the watermark, lists @isaac_flath posts, reels, highlights and
stories created after it, fetches a visual description for each new item, writes a post
file in the same format, appends the item to `manifest.json`, and moves the watermark to
the newest timestamp. It prints `NEW_POSTS=<n>` as its last line, or `ERROR=<reason>` and
exits 1. A normal week costs under 20 Instagram API calls. Run it from anywhere as
`bin/weekly-sync.sh`. New post files do not update `SKILL.md` on their own; fold them in as
a separate step.
