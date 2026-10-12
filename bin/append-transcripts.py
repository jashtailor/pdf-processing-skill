#!/usr/bin/env python3
"""Append transcripts of new posts/*.md files to TRANSCRIPTS.md.

Reads posts/*.md (same format as the weekly sync writes), skips files whose
<!-- file: <name> --> marker already exists in TRANSCRIPTS.md, and appends the
rest in filename (date) order. Idempotent: running twice appends nothing.

Stdout final line: APPENDED=<n>
"""
import glob
import os
import re
import sys

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
POSTS = os.path.join(REPO, "posts")
TRANSCRIPTS = os.path.join(REPO, "TRANSCRIPTS.md")


def entry_for(path):
    name = os.path.basename(path)
    text = open(path, encoding="utf-8").read()

    m = re.match(r"^# (.+)$", text, re.M)
    title = m.group(1).strip() if m else name

    def field(n):
        mm = re.search(r"^- %s: (.+)$" % n, text, re.M)
        return mm.group(1).strip() if mm else ""

    url = field("URL")
    date = field("Date").split(" (as returned")[0]
    ptype = field("Type")
    author = field("Author")

    cap = ""
    cm = re.search(r"^## Caption\s*\n\n(.*?)(?=\n## |\Z)", text, re.S | re.M)
    if cm:
        cap = cm.group(1).strip()
    vis = ""
    vm = re.search(r"^## Visual content\s*\n\n(.*?)(?=\n## |\Z)", text, re.S | re.M)
    if vm:
        vis = vm.group(1).strip()

    lines = ["<!-- file: %s -->" % name, "### %s" % title, ""]
    if date:
        lines.append("- Date: %s" % date)
    if ptype:
        lines.append("- Type: %s" % ptype)
    if author:
        lines.append("- Author: %s" % author)
    if url:
        lines.append("- URL: %s" % url)
    lines.append("")
    lines.append("**Caption:** %s" % (cap if cap else "[no caption]"))
    lines.append("")
    lines.append("**On screen:** %s" % (vis if vis else "[no visual description]"))
    lines.append("")
    return "\n".join(lines)


def main():
    if not os.path.isfile(TRANSCRIPTS):
        sys.stderr.write("append-transcripts: TRANSCRIPTS.md missing\n")
        print("APPENDED=0")
        return

    existing = open(TRANSCRIPTS, encoding="utf-8").read()
    done = set(re.findall(r"<!-- file: (\S+) -->", existing))

    added = 0
    with open(TRANSCRIPTS, "a", encoding="utf-8") as fh:
        for path in sorted(glob.glob(os.path.join(POSTS, "*.md"))):
            name = os.path.basename(path)
            if name in done:
                continue
            fh.write(entry_for(path) + "\n")
            added += 1

    print("APPENDED=%d" % added)


if __name__ == "__main__":
    main()
