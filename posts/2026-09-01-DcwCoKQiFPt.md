# Oh wow, AWS Textract read all 19 labels in this rotated patent flowchart but lost the edge

- URL: https://www.instagram.com/reel/DcwCoKQiFPt/
- Date: 2026-09-01 09:00:49 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-09-26): 263 / 81

## Caption

Oh wow, AWS Textract read all 19 labels in this rotated patent flowchart but lost the edges. Chandra 2 produced Mermaid with incorrect connections.

PaddleOCR's four-way orientation classifier detected the rotation, then Gemini Flash returned the nodes and edges correctly in JSON.

Comment “PDF” and I’ll send you the course details.

## Visual content

Source: automated media description returned by instagram-cli `media-understanding`. The CLI exposes no media file or frame, so the video/image was not viewed directly; the description below is the only visual evidence and is reproduced as returned.

In this 2026 social media video, creator Isaac Flath (@isaac_flath) demonstrates why most OCR approaches fail on a rotated U.S. patent flowchart. He explains that while AWS Textract correctly reads all 19 node labels, it loses the arrows that define the flowchart structure. Chandra 2 can output Mermaid diagram code directly, but makes several connection errors—for example linking node 302 to 303 instead of back to 301, and inventing a loop from 314 to 303. His solution uses PaddleOCR's four-way orientation classifier (detecting 0°, 90°, 180°, 270°) to determine the image needs a 270° rotation to be upright, then passes the corrected image to Gemini Flash. Gemini returns a full JSON representation with all nodes and edges correct (e.g., 'from': '302', 'to': '301'). From there, the JSON can be rendered into Mermaid for display. He concludes by inviting viewers to comment 'PDF' to receive a link to his course on building high-accuracy OCR setups for documents.

### On-screen or spoken text quoted in the description

- [none quoted]

### Gaps

- Exact slide/overlay text, terminal output, table cells, and chart values beyond what the description quotes: [not visible]
