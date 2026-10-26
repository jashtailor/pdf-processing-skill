# Docling puts this drug table into Markdown, which doesn’t handle spanned rows. One of the 

- URL: https://www.instagram.com/reel/Dezk6tWCALQ/
- Date: 2026-10-22 11:01:11 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-10-26): 19 / 1

## Caption

Docling puts this drug table into Markdown, which doesn’t handle spanned rows. One of the longer headers splits into a second cell.

## Visual content

Source: automated media description returned by instagram-cli `media-understanding`. The CLI exposes no media file or frame, so the video/image was not viewed directly; the description below is the only visual evidence and is reproduced as returned.

A presenter discusses why OCR often struggles with a specific drug adverse-events table. He shows Table 1 from a GOPRELTO clinical study, noting that each system organ class (e.g., Nervous System Disorders, Respiratory, Thoracic, and Mediastinal Disorders) uses a merged cell spanning four columns. When tools like Docling convert this to Markdown—which does not support row spans—they place the merged label in the first cell. That usually works, but for longer headers like 'Respiratory, Thoracic, and Mediastinal Disorders,' the word 'Disorders' gets split into a second cell, creating an edge case. Any software processing the table must detect and handle this stray text before performing numeric calculations, because you cannot reliably parse values like '7 (3%)' when non-numeric text appears in the same column. He notes that vision-language models outputting HTML typically preserve the merged structure correctly, keeping headings together as intended.

### On-screen or spoken text quoted in the description

- [none quoted]

### Gaps

- Exact slide/overlay text, terminal output, table cells, and chart values beyond what the description quotes: [not visible]
