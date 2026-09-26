# When the relevant document is ranked seventh, you can return more results or sort better. 

- URL: https://www.instagram.com/reel/DavaKGMig7D/
- Date: 2026-07-13 10:05:27 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-09-26): 12 / 0

## Caption

When the relevant document is ranked seventh, you can return more results or sort better. If the extra results are noisy, a reranker is probably the better fix.

Full video: https://youtu.be/s7wUwD6LC-o
Community: skool.com/ai-eng

## Visual content

Source: automated media description returned by instagram-cli `media-understanding`. The CLI exposes no media file or frame, so the video/image was not viewed directly; the description below is the only visual evidence and is reproduced as returned.

A male presenter with glasses, identified as Isaac Flath, delivers an educational walkthrough on improving retrieval-augmented generation search architecture. He explains a diagnostic scenario where a semantic search returned the top five documents, but the truly relevant document was ranked seventh. From this, he outlines two solutions: simply return seven or more documents from the semantic search, which increases token usage and latency but ensures relevance if all seven are needed; or improve sorting by adding a re-ranker layer. He details how a re-ranker works after initial keyword and semantic search combined via reciprocal rank fusion, using a slower but more accurate model like a cross-encoder to re-sort results based on the query. Visuals show pink flowchart boxes being built in real-time alongside his explanation, illustrating the problem and the two architectural fixes. The tone is instructional and calm, aimed at builders optimizing document retrieval systems.

### On-screen or spoken text quoted in the description

- [none quoted]

### Gaps

- Exact slide/overlay text, terminal output, table cells, and chart values beyond what the description quotes: [not visible]
