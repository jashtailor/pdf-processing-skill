# Structured OCR extraction fails on this printed clinical note by rewriting one lab instead

- URL: https://www.instagram.com/reel/Dc_mRbGAAgr/
- Date: 2026-09-07 10:01:06 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-09-26): 59 / 17

## Caption

Structured OCR extraction fails on this printed clinical note by rewriting one lab instead of transcribing the characters exactly.

Gemini 3.5 Flash changes the printed "HCO: 3:21" to "HCO3": "21". Docling with RapidOCR and Chandra return the correct values.

You really need to evaluate on your own problem because it's not a magic bullet that works in every situation.

If you need to build a reliable workflow or product on top of documents, comment PDF and I'll send you the full curriculum.

## Visual content

Source: automated media description returned by instagram-cli `media-understanding`. The CLI exposes no media file or frame, so the video/image was not viewed directly; the description below is the only visual evidence and is reproduced as returned.

A male presenter with glasses explains a failure case for large vision-language models doing OCR on a printed clinical note dated 2026-09-07. He shows that structured OCR extraction fails by rewriting the lab value "HCO: 3:21" instead of transcribing it exactly. When feeding the PDF to Gemini 3.5 Flash with a targeted extraction prompt, the model returns JSON with labs, but incorrectly changes the key and value to "HCO3": "21", losing the original punctuation and character order. In contrast, Docling with RapidOCR and Chandra correctly return "HCO: 3:21". He argues that using big Gemini models is not a magic bullet for every document problem, and viewers should evaluate on their own data. He closes by inviting viewers to comment "PDF" to receive his full curriculum for building reliable document workflows.

### On-screen or spoken text quoted in the description

- "HCO: 3:21"
- "HCO3"
- ", losing the original punctuation and character order. In contrast, Docling with RapidOCR and Chandra correctly return "
- ". He argues that using big Gemini models is not a magic bullet for every document problem, and viewers should evaluate on their own data. He closes by inviting viewers to comment "

### Gaps

- Exact slide/overlay text, terminal output, table cells, and chart values beyond what the description quotes: [not visible]
