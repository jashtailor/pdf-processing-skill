# PaddleOCR reads the dollar amounts in this IRS example, but it mixes up what years they go

- URL: https://www.instagram.com/reel/DecS5IkjwSA/
- Date: 2026-10-13 10:01:19 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-10-19): 23 / 0

## Caption

PaddleOCR reads the dollar amounts in this IRS example, but it mixes up what years they go with. It read all 3 amounts, so just checking the numbers wouldn’t catch the error. This doesn’t mean PaddleOCR is bad, Docling is good. You need to run your specific data on the models and see if the outputs match your use case.

Comment PDF and I’ll send you the course details.

## Visual content

Source: automated media description returned by instagram-cli `media-understanding`. The CLI exposes no media file or frame, so the video/image was not viewed directly; the description below is the only visual evidence and is reproduced as returned.

A presenter with glasses speaks into a microphone while showing screen captures of an IRS depreciation table. He demonstrates how PaddleOCR misreads the table: it loses the 'Year' labels, leaving the first two years blank and combining them as '2nd .... 3rd', and then incorrectly associates the deduction amounts ($2,033, $2,564, $2,564) with the wrong rows. He notes this happens because the OCR only reads numbers without context. He then shows that exporting the PDF at higher resolution and running it through Paddle's hosted demo improves results — the table structure is preserved with correct headers for Year, Basis, Percentage, and Deduction. However, he points out remaining inconsistencies like leading dollar signs and trailing periods that require post-processing to normalize. He concludes that PaddleOCR is a useful tool but users must validate outputs against their specific data, and promotes his upcoming 'PDF to Production' course covering the full workflow from evaluation to deployment.

### On-screen or spoken text quoted in the description

- [none quoted]

### Gaps

- Exact slide/overlay text, terminal output, table cells, and chart values beyond what the description quotes: [not visible]
