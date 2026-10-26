# You need the temperature to know which limit applies, but Gemini Flash with a generic OCR 

- URL: https://www.instagram.com/reel/DexAHiZAjTP/
- Date: 2026-10-21 11:00:51 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-10-26): 26 / 0

## Caption

You need the temperature to know which limit applies, but Gemini Flash with a generic OCR prompt left out the 25°C condition.

## Visual content

Source: automated media description returned by instagram-cli `media-understanding`. The CLI exposes no media file or frame, so the video/image was not viewed directly; the description below is the only visual evidence and is reproduced as returned.

A man with glasses wearing a dark long-sleeve shirt speaks directly to camera in front of a microphone, explaining a technical issue with optical character recognition (OCR) of electronics datasheets. The top half of the screen displays a Texas Instruments datasheet for the LM358B/LM358BA showing '5.5 Electrical Characteristics,' highlighting that the input offset voltage limit is ±3.0 mV at TA = 25°C, and ±4 mV across the full temperature range of -40°C to +85°C. He explains that while the chip has different error standards depending on temperature, an AI tool called Gemini extracts the error limits but fails to include the temperature condition for all entries, leaving 'test_conditions': null in the JSON output. He notes this is critical because you must know which limit applies, and shows that by correcting the prompt he was able to get the proper output including 'temperature': '25°C'. The tone is educational and instructional, aimed at engineers working with parts lists.

### On-screen or spoken text quoted in the description

- [none quoted]

### Gaps

- Exact slide/overlay text, terminal output, table cells, and chart values beyond what the description quotes: [not visible]
