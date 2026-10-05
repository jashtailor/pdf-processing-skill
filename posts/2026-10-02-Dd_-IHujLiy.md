# Docling returns the adult immunization schedule as a Markdown table, but removes the color

- URL: https://www.instagram.com/reel/Dd_-IHujLiy/
- Date: 2026-10-02 10:00:37 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-10-05): 32 / 1

## Caption

Docling returns the adult immunization schedule as a Markdown table, but removes the colors that define the recommendations.

The MenACWY Pregnancy cell looks empty. On the source page, its gray color means “No guidance / Not applicable.” Color-aware extraction preserves that meaning.

https://isaacflath.com/pdf2production

## Visual content

Source: automated media description returned by instagram-cli `media-understanding`. The CLI exposes no media file or frame, so the video/image was not viewed directly; the description below is the only visual evidence and is reproduced as returned.

In this 2026 educational video, creator Isaac Flath (@isaac_flath) demonstrates a failure mode in the Docling table-extraction model when processing the CDC's Recommended Adult Immunization Schedule by Medical Condition or Other Indication, United States, 2025. Speaking to camera with the chart displayed behind him, he explains that Docling returns the full Markdown table but strips out the colors that define the recommendations. He highlights the MenACWY row under the Pregnancy column, which appears as an empty cell in the Markdown output. On the original source page, that same cell is gray, and the legend defines gray as 'No Guidance / Not Applicable.' By removing the color, the semantic meaning is lost. He then contrasts this with Qwen 3 VL, which returns structured JSON that identifies the cell as gray, marks its content as null, and explicitly maps it to 'No Guidance/Not Applicable' per the legend. The video concludes that color-aware extraction preserves the meaning of blank-looking cells because the color legend is retained on the page.

### On-screen or spoken text quoted in the description

- [none quoted]

### Gaps

- Exact slide/overlay text, terminal output, table cells, and chart values beyond what the description quotes: [not visible]
