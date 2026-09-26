# NeoMME finds the right document page. I ran its released 260 million parameter checkpoint 

- URL: https://www.instagram.com/reel/Dc6PDaGFdjN/
- Date: 2026-09-05 08:01:45 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-09-26): 63 / 0

## Caption

NeoMME finds the right document page. I ran its released 260 million parameter checkpoint on three document pages.

It has two ways to search. The late-interaction mode breaks up a page into many vectors. The lighter, dense mode reduces it to one vector per page.

First, I searched insurance documents for a health insurance claim form, and both modes returned the correct page. I then searched a document for a restaurant food inspection report, and again both modes returned the correct page.

Then I searched a trickier two-page procurement form where the form spans both pages, but I was looking for the start of the form. The late-interaction mode returned the first page just like I wanted. The lighter, dense mode put the second page first. It did not work quite as well, but it was not a complete failure. This is page two of the form instead of page one.

It was pretty cool to see the late-interaction mode get all three of these checks right. The lighter mode got one wrong, but it was a reasonable failure. This is a small test, but it is just enough to show that it does seem to work as expected. I hope you check it out and try it on larger systems.

Source: https://x.com/tonywu_71/status/2095501116033126584

More document news: https://isaacflath.com/news

## Visual content

Source: automated media description returned by instagram-cli `media-understanding`. The CLI exposes no media file or frame, so the video/image was not viewed directly; the description below is the only visual evidence and is reproduced as returned.

A presenter demonstrates the new Hcompany/NeoMME-260M-Retriever model for finding the correct document page. He explains the model has two search modes: a late-interaction 'page-by-page' mode that breaks a page into many vectors, and a lighter dense mode that reduces a page to one vector. He tests both on three examples: searching insurance documents for a health insurance claim form (both modes return the correct page), searching for a restaurant food inspection report (both modes return the correct page), and searching a trickier two-page procurement form where he wants the start of the form. On the procurement form, the late-interaction mode correctly returns page one, while the dense mode returns page two first—a partial but reasonable failure since it is still the same form. He concludes the small test shows the model works as expected, praises the page-by-page mode for getting all three right, and encourages viewers to try it on larger systems.

### On-screen or spoken text quoted in the description

- [none quoted]

### Gaps

- Exact slide/overlay text, terminal output, table cells, and chart values beyond what the description quotes: [not visible]
