# Reducto kept the low temperature that worked best for OCR and added checks for repetition 

- URL: https://www.instagram.com/reel/DePa7ZCFUVx/
- Date: 2026-10-08 10:01:13 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-10-12): 47 / 5

## Caption

Reducto kept the low temperature that worked best for OCR and added checks for repetition while the model was still writing. As you eval this, check that you're not cutting off legitimate repeated rows.

Comment “EVALS” and I’ll send you the free evals guide.

## Visual content

Source: automated media description returned by instagram-cli `media-understanding`. The CLI exposes no media file or frame, so the video/image was not viewed directly; the description below is the only visual evidence and is reproduced as returned.

A man in a blue shirt and glasses speaks directly to camera about why document parsing with vision-language models (VLMs) is prone to 'degenerate repetition loops.' He explains that when OCRing documents with repeated table rows, models trained on what they've already written will keep copying instead of moving forward. This is controlled by the 'temperature' parameter — higher temperature adds randomness to break loops, but lower temperature gives more accurate deterministic transcription, which is preferred for OCR. Because of this, systems like olmOCR use very low temperature, making them non-deterministic and susceptible to repetition.

He details two failure modes their detector missed: 1) long-period repetition where a large block (e.g., a 936-token table section) repeats multiple times, exceeding short-pattern detectors, and 2) repetition with predictable changes, like incrementing numbers (S10 to S11 to S12) or labels, which also evades simple matching. To handle this, he discusses the fallback tradeoff of setting a maximum token limit — stopping generation when reached. Citing a 40,000-page experiment where 219 outputs crossed 8,192 tokens (204 were pathological repetition, 15 were legitimate long outputs), he notes that treating the limit as failure avoids bad latency but risks cutting off valid dense pages like tables or multi-signature agreements. A reliable detector allows keeping a larger budget while still catching true loops.

The video concludes with a promotion for a 'FREE EVALS GUIDE' for evaluating OCR models.

### On-screen or spoken text quoted in the description

- [none quoted]

### Gaps

- Exact slide/overlay text, terminal output, table cells, and chart values beyond what the description quotes: [not visible]
