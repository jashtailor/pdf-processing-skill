# Chandra reads these numbers correctly, but it shifts the headers around. The annual figure

- URL: https://www.instagram.com/reel/DeubTjbAdza/
- Date: 2026-10-20 11:00:46 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-10-26): 27 / 1

## Caption

Chandra reads these numbers correctly, but it shifts the headers around. The annual figure, 744.7, ends up under Q1.

## Visual content

Source: automated media description returned by instagram-cli `media-understanding`. The CLI exposes no media file or frame, so the video/image was not viewed directly; the description below is the only visual evidence and is reproduced as returned.

A presenter in a dark shirt and glasses speaks into a microphone while displaying screenshots of a financial table with years and quarters (2023, 2024, Q1-Q4, 2025). He explains that '2024 appears twice' in the Fed table — once for the annual total and once above the four quarterly columns — which causes problems for OCR and software agents trying to extract it correctly. He demonstrates how a VLM called Chandra reads the numbers accurately but shifts the headers: the annual figure 744.7 ends up under the Q1 header, the 2024 header spans only two columns instead of four, so Q3 and Q4 of 2024 are mislabeled as 2025, and 2025 Q1/Q2 get no year label. He notes this malformed output could be caught by a column check because the data rows have more columns than the header rows. In contrast, he shows that on the same page, Gemini 3.5 Flash gets all the headers correct and matches them properly, proving the page can be extracted well.

### On-screen or spoken text quoted in the description

- [none quoted]

### Gaps

- Exact slide/overlay text, terminal output, table cells, and chart values beyond what the description quotes: [not visible]
