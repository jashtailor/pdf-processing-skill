# Most OCR approaches fail on a seemingly clean wide table with formulas and numerical value

- URL: https://www.instagram.com/reel/DcynbhNgn6g/
- Date: 2026-09-02 09:01:02 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-09-26): 42 / 12

## Caption

Most OCR approaches fail on a seemingly clean wide table with formulas and numerical values. 

It's top header row seems to confuse Docling by causing it to read that a 1x2 table then return the real table as a long stream of headings, dates, formulas, and values, so the rows and columns are lost. AWS Textract finds the 14 columns but removes subtraction signs in formulas 6 and 12, and the plus sign in formula 11.

Chandra returns the full table as correct HTML: all 14 columns, all 12 months, the footnotes, and the formula operations. The HTML can be parsed directly for downstream analysis.

Comment “PDF” and I’ll send you the course details.

## Visual content

[not visible] The media-understanding service returned an empty description for this item after three attempts, and the CLI exposes no media URL, so the visual content could not be transcribed. Only the caption above is available.
