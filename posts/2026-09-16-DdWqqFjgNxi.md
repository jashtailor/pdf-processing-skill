# OCR treats this table as empty even though the color gives it the answer. Gray means "no g

- URL: https://www.instagram.com/reel/DdWqqFjgNxi/
- Date: 2026-09-16 09:01:47 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-09-26): 37 / 3

## Caption

OCR treats this table as empty even though the color gives it the answer. Gray means "no guidance/not applicable."

Docling reads the labels but doesn't record what gray means. Qwen identifies the gray cell and returns it as null, but also returns the category. I would store that category rather than a missing value.

Comment "OCR" and I’ll send you my guides on choosing an OCR model and VLMs for hard documents.

## Visual content

Source: automated media description returned by instagram-cli `media-understanding`. The CLI exposes no media file or frame, so the video/image was not viewed directly; the description below is the only visual evidence and is reproduced as returned.

In this educational video, creator Isaac Flath explains a common pitfall in document extraction using the CDC's 2025 Recommended Adult Immunization Schedule. He points out that gray cells in the table are not missing data—they carry meaning per the legend as 'No Guidance / Not Applicable.' Traditional OCR tools like Docling read the row and column labels but drop the color, treating the gray cell as empty and discarding information. In contrast, the vision-language model Qwen identifies the gray cell, returns its content as null, but also preserves the interpretation that it means 'No Guidance/Not Applicable.' Flath argues this category should be stored rather than treated as missing, emphasizing that many schedules (events, employee, services) use color coding where meaning depends on cell color, not just values. He concludes by offering two guides on choosing OCR models and VLMs for hard OCR tasks and invites viewers to comment 'OCR' for access.

### On-screen or spoken text quoted in the description

- [none quoted]

### Gaps

- Exact slide/overlay text, terminal output, table cells, and chart values beyond what the description quotes: [not visible]
