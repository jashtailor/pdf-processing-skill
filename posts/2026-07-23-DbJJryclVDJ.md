# Docling with RapidOCR moved data from a table cell into the header and left the row value 

- URL: https://www.instagram.com/reel/DbJJryclVDJ/
- Date: 2026-07-23 10:00:35 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-09-26): 50 / 2

## Caption

Docling with RapidOCR moved data from a table cell into the header and left the row value blank. The output looked reasonable, but the row was empty.

Gemini Flash kept `51` in the correct cell. A row-level check catches the first error because it tests the relationship, not just whether the value appears somewhere on the page.

I would use Gemini for this page because the application needs that cell.

See how other practitioners are building AI products and working through real production problems. The AI Product Engineering Community has a free trial: https://skool.com/ai-eng

## Visual content

Source: automated media description returned by instagram-cli `media-understanding`. The CLI exposes no media file or frame, so the video/image was not viewed directly; the description below is the only visual evidence and is reproduced as returned.

A male presenter with glasses speaks directly to camera about a common OCR failure mode. He explains that using the popular library Docling with RapidOCR often makes a subtle error on a table from the NAF Dataset Characteristics: it moves the value '51' (the number of form types for the Simple/Train split) up into the '# Form Types' header, leaving the actual train row cell blank. While the output initially looks reasonable because the number 51 still appears on the page, he demonstrates that a row-level validation test catches the mistake. In contrast, Google's Gemini Flash model correctly keeps the '51' in its proper cell. He concludes that for applications needing accurate cell extraction from PDFs, he would choose Gemini Flash because it is surprisingly good at turning PDFs into usable text, despite the Docling approach being more common.

### On-screen or spoken text quoted in the description

- [none quoted]

### Gaps

- Exact slide/overlay text, terminal output, table cells, and chart values beyond what the description quotes: [not visible]
