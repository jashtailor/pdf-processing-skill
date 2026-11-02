# What does an OCR router look like? How do you do error analysis on an multi-step OCR route

- URL: https://www.instagram.com/reel/DfAVR6MtdFR/
- Date: 2026-10-27 09:53:08 (as returned by instagram-cli `created_at`)
- Type: reel
- Media type: video
- Author: @isaac_flath (Isaac Flath)
- Likes / comments at collection (2026-11-02): 26 / 0

## Caption

What does an OCR router look like? How do you do error analysis on an multi-step OCR router?

I walk through a simple LiteParse → Docling → Qwen router, and inspect traces to evaluate how the routing steps and models do. We'll look at both successes and failures.

Then we'll discuss a more advances approach using small regression models to predict when a bigger model is worth using.

## Visual content

Source: automated media description returned by instagram-cli `media-understanding`. The CLI exposes no media file or frame, so the video/image was not viewed directly; the description below is the only visual evidence and is reproduced as returned.

A presenter in a gray shirt and glasses explains how to extract structured data from PDFs more efficiently by routing documents between small and large AI models. He demonstrates the LiteParse platform processing a Bolivia sovereign bond prospectus, showing how initial OCR fails on complex tables, then uses Docling for layout detection and Qwen for transcription to correctly parse medium- and long-term public external debt figures. Additional examples include extracting fields from a National Electric bill and a World Bank financing allocation table. He illustrates the accuracy-latency tradeoff with a comparison table (e.g., Document A gains 20 percentage points accuracy at +1 sec cost), then describes training regression models on features from the small model's output to predict both accuracy gain and added time. A decision diamond labeled 'Worth it?' routes easy pages to keep the small-model result and escalates hard pages to the large model. The goal is to maintain high accuracy while minimizing compute cost, applicable to any document type.

### On-screen or spoken text quoted in the description

- [none quoted]

### Gaps

- Exact slide/overlay text, terminal output, table cells, and chart values beyond what the description quotes: [not visible]
