# Document News!  Unstructured now generates image descriptions as metadata for search. In m

- URL: https://www.instagram.com/reel/DcyZsHbD4Uz/
- Date: 2026-09-02 07:01:02 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-09-26): 50 / 0

## Caption

Document News!  Unstructured now generates image descriptions as metadata for search. In my test, the descriptions preserved the exact labels on a NASA systems diagram, but missed the printed elevation 5,414 on a topographic map and substituted nearby BM 4668. For graphs without numeric labels, the returned values were useful visual estimates.

https://isaacflath.com/news

## Visual content

Source: automated media description returned by instagram-cli `media-understanding`. The CLI exposes no media file or frame, so the video/image was not viewed directly; the description below is the only visual evidence and is reproduced as returned.

A man with glasses and a dark shirt presents 'Document News' about Unstructured now generating image descriptions as searchable metadata. He explains that images inside documents—diagrams, maps, charts—contain useful information invisible to retrieval unless manually processed, and Unstructured will now auto-describe them so retrievers can index and search them. He tests the feature on three types of images: a NASA systems engineering diagram, where the prose correctly preserved all three process groups and exact labels needed to answer visual questions; a topographic map of Ensien Peak, where the description recognized the peak but omitted the printed elevation 5,414 and instead used nearby BM 4668, raising the question of whether every label should be in prose; and a Youth Physical Activity bar chart, where Unstructured returned visual estimates of percentages in prose (e.g., Hispanic ~20%, Other/Multiple ~22%, non-white ~12%). He concludes it is a useful tool to embed alongside normal page text to improve search, then verify exact values against the original visual, calling it nice to have in one step rather than bounding boxes and sending to another VLM.

### On-screen or spoken text quoted in the description

- [none quoted]

### Gaps

- Exact slide/overlay text, terminal output, table cells, and chart values beyond what the description quotes: [not visible]
