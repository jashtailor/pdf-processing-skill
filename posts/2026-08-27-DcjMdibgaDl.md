# Plain text extraction can’t handle charts like this FDIC chart and only gives surrounding 

- URL: https://www.instagram.com/reel/DcjMdibgaDl/
- Date: 2026-08-27 09:16:34 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-09-26): 232 / 27

## Caption

Plain text extraction can’t handle charts like this FDIC chart and only gives surrounding prose

Docling preserves the prose and marks the chart as a bounding box for an image placeholder. Crop that region, send it to a VLM, and convert the result to CSV. The VLM estimates all 80 quarterly values even though most bars have no labels.

Chandra (VLM) can process the full page in one pass and returns the text plus chart data as an HTML table. But it only gave 20 annual values, not all 80 quarterly ones.

For documents driven by charts and figures, I’d use a VLM and tune the prompt for complete extraction.  If charts and figures are only occasionally present i'd try a cheaper pipleline approach

I’m teaching a full-day PDF to Production course with Joe Barrow soon. Comment "PDF" to see the syllabus.

## Visual content

Source: automated media description returned by instagram-cli `media-understanding`. The CLI exposes no media file or frame, so the video/image was not viewed directly; the description below is the only visual evidence and is reproduced as returned.

A male presenter with glasses, identified as Isaac Flath, explains how to extract data from charts in PDFs, using an FDIC Chart 8 showing Unrealized Gains (Losses) on Investment Securities from 2006 to 2025. He demonstrates that plain text extraction only captures surrounding prose, while Docling preserves the prose and marks the chart as an image placeholder with a bounding box, allowing the chart to be cropped and sent to a VLM to convert to CSV with estimated quarterly values. He contrasts this with Chandra (a VLM) processing the full page in one pass, which returns text and chart data as an HTML table but only provides 20 annual data points instead of all 80 quarterly ones. He concludes that for extremely data-chart-driven documents, a VLM with tuned prompts is preferable, and promotes his upcoming full-day "PDF to Production" course covering OCR model choices, pipelines, observability, evaluation, deployment, and vendor selection, inviting viewers to comment "PDF" for the syllabus.

### On-screen or spoken text quoted in the description

- "PDF to Production"
- "PDF"

### Gaps

- Exact slide/overlay text, terminal output, table cells, and chart values beyond what the description quotes: [not visible]
