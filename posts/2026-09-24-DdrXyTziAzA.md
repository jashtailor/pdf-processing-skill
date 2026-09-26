# LiteParse extracts PDF text quickly. LlamaIndex reports about 3 milliseconds per page with

- URL: https://www.instagram.com/reel/DdrXyTziAzA/
- Date: 2026-09-24 10:01:08 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-09-26): 55 / 5

## Caption

LiteParse extracts PDF text quickly. LlamaIndex reports about 3 milliseconds per page with OCR off, meaning just the text layer.

I tested it on Berkshire Hathaway's earnings statements. needsOcr was false, and the layout flags said table-likely. Revenue, investment, and expense totals matched across all three years, but the insurance premiums and sales rows merged into one.

You could route table-likely pages to a table parser, or use table-block bounding boxes to send just the region you need.

More document news: https://isaacflath.com/news

## Visual content

Source: automated media description returned by instagram-cli `media-understanding`. The CLI exposes no media file or frame, so the video/image was not viewed directly; the description below is the only visual evidence and is reproduced as returned.

In this 2026 social media video, creator Isaac Flath (@isaac_flath) demonstrates the open-source tool LiteParse, which extracts PDF text very quickly and flags pages that might need OCR or advanced processing. He cites LlamaIndex reporting about 3 milliseconds per page with OCR off (just the text layer). To test it, he runs LiteParse on Berkshire Hathaway's earnings statements. The JSON result shows 'needsOcr: false' and a layout flag of 'table-likely'. Extracting without OCR, revenue, investment, and expense totals matched across all three years, but the tool merged the 'Insurance premiums earned' and 'Sales and service revenues' rows into a single row instead of two. As fixes, he suggests routing every 'table-likely' flagged page to a dedicated table parser, or more efficiently, enabling table blocks in the library to get bounding boxes for detected tables and cropping just those regions for parsing. The video ends with a call to follow for better document workflows.

### On-screen or spoken text quoted in the description

- [none quoted]

### Gaps

- Exact slide/overlay text, terminal output, table cells, and chart values beyond what the description quotes: [not visible]
