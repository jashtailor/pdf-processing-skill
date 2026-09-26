# Text OCR can read the times in the schedule, but it's not a queryable timetable. VLMs are 

- URL: https://www.instagram.com/reel/DcthQ2zDCuh/
- Date: 2026-08-31 09:30:48 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-09-26): 74 / 8

## Caption

Text OCR can read the times in the schedule, but it's not a queryable timetable. VLMs are often much more expensive and slow, so we'll use this as an example to reduce cost.

Chandra 2, a VLM, gives the full 13-stop by 10-departure table, skips the right stops, and places the first Eaglesham departure at 8:38. But PaddleOCR's PP-StructureV3 pipeline gives the same thing without the VLM, which often means faster and cheaper.

In this case, on the single page, it was 46% faster and 78% cheaper. That was me running it on reasonable infrastructure in a scale-to-zero pipeline on Modal.

If you need to optimize your pipeline not just for accuracy, but also cost and latency, check out our full course, where we cover all this and more in detail on your PDFs.

Comment “PDF” and I’ll send you the course details.

## Visual content

[not visible] The media-understanding service returned an empty description for this item after three attempts, and the CLI exposes no media URL, so the visual content could not be transcribed. Only the caption above is available.
