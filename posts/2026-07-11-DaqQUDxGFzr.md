# If the agent misses the Authlib decision context, it may invent a plausible reason instead

- URL: https://www.instagram.com/reel/DaqQUDxGFzr/
- Date: 2026-07-11 10:02:53 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-09-26): 7 / 0

## Caption

If the agent misses the Authlib decision context, it may invent a plausible reason instead. The real bug is often retrieval.

Full video: https://youtu.be/s7wUwD6LC-o
Community: skool.com/ai-eng

## Visual content

Source: automated media description returned by instagram-cli `media-understanding`. The CLI exposes no media file or frame, so the video/image was not viewed directly; the description below is the only visual evidence and is reproduced as returned.

A man with glasses speaks directly to camera in front of a microphone, with on-screen text reading 'Hallucination == Bad Retrieval.' He explains a common AI engineering issue: when an agent is asked why a choice like 'Authlib' was made, it performs a semantic search and code tools like grep/ripgrep to retrieve context. If the retrieval step fails to find the correct code snippet, the generation step sees unrelated code or comments and then 'hallucinates' plausible-sounding reasons why most people choose Authlib. He argues these outputs look like hallucinations but the root cause is bad retrieval—the context-building step didn't bring in the right information. The tone is educational and explanatory, aimed at developers working on AI agents, with no jokes, profanity, or controversial content.

### On-screen or spoken text quoted in the description

- [none quoted]

### Gaps

- Exact slide/overlay text, terminal output, table cells, and chart values beyond what the description quotes: [not visible]
