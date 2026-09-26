# Choosing an OCR model is hard when the score doesn't say what really went wrong.

- URL: https://www.instagram.com/reel/DdosHU2kZIG/
- Date: 2026-09-23 09:01:02 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-09-26): 18 / 0

## Caption

Choosing an OCR model is hard when the score doesn't say what really went wrong.

Datalab's OmniExtractBench draws 620 documents from four vendors' benchmarks. Its scorer shows which values matched, were misread, went missing, or were invented.

I tried it on a report: 60 matching values and one missing row label. I then deleted the first row of the casing table. Those values were marked missing, but the next row still matched.

More document news: https://isaacflath.com/news

## Visual content

Source: automated media description returned by instagram-cli `media-understanding`. The CLI exposes no media file or frame, so the video/image was not viewed directly; the description below is the only visual evidence and is reproduced as returned.

A presenter discusses the difficulty of choosing an OCR model because traditional benchmark scores don't explain what went wrong. He introduces Datalab's OmniExtractBench, a new benchmark designed to be more auditable and less vendor-biased. The bench contains 620 documents drawn from four vendor sources — including huge tables with repeated values, forms with fields, and research papers/filings — to reduce dependence on any single selection. Its scorer breaks down results into which values matched, were misread, missing, or invented, so users can understand why a model gets a score. To demonstrate, he runs Datalab's extractor on a Railroad Commission of Texas well pressure test report and scores it against expected answers; the tool reports 60 matching values and one missing row label, viewable in Excel with field, expected, returned, and verdict columns. He then deletes the first row of the casing table to test robustness; the scorer correctly marks those four values as missing while the next row still matches. He notes the benchmark code and scoring are on GitHub, with the full dataset stored on Hugging Face. The video ends with a promotion for his upcoming 'PDF to Production' course covering the full workflow from evaluating OCR to deploying pipelines, inviting viewers to comment 'PDF' for the syllabus.

### On-screen or spoken text quoted in the description

- [none quoted]

### Gaps

- Exact slide/overlay text, terminal output, table cells, and chart values beyond what the description quotes: [not visible]
