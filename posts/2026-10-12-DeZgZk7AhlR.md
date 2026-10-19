# Reading complex layouts or columns straight across can split two different paragraphs into

- URL: https://www.instagram.com/reel/DeZgZk7AhlR/
- Date: 2026-10-12 08:01:29 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-10-19): 33 / 3

## Caption

Reading complex layouts or columns straight across can split two different paragraphs into one sentence. PP-DocLayoutV3 takes a page image, finds blocks such as paragraphs and tables, and puts them in reading order. The Paddle team trained V3 to find the blocks and put them in order in one model.

Comment PDF and I’ll send you the course details.

## Visual content

Source: automated media description returned by instagram-cli `media-understanding`. The CLI exposes no media file or frame, so the video/image was not viewed directly; the description below is the only visual evidence and is reproduced as returned.

A presenter with glasses and a gray shirt speaks into a microphone in front of paintings, explaining a 'New model for reading order' for complex PDF layouts. He describes how PP-DocLayoutV3 takes a page image, finds blocks like paragraphs and tables, and reads them in a unique way—processing one column at a time from top to bottom before moving to the next column, rather than sorting by height alone. He illustrates that instead of using two separate models to find blocks and then order them, the Paddle team trained V3 to do both in one model using pairwise comparisons between blocks, which can run in parallel and sum estimates to determine order. He shows benchmark results from OmniDocBench v1.5 comparing 'Decoupled' versus 'Coupled' training, noting the coupled model made fewer ordering mistakes (RO score 0.041 vs 0.189). The video concludes with a call to action to comment 'PDF' for information about his upcoming course covering the full workflow from evaluating OCR to deploying your pipeline in production.

### On-screen or spoken text quoted in the description

- [none quoted]

### Gaps

- Exact slide/overlay text, terminal output, table cells, and chart values beyond what the description quotes: [not visible]
