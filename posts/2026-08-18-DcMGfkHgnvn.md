# One OCR bounding box can take 13 tokens. With normal LLM decoding, that means 13 forward p

- URL: https://www.instagram.com/reel/DcMGfkHgnvn/
- Date: 2026-08-18 10:02:12 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-09-26): 93 / 6

## Caption

One OCR bounding box can take 13 tokens. With normal LLM decoding, that means 13 forward passes.

Speculative decoding lets a small model guess several tokens ahead. The larger model checks them in one pass, keeps the correct prefix, and replaces the first wrong token. 

Comment “SpecDecode” for the full post.

## Visual content

Source: automated media description returned by instagram-cli `media-understanding`. The CLI exposes no media file or frame, so the video/image was not viewed directly; the description below is the only visual evidence and is reproduced as returned.

In this short educational video posted August 18, 2026 by AI creator Isaac Flath (@isaac_flath), the presenter explains how to decrease LLM latency using speculative decoding. He begins by noting that normally an LLM generates one token per forward pass, then illustrates the cost with an example: a single bounding box output '[12 24 48 53]' requires 13 tokens (8 numbers, 2 brackets, 3 spaces), meaning 13 forward passes. He introduces speculative decoding as a technique where a small draft model guesses several tokens ahead, and a large model verifies them all in one pass left-to-right. Using the sentence 'I like cooking and traveling,' he shows the draft guessing correctly for 'I like,' but the big model rejecting 'cooking' in favor of 'playing.' The system swaps in the correct token and discards everything after the error, yielding three accepted tokens in one pass instead of one. When the draft guesses well, the speedup is much greater. The video closes with a call to action to comment 'SpecDecode' for a full talk and write-up. The tone is informative and technical, aimed at developers interested in AI product performance.

### On-screen or spoken text quoted in the description

- [none quoted]

### Gaps

- Exact slide/overlay text, terminal output, table cells, and chart values beyond what the description quotes: [not visible]
