# Xiaomi used 8 OCR models to create training data. Qwen repairs disputed examples, then the

- URL: https://www.instagram.com/reel/DeR_sjSkUJX/
- Date: 2026-10-09 10:00:59 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-10-12): 36 / 1

## Caption

Xiaomi used 8 OCR models to create training data. Qwen repairs disputed examples, then the repaired answer goes through the agreement check again. I like that they're checking the repair, though models can still agree on the wrong answer.

Comment “PDF” and I’ll send you the course syllabus.

## Visual content

Source: automated media description returned by instagram-cli `media-understanding`. The CLI exposes no media file or frame, so the video/image was not viewed directly; the description below is the only visual evidence and is reproduced as returned.

A presenter with glasses and a blue shirt explains Xiaomi's approach to building a small OCR model using a 'council' of eight different OCR models. He describes how they take a table image, have all eight models convert it to HTML with correct text and layout, then compare the outputs. They rank the results by similarity to the other seven, keep the top three, and if those three are very similar, select the middle one as the labeled training example. For cases with low agreement, they use Qwen 3.5 to verify similarity against the original table image, then iteratively correct the HTML by rendering it and comparing it back to the source, repeating until satisfied. If agreement remains low after automated correction, the sample goes to human review. He notes this mitigates the risk that all models could agree on the same wrong answer for difficult documents. The video concludes with a promotion for his upcoming 'PDF to Production' course covering the full OCR evaluation-to-deployment workflow.

### On-screen or spoken text quoted in the description

- [none quoted]

### Gaps

- Exact slide/overlay text, terminal output, table cells, and chart values beyond what the description quotes: [not visible]
