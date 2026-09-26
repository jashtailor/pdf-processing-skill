# MinerU 4.0 gives an agent a way to read a long PDF without loading it into every prompt.

- URL: https://www.instagram.com/reel/DdrKCsgiFve/
- Date: 2026-09-24 08:01:02 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-09-26): 140 / 6

## Caption

MinerU 4.0 gives an agent a way to read a long PDF without loading it into every prompt.

I tested it on a 23-page financing agreement, using the text already stored in the PDF. Each passage got an address containing its document, page, and block number. I used that address to retrieve just the payment clause.

Keyword search with SQLite, then fetch the passage with the answer. All done locally.

More document news: https://isaacflath.com/news

## Visual content

Source: automated media description returned by instagram-cli `media-understanding`. The CLI exposes no media file or frame, so the video/image was not viewed directly; the description below is the only visual evidence and is reproduced as returned.

A presenter explains the release of MinerU 4.0, highlighting its new feature: a local document library for agent reading. He states the tool allows an AI agent to answer questions about a long PDF without loading the entire document into every prompt. As MinerU 4 parses PDFs, it builds a local keyword search index in SQLite. An agent can then find a matching document and read individual pages or passages, providing basic document search and retrieval without building an indexing pipeline manually. He demonstrates by testing on a 23-page Financing Agreement between the Republic of Ghana and the International Development Association dated August 25, 2006. MinerU reads the already-stored text and assigns each passage an address containing document, page, and block number (e.g., doc:7eaab90/tier:flash/page:2/block:13). Using that address, he retrieves only the payment clause stating payments are due on May 15 and November 15. This enables keyword search with SQLite and fetching just the relevant passage without sending the entire agreement into the next prompt. He emphasizes all processing is done locally and invites viewers to follow for better document workflows.

### On-screen or spoken text quoted in the description

- [none quoted]

### Gaps

- Exact slide/overlay text, terminal output, table cells, and chart values beyond what the description quotes: [not visible]
