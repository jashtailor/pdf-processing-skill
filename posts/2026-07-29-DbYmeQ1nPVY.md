# Basic extraction turned these grouped bar charts into text I couldn't use. A VLM reconstru

- URL: https://www.instagram.com/reel/DbYmeQ1nPVY/
- Date: 2026-07-29 10:01:05 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-09-26): 53 / 12

## Caption

Basic extraction turned these grouped bar charts into text I couldn't use. A VLM reconstructed all 50 bars as CSV estimates, with one row per chart group and frequency band.

Comment "OCR" and I'll send you two articles on choosing an OCR model and using VLMs for hard documents.

## Visual content

Source: automated media description returned by instagram-cli `media-understanding`. The CLI exposes no media file or frame, so the video/image was not viewed directly; the description below is the only visual evidence and is reproduced as returned.

A man with glasses and a dark shirt speaks directly to camera in an indoor setting with artwork behind him, explaining a technical workflow for extracting chart data. The video opens with on-screen text 'Extract chart data with OCR' and shows an example from the Morbidity and Mortality Weekly Report (2011) featuring grouped bar charts on fruit and vegetable consumption by race/ethnicity. He explains that basic OCR extraction fails to turn these charts into usable data, and a generic Gemini 3.5 Flash run only describes the bars in prose, which is better but not useful. He then instructs Gemini to reconstruct the charts as a CSV with one row per chart, group, and frequency band. The resulting output, shown as code on screen, contains all 50 bars with estimated percentages marked as 'bar_height_estimate'. He notes this is useful when source data is unavailable, though values are not exact because the chart does not print numbers, and for exact reporting the original dataset is still needed. He concludes that having the figures in CSV format is extremely helpful for agents to perform additional actions and for citations, and promotes his articles on choosing OCR models and vision-language models for hard OCR tasks, asking viewers to comment 'OCR' for the link.

### On-screen or spoken text quoted in the description

- [none quoted]

### Gaps

- Exact slide/overlay text, terminal output, table cells, and chart values beyond what the description quotes: [not visible]
