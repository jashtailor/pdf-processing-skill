# An agent answered with an old refund policy, because the current version was ranked too lo

- URL: https://www.instagram.com/reel/DblegRdDTSB/
- Date: 2026-08-03 10:01:35 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-09-26): 24 / 0

## Caption

An agent answered with an old refund policy, because the current version was ranked too low to be included in context. The context builder kept only ranks one and two, so the model never saw the current policy. The failure happened in retrieval before generation.

To fix, I would see if historical revisions belong in the corpus at all and remove if not.  Or add a boost to retrieval score based on the date published or updated. I log document ID, rank, source version, and status so I can debug where the problems are in this way.

Get useful notes on building AI products that work in real use: https://isaacflath.com/subscribe

## Visual content

Source: automated media description returned by instagram-cli `media-understanding`. The CLI exposes no media file or frame, so the video/image was not viewed directly; the description below is the only visual evidence and is reproduced as returned.

A man with glasses and a dark shirt speaks directly to camera in an indoor setting, explaining how he debugged an agent that used an old refund policy. The screen above him displays a SQL query selecting rank, source_id, score, selected, and source_version from retrieval_candidates where run_id='r_104' ordered by rank. The returned rows show rank 1 as policy_old (refund-policy@rev-18, selected True), rank 2 as faq_refunds (returns-faq@rev-8, selected True), and rank 7 as policy_current (refund-policy@rev-19, selected False, score 0.74). He explains that the search found the correct current revision at rank seven, but the context builder only kept ranks one and two, so the model never saw the correct current policy. He states the trace localizes the failure to the retrieval pipeline before generation, noting the current document ranked too low and the selection cutoff dropped it off, though it doesn't explain why it ranked seventh. He proposes solutions: first check if historical data needs to be in the corpus and remove old revisions if not, or if that's not possible, boost retrieval records based on how recently they were updated. He adds that in his agentic system he logs document ID, rank, source, version, and status to determine why an agent gave a poor answer, what step failed, and to build hypotheses for fixes. He concludes by promoting his work helping people build reliable AI products and invites viewers to subscribe at IsaacFlath.com/subscribe.

### On-screen or spoken text quoted in the description

- [none quoted]

### Gaps

- Exact slide/overlay text, terminal output, table cells, and chart values beyond what the description quotes: [not visible]
