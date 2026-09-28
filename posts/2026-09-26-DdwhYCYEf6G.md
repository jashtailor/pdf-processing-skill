# Jina's new OCR model uses speculative decoding: a small draft model predicts tokens, then 

- URL: https://www.instagram.com/reel/DdwhYCYEf6G/
- Date: 2026-09-26 10:01:07 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-09-28): 789 / 3

## Caption

Jina's new OCR model uses speculative decoding: a small draft model predicts tokens, then the full OCR model checks several in one pass.

I checked three financial rows across three years with the hosted API. All nine values were under the correct years. The model weights have a noncommercial license.

Talk with Joe Barrow on speculative decoding: https://isaacflath.com/writing/speculative-decoding

## Visual content

Source: automated media description returned by instagram-cli `media-understanding`. The CLI exposes no media file or frame, so the video/image was not viewed directly; the description below is the only visual evidence and is reproduced as returned.

In this September 26, 2026 video, creator Isaac Flath (@isaac_flath) explains Jina AI's new jina-ocr-v1 model for faster document parsing on low-budget GPUs. He describes how Jina started with DeepSeek OCR and retrained it specifically on difficult scans, tables, and formulas using classifier-driven retrieval to find failure cases like multi-column headers, then used targeted synthesis to generate pages packed with tables and formulas since ordinary pages had too few examples. After training, they kept the main OCR model fixed and added a small draft model to predict next tokens, which the full model verifies in one pass — a technique called speculative decoding. Flath references his full talk with Joe Barrow on the topic (link in description). He demonstrates the hosted API on a standard earnings statement, checking three financial rows across three years; all nine values appeared under the correct years, including the negative investment result for 2022. He notes the model weights are released under a non-commercial CC-BY-NC-4.0 license, requiring users to contact Jina AI for commercial product use.

### On-screen or spoken text quoted in the description

- [none quoted]

### Gaps

- Exact slide/overlay text, terminal output, table cells, and chart values beyond what the description quotes: [not visible]
