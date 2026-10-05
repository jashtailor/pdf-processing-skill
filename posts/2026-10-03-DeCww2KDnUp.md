# A pipeline assumes every piece can be parsed properly, completely independently. Sometimes

- URL: https://www.instagram.com/reel/DeCww2KDnUp/
- Date: 2026-10-03 12:01:54 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-10-05): 26 / 1

## Caption

A pipeline assumes every piece can be parsed properly, completely independently. Sometimes that's true and sometimes it's not. If the text refers to a chart, the model may need to see both together.

Comment “PDF” and I’ll send you the course details.

## Visual content

Source: automated media description returned by instagram-cli `media-understanding`. The CLI exposes no media file or frame, so the video/image was not viewed directly; the description below is the only visual evidence and is reproduced as returned.

This is a split-screen video conversation posted October 3, 2026, featuring Isaac (top) and Alexis (bottom), identified as teaching builders about extracting information from documents. The discussion centers on when OCR needs the whole page versus processing pieces independently. Isaac explains that while a Vision Language Model (VLM) may be technically more accurate in practice, traditional pipelines work well for fixed-format documents common in enterprise settings where you have many instances of the same layout. He notes pipelines optimize for expected layout and content types rather than relying on a big model to rediscover format each time. The downside he highlights is that pipelines cannot see the page as a whole, so when reading text they may hallucinate or miss context—for example, a paper with a chart where the text heavily references 'as you can see' the bar chart, making it obvious which item is biggest only when image and text are seen together. A VLM that sees both can infer correctly, whereas a text-only pipeline has no chance. They conclude there are cases where seeing the whole page matters because pipelines assume every piece can be parsed independently, which is sometimes true and sometimes not.

### On-screen or spoken text quoted in the description

- [none quoted]

### Gaps

- Exact slide/overlay text, terminal output, table cells, and chart values beyond what the description quotes: [not visible]
