# How to combine different search and retrieval types. This shows keyword/semantic example b

- URL: https://www.instagram.com/reel/DaTEQyHiMLI/
- Date: 2026-07-02 09:55:41 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-09-26): 6 / 0

## Caption

How to combine different search and retrieval types. This shows keyword/semantic example but it applies to all kinds of search that has any kind of metric score or order to it.

Part of my RAG course on boot.dev :)

## Visual content

Source: automated media description returned by instagram-cli `media-understanding`. The CLI exposes no media file or frame, so the video/image was not viewed directly; the description below is the only visual evidence and is reproduced as returned.

A male presenter wearing glasses and a black shirt speaks directly to camera against a dark blue background, explaining how to combine results from different search algorithms. He illustrates the problem using Keyword Search (Document A=15, B=8, C=6) versus Semantic Search (A=0.8, B=0.3, C=0.2), noting the incomparable score ranges. He introduces Reciprocal Rank Fusion (RRF) as a method that uses only ranking position, not raw scores, via the formula rrf_score = 1 / (k + rank). He demonstrates calculations with k=1 (scores 0.5, 0.33, 0.25, 0.2) and k=100 (scores ~0.0099 to 0.0096), explaining that higher k flattens differences. He notes k=60 is a common default. The video is part of his RAG course on boot.dev, presented in a straightforward instructional tone with animated text overlays.

### On-screen or spoken text quoted in the description

- [none quoted]

### Gaps

- Exact slide/overlay text, terminal output, table cells, and chart values beyond what the description quotes: [not visible]
