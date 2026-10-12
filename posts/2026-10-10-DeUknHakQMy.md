# Docling with SmolVLM misreads this NTSB driver timeline. I kept Docling and swapped in Qwe

- URL: https://www.instagram.com/reel/DeUknHakQMy/
- Date: 2026-10-10 10:02:02 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-10-12): 1 / 2

## Caption

Docling with SmolVLM misreads this NTSB driver timeline. I kept Docling and swapped in Qwen3-VL for the image reading. On this chart, it gets the labels and durations right.

Comment “PDF” and I’ll send you the course syllabus.

## Visual content

Source: automated media description returned by instagram-cli `media-understanding`. The CLI exposes no media file or frame, so the video/image was not viewed directly; the description below is the only visual evidence and is reproduced as returned.

A presenter in a blue shirt and glasses explains how he used OCR to extract data from an NTSB 'Ford Driver Disengagement: San Antonio' crash chart showing where a driver was looking in the 5 seconds before impact. Using Docling with its default small vision model (SmolVLM), the system completely misread the chart — labeling the pink 'Infotainment Console' bar as 'Crash,' calling the middle blue 0.4-second glance 'half a second,' and reading the final 0.2-second forward-roadway glance as '-1.5 seconds.' He then switched to the larger Qwen3-VL model within Docling, which still found the chart but correctly read all values: Infotainment Console 1.4s, Forward roadway 0.4s, Infotainment Console 1.6s, Forward roadway 0.4s, Infotainment Console 1.0s, Forward roadway 0.2s. With accurate data, he calculates the driver had eyes on the road for only about 1 second of the 5 seconds before the crash. The video ends with a promotion for his 'PDF to Production' course covering OCR evaluation to deployment.

### On-screen or spoken text quoted in the description

- [none quoted]

### Gaps

- Exact slide/overlay text, terminal output, table cells, and chart values beyond what the description quotes: [not visible]
