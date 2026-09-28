# I tried Tencent's WeVisDoc-2B locally. Revenue, investment gains or losses, and expenses w

- URL: https://www.instagram.com/reel/DdwToSNDQ9g/
- Date: 2026-09-26 08:01:00 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-09-28): 1060 / 4

## Caption

I tried Tencent's WeVisDoc-2B locally. Revenue, investment gains or losses, and expenses were all correct on a Berkshire earnings statement. On a NASA scan, it read a subscript F as a T.

I'm optimistic about the data augmentation they used to make OCR more reliable.

More document news: https://isaacflath.com/news

## Visual content

Source: automated media description returned by instagram-cli `media-understanding`. The CLI exposes no media file or frame, so the video/image was not viewed directly; the description below is the only visual evidence and is reproduced as returned.

In this video, creator Isaac Flath discusses Tencent's WeVisDoc document parsing model. He explains that standard OCR models trained on clean pages struggle with blurry scans and unfamiliar layouts, so Tencent trained WeVisDoc to solve that problem. He notes the model comes in 2-billion and 4-billion parameter versions released under Apache 2.0 license, built by starting with Qwen3-VL and training on a variety of documents with data augmentation to blur and distort pages, followed by additional training on errors. Flath reports testing the 2B version locally on a Berkshire Hathaway earnings statement, where revenue, investment gains or losses, and expenses were all extracted correctly. On a NASA scan containing a handwritten equation, the model returned LaTeX but misread a subscript 'f' as 't' — a hard equation that most OCR models get wrong, though it performed well on typed equations. He expresses optimism about using data augmentations to make OCR more reliable, noting this technique was important in early computer vision and remains useful. He closes by inviting viewers to follow for updates on document processing advances.

### On-screen or spoken text quoted in the description

- [none quoted]

### Gaps

- Exact slide/overlay text, terminal output, table cells, and chart values beyond what the description quotes: [not visible]
