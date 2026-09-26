# If the model gets weak context, the generation step has to guess. A lot of generation bugs

- URL: https://www.instagram.com/reel/DanrlRXk1qO/
- Date: 2026-07-10 10:04:00 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-09-26): 3 / 0

## Caption

If the model gets weak context, the generation step has to guess. A lot of generation bugs are context-building bugs.

Full video: https://youtu.be/s7wUwD6LC-o
Community: skool.com/ai-eng

## Visual content

Source: automated media description returned by instagram-cli `media-understanding`. The CLI exposes no media file or frame, so the video/image was not viewed directly; the description below is the only visual evidence and is reproduced as returned.

In this educational clip, presenter Isaac Flath explains why AI models produce bad outputs, focusing on three issues listed on a pink slide: Hallucinations (the model made up a support policy), Context Rot (bad output), and Latency (where was the issue). He argues hallucinations happen because the model is overconfident and invents answers instead of retrieving correct context. For context rot, he explains the context window becomes large and slow because the system performs multiple retrievals—grepping, web searching, and semantic searching—to get top hits. If it finds the right files faster and more accurately, the model not only gives a better answer but uses a higher percentage of relevant context. He then shows a flowchart titled 'Retrieval in Agents,' distinguishing the upper 'context building step' (query/task, grep, web search, semantic search) from the lower 'generation' step where the final output is produced. He emphasizes that many generation-looking problems are actually caused by the context-building phase, which is the current focus of his work.

### On-screen or spoken text quoted in the description

- [none quoted]

### Gaps

- Exact slide/overlay text, terminal output, table cells, and chart values beyond what the description quotes: [not visible]
