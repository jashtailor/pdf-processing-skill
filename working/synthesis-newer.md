# Isaac Flath — working notes from the NEWER half of the posts

Scope: the 58 newest items in `~/workspace/isaac-flath-pdf-skill/posts/`, covering **2026-08-28 through 2026-09-25**. These are raw working notes for a later merge with the older half. Not a finished skill.

Reader I'm writing for: a data analyst who sets up and tests document-extraction agents in a no-code interface. Plain language throughout.

## How to read these notes (source quality)

- Every claim here comes from a post's own caption plus, where available, an automated description of the video. **Nobody watched the videos.** The descriptions are machine-written summaries of what was on screen.
- **19 of these 58 items have no visual description at all** — the description service came back empty. For those, the caption is the only evidence. Each is flagged below as **(caption only)**.
- Breakdown of the 19: 4 are real teaching posts (2026-08-31, 2026-09-02 wide-table, 2026-09-04, 2026-09-05 ParseBench). The other 15 are highlights or a story with little or no caption text (2026-09-10 ×2, 09-11, 09-12, 09-13 ×2, 09-15, 09-16, 09-18, 09-20, 09-22 ×2, 09-23, 09-24, 09-25 story) — those 15 carry almost no teaching content.
- So of the 58 items, roughly **41 carry real content**. The rest are promotional highlights.
- Every number he gives is from his own small test, usually one to three pages. He says so himself, repeatedly. Treat all of it as "worth trying," never as settled fact.

---

## 1. Core principles he repeats

**Test it on your own documents. Nothing transfers.**
He says this almost every week. A tool that wins on his page may lose on yours. On a printed clinical note, the big expensive model (Gemini 3.5 Flash) got it wrong while two cheaper tools got it right — his line was that big models are "not a magic bullet for every document problem, and viewers should evaluate on their own data." (2026-09-07)

**The thing that breaks you is usually not the thing you were reading.**
A legal agreement where every date and dollar amount came out perfect, but the diagonal "DRAFT, NOT FOR EXECUTION" stamp was dropped — so the system treated a draft as a signed deal. The details were right and the document was still misunderstood. (2026-08-28)

**Reading the text is not the same as understanding the layout.**
Text can be perfectly correct while sitting in the wrong row, the wrong column, or merged with its neighbour. He shows this over and over: a bus timetable (2026-08-31), a drug label (2026-09-08), an Apple balance sheet (2026-09-09), a research-paper table (2026-09-24). Getting the characters right is the easy half.

**Do arithmetic in code, not in the model.**
Two posts in the newer half make this exact point. A floor plan where the dimensions were read correctly and the area was then computed wrong — 194.67 sq ft instead of the correct 191⅓ (2026-09-12). And an insurance line where the total was right but the pieces couldn't produce it (2026-09-17). His advice both times: pull the numbers out, then let ordinary code do the maths.

**Checking has to be cheaper than doing it by hand, or you saved nothing.**
This is probably his sharpest recurring idea in this stretch, and he says it three different ways:
- A teacher using Chandra for braille worksheets: the win wasn't accuracy, it was that *checking* dropped from hours to 5–10 minutes. Flath's comment: measuring your own cleanup time is what tells you whether a model is actually useful. A model can get most of a page right and still leave you with so much fixing that you've saved nothing. (2026-09-07)
- Finch Legal: "if fact-checking takes as long as it would be to go through it manually, it doesn't save any time." (2026-09-17)
- His own test lab: every answer carries a box on the page showing where it came from, so a human can confirm it in seconds instead of rereading the document. (2026-09-15)

**Citations are not a nice-to-have.**
He calls them "pretty necessary" for real products. In the Finch Legal example, the paralegal reads the extracted answer, clicks through to the exact spot in the original, and verifies. That round trip is what makes the automation trustworthy. (2026-09-17)

**Spend the expensive model only where you need it.**
The bus timetable post is the clearest case: a cheaper table pipeline matched a vision model on the same page, 46% faster and 78% cheaper. His framing — optimise the pipeline for cost and speed, not only for accuracy. (2026-08-31, caption only)

**Change one thing at a time.**
His lab is built so he can swap a single stage — how the page is read, how the right passage is found, how the answer is written — and rerun the identical question set to see what moved. (2026-09-15)

**Route pages by difficulty instead of sending everything down one path.**
Recurring in the newest posts. Check whether a drawing already has usable text before going near OCR (2026-09-12). Send only pages flagged "table-likely" to a heavier table parser (2026-09-24). Crop to the small region that's giving trouble rather than reprocessing the whole page (2026-09-15).

**Don't trust a brand-new leaderboard.**
Said plainly about ExtractBench — practical dataset, but "I wouldn't necessarily trust the leaderboard yet," give it a couple of weeks of people testing against it. (2026-09-03)

---

## 2. The test-first method — the specifics he actually gives

Most of the concrete detail in the newer half comes from three posts: the PDF-MCP comparison (2026-09-01), the Reducto r-1 test (2026-09-03), and the joint session with Hamel Husain (2026-09-15).

**Size of his own test set**
- **77 pages, 22 questions.** This is his personal benchmark and he reuses it across posts. He calls it his "doc lab" or "document lab."
- The page mix is deliberately varied and deliberately hard: loan estimates, magazines, newspapers, a census survey with tiny print, maps, equations. (2026-09-01, 2026-09-03)
- He calls it a "private evaluation" and a "tiny task-specific example look, not a general leaderboard." (2026-09-03)

**How answers get labelled and checked**
- Every answer must cite a **box on the page** where it came from. That's the labelling mechanism — the correct answer isn't just a string, it's a string plus a location. (2026-09-15)
- Because of that box, checking one answer takes seconds. He calls this "cheap checking" and treats it as the thing that makes the whole loop viable. (2026-09-15)
- For a benchmark-style score, he compares field by field against expected values and looks at the verdict per field. (2026-09-23)

**How scoring works**
- Straight count of questions right out of 22. Examples he reports: direct command-line tools ≈18/22, PDF-MCP ≈16/22 (2026-09-01 caption). The video description for the same post gives a slightly more detailed split — with command-line tools one agent got 18/22 and another 19/22; with PDF-MCP those became 15/22 and 16/22. **The caption and the description disagree slightly; the caption's "~18 vs ~16" is the version he chose to publish.**
- He also cares about the *cost and speed* alongside the score, not just the score. In the 2026-09-15 session, plain keyword search and meaning-based search scored the same, so he picked keyword search because it was cheapest.
- A better scoring style he's now promoting (2026-09-23, OmniExtractBench): instead of one number, break every field into **matched / misread / missing / invented**. His reasoning: "choosing an OCR model is hard when the score doesn't say what really went wrong."
  - He demonstrated the scorer is honest by deliberately deleting the first row of a table. Those four values were correctly marked missing, and the next row still matched — i.e. one deletion didn't cascade into false failures.
  - His own run on a well pressure-test report: 60 values matched, one row label missing. Results viewable as a spreadsheet with columns for field, expected, returned, verdict.

**The three stages he tests separately**
1. **Reading** the page (OCR / vision model)
2. **Finding** the right passage (keyword search vs meaning-based search)
3. **Answering** from what was found

He swaps one stage, reruns the same 22 questions, and sees what changed. In the 2026-09-15 session, the failures traced back to stage 1 — the reading step. (2026-09-15)

**Note on how this compares with the older half:** the older posts described a "50–100 typical pages, humans mark the right answers, count exact matches field by field" approach. The newer posts describe his *own working lab* at 77 pages / 22 questions. These aren't in conflict — the first is his advice to you for a production system, the second is the smaller rig he uses for weekly tool comparisons. Worth keeping both in the final skill and labelling which is which.

---

## 3. Checking habits — and what each one catches

Each bullet: the habit, then what it catches.

- **Check the arithmetic inside the record.** Multiply the rate by the count and compare with the stated total. *Catches:* a digit misread that looks perfectly plausible. Example — "23 months at $100.83 per month, total $202." The total was right, the line item was wrong; 23 × 100.83 is $2,319, not $202. The real document said "2 mo." (2026-09-17)
- **Check totals across columns and years.** *Catches:* rows merged into one, or a row dropped. Example — Berkshire Hathaway earnings: revenue, investment and expense totals all matched across three years, but two separate rows ("Insurance premiums earned" and "Sales and service revenues") had been squashed into one. The totals check passed; the row check is what would catch it. (2026-09-24)
- **Compare against a known-correct published figure where one exists.** *Catches:* values a chart-reading tool estimated rather than read. Example — a chart tool returned 28.8%; the report accompanying the chart said 28.5%. Close, but an estimate. (2026-09-25)
- **Check field count against the expected list of fields.** *Catches:* whole sections silently skipped. On a census form, the model rebuilt the main grid but stopped at question 33, dropping seven fields after it. Nothing in the output said anything was missing. If you know the form has questions up to 36, a count check flags it instantly. (2026-09-15)
- **Ask separately about document status.** *Catches:* drafts treated as final, and edits that were struck out. Watermarks and redlines are physically separate from the text and most tools skip them. He recovered the watermark with a prompt aimed only at that question, producing a plain true/false "safe to treat as final" flag. (2026-08-28; also 2026-09-03 where Reducto r-1 kept both)
- **Check that a label stayed attached to its value.** *Catches:* names merged across rows. Example — two model names in a research table merged into one cell spanning two rows, while their two different error rates stayed separate. Import that and both results carry the same wrong name. (2026-09-24)
- **Check that a heading didn't multiply or migrate.** *Catches:* spanning headings being repeated onto every row beneath them, or half a heading landing in a data column. (2026-09-09 Apple balance sheet; 2026-09-08 drug label)
- **Decide what an empty cell means before you start, and check for it.** *Catches:* meaningful blanks being thrown away. On a CDC immunisation schedule, grey cells mean "no guidance / not applicable" — that's information, not a gap. One tool dropped the colour entirely and returned nothing; another returned nothing for the value but did preserve the "no guidance" category. His preference: store the category, don't store a blank. (2026-09-16)
- **Check that genuinely absent fields come back empty, not guessed.** *Catches:* invented values. He ran a loan estimate and a closing disclosure through an extractor into a database; six dollar amounts matched, and the two figures that simply weren't on the loan estimate page came back empty as they should. That's the behaviour to test for. (2026-09-09)
- **Check that characters were copied, not tidied up.** *Catches:* a model "correcting" what it thinks is a typo. A printed lab note read "HCO: 3:21" and one model returned it as "HCO3": "21" — a reasonable-looking cleanup that changed the data. (2026-09-07)
- **Check exact digits on clean, easy-looking tables too.** *Catches:* single-digit slips on pages nobody thought were risky. A bank balance sheet where 365,848 came back as 369,488. His comment: readable tables can still have small digit errors. (2026-09-10)
- **Check that a page went to the right document when you split a bundle.** *Catches:* misrouted pages in mixed packets. A page explicitly stamped "Medical Report Continued" got assigned to the wrong report type. (2026-09-16)
- **When something is missing, crop to it and retry before blaming the model.** *Catches:* problems that are about page size and resolution, not about the model's ability. Cropping recovered the seven missing census fields. He's honest about the limit: this only works because he already knew where the error was. At volume you wouldn't. (2026-09-15)
- **Measure your own cleanup time as a metric.** *Catches:* a tool that scores well and still doesn't pay for itself. (2026-09-07)

---

## 4. Page types that are hard, and why

Ordered roughly by how often he returns to them in this stretch.

**Tables with merged or spanning cells — the single most common failure.**
When one heading sits across several columns, or a section label has no number of its own, plain text output has no way to say so. What goes wrong in his examples: a heading gets repeated onto every row (Apple balance sheet, 2026-09-09); half a heading lands in a data column ("Respiratory, Thoracic, and Mediastinal Disorders" with "Disorders" under the wrong column, 2026-09-08); two names merge into one cell (2026-09-24). **His fix is a format point:** ask for HTML or structured data rather than plain markdown text, because HTML can say "this cell spans four columns" and markdown can't. He repeats this across 2026-09-08 and 2026-09-09.

**Wide tables with formulas.**
A 14-column table with 12 months and footnotes. One tool misread the top header so badly it decided the page was a 1×2 table and returned everything as one long stream of headings, dates and values — rows and columns gone. Another found all 14 columns but silently dropped minus signs from two formulas and a plus sign from a third. (2026-09-02, caption only)

**Forms — blanks, checkboxes and signatures.**
Deciding whether a box is empty or filled is, in his words, difficult but critical: a signed and an unsigned contract must be handled completely differently. In his test of a purpose-built model for exactly this: an empty text field scored 0.007, a typed field 0.892, a signature ~1.0 — but a checkbox that looked clearly ticked scored only 0.416. Checkboxes are the weak point. (2026-09-05)

**Long forms where a section gets skipped.**
Census form, main grid rebuilt, everything after question 33 gone — seven fields. Nothing flagged it. (2026-09-15)

**Flowcharts and diagrams — boxes are easy, arrows are hard.**
This is a consistent split. On a rotated patent flowchart, one tool read all 19 labels correctly and lost every arrow. Another produced a diagram with wrong connections and an arrow that didn't exist. Even a newer agentic model got the connections wrong on the same page. (2026-09-01, 2026-09-03). **The fix that worked:** detect the rotation first with a small orientation classifier, straighten the page, then ask a vision model for boxes and arrows as structured data — which came back correct. (2026-09-01)

**Anything rotated.**
Straightening the page first changed the outcome on the patent flowchart. Worth treating rotation as a separate step, not something the reader will handle.

**Charts without printed numbers.**
A tool can identify the groups and the series correctly and still only *estimate* the bar heights. 28.8% returned against a published 28.5%. Off by 0.3 points — fine for a rough view, not fine for medicine. His rule: treat chart values as estimates unless the number is printed on the page. (2026-09-25; same pattern noted 2026-09-02 for image descriptions)

**Maps.**
Repeatedly named as a hard case. A topographic map where the printed elevation 5,414 was skipped and a nearby different number (BM 4668) was used instead (2026-09-02). Maps also show up as the reason he wanted an agent to be able to crop and zoom (2026-09-01).

**Architectural drawings and floor plans.**
Two distinct problems. Counting things: a vision model found 2 of 4 sinks on a floor plan (2026-09-14). Measuring things: dimensions read correctly, area computed wrong (2026-09-12). Dense linework plus rotated repeated symbols plus small text is a bad combination for a single general-purpose pass.

**Colour-coded tables.**
Where the colour of the cell *is* the value. Most tools discard colour entirely. (2026-09-16)

**Watermarks, drafts and redlines.**
Sits on top of the text rather than in it, and gets dropped. Changes the meaning of the whole document. (2026-08-28, 2026-09-03)

**Handwriting and equations.**
Named as still-tricky in passing (2026-09-03). The braille case study shows generic tools leaving equations missing and paragraphs out of order (2026-09-07). A 19th-century calculus page came out as garbled text like "2?r a + b [* dx" until run through a structure-aware tool that labelled formulas separately (2026-09-16).

**Mixed bundles (many documents in one file).**
Not a "hard page" exactly, but a hard *input*. Leases with eight attachments, hospital charts with seven report types. Splitting them correctly first is what lets each part go to the right extractor. (2026-09-16)

**Legacy print formats.**
Old IBM print files: one sample gave searchable phrases with garbled characters, another was mostly unreadable. The reader assumes a single character encoding and only pulls text — no images, no barcodes. (2026-09-25)

---

## 5. Tool comparisons — always "he found X on N pages"

Phrase all of these as his findings on specific small tests. He never claims these are general truths, and neither should the final skill.

### Page-reading tools

**Chandra / Chandra 2 (Datalab)**
- On a 14-column wide table with formulas: he found it returned the full table as correct HTML — all 14 columns, all 12 months, the footnotes, and the formula operators intact. The other two tools he tried both failed. (2026-09-02, caption only)
- On a drug label with a merged category heading: he found it returned HTML keeping the heading in one cell spanning four columns, where markdown output split it. (2026-09-08) *Caution: the automated description of this post garbles the two tool names; the caption is the reliable version.*
- On a rotated patent flowchart: he found it produced diagram code with wrong connections — e.g. linking 302 to 303 instead of back to 301, and inventing a loop from 314 to 303. (2026-09-01)
- On a printed clinical note: he found it returned the awkward lab value exactly as printed, where a bigger vision model rewrote it. (2026-09-07)
- Third-party use he reported on, not his own test: Papers with Code now runs non-arXiv PDFs through Chandra to produce markdown for its chat-with-paper feature (2026-08-30); and a Utah school district uses it to produce markdown and LaTeX from handwritten maths and science worksheets for braille conversion, cutting checking time from hours to 5–10 minutes (2026-09-07).

**Docling**
- On an Apple balance sheet: he found it repeated the spanning section headings across every row. (2026-09-09)
- On a drug label: he found it split the merged category heading across two cells. (2026-09-08)
- On a wide table with formulas: he found its reading of the top header row threw it off so badly it treated the page as a 1×2 table and returned the real table as an unstructured stream. (2026-09-02, caption only)
- On an insurance closing cost line: he found it read "23 months" where the document said "2 mo." (2026-09-17)
- On a CDC schedule with grey cells: he found it read the labels but dropped what the grey meant. (2026-09-16)
- On a legal agreement: he found it got every detail right and missed the draft watermark. (2026-08-28)
- Where it did better: on a bank balance sheet he found Docling returned 365,848 correctly while Gemini Flash returned 369,488 — and he explicitly notes Docling is the faster and cheaper of the two (2026-09-10). On a printed clinical note he found Docling with RapidOCR transcribed the lab value correctly where the bigger model rewrote it (2026-09-07). On a research-paper table he found Docling kept both model names separate where MinerU merged them (2026-09-24).
- Product news, not a test: Docling released an MCP server (a way for AI assistants to call it) and a skill file that teaches agents to use it. He hadn't tried the skill and said it looked broader than he'd need — he'd try to simplify it. (2026-09-02)
- Product news: an AFP (IBM print format) reader in v2.128.0 — he found one sample gave searchable phrases with garbled characters and a second was mostly unreadable, due to a single-encoding assumption. Text only, no images or barcodes. He still called it a useful start. (2026-09-25)

**Gemini / Gemini Flash / Gemini 3.5 Flash**
- On a rotated patent flowchart, after the page was straightened by an orientation classifier: he found it returned all the boxes and arrows correctly as structured data. This was his recommended fix for that page. (2026-09-01)
- On a census form: he found it rebuilt the main grid but stopped at question 33, missing seven fields. Cropping the missed panel and enlarging it let the same model read it fine. (2026-09-15)
- On a bank balance sheet: he found it misread 365,848 as 369,488. (2026-09-10)
- On a printed clinical note: he found it rewrote "HCO: 3:21" as "HCO3": "21" — tidying the data instead of copying it. (2026-09-07)
- He consistently frames these models as expensive and slow relative to alternatives. (2026-08-31)

**Qwen**
- On an Apple balance sheet: he found it kept each spanning heading once as a section with its amount rows nested inside. (2026-09-09)
- On a CDC schedule with grey cells: he found it identified the grey cell, returned the value as empty, but also preserved the "no guidance / not applicable" meaning. His preference was to store that category rather than a blank. (2026-09-16)

**AWS Textract**
- On a rotated patent flowchart: he found it read all 19 labels and lost every arrow. (2026-09-01)
- On a wide 14-column table: he found it located all 14 columns but dropped subtraction signs from two formulas and a plus sign from a third. (2026-09-02, caption only)

**PaddleOCR**
- Its four-way orientation classifier (0°/90°/180°/270°) correctly detected that a patent flowchart needed 270° of rotation. He used it as a pre-step before the vision model. (2026-09-01)
- Its PP-StructureV3 table pipeline, on a single bus timetable page: he found it produced the same 13-stop by 10-departure table as a vision model, **46% faster and 78% cheaper**, running on scale-to-zero infrastructure (Modal). One page, his own setup. (2026-08-31, caption only)

**Reducto r-1**
- His numbers as reported: about one cent per page, roughly 20% better than Reducto's previous pipeline. (2026-09-03)
- On his 77-page lab, extraction-only questions: he found it led Docling and Surya. (2026-09-03)
- He found it preserved a faint draft watermark and a redline strikethrough that many parsers miss. (2026-09-03)
- He found it still got flowchart connections wrong on the rotated patent page — same failure as Chandra — and that hard maps and equations remained tricky. (2026-09-03)
- Separately, Reducto is the vendor behind the Finch Legal case he reported on (5× paralegal caseload, source tracking, click-through citations). That's a customer story he relayed, not his own test. (2026-09-17)

**MinerU 4.0**
- On a research-paper table: he found it merged "ResNet-50" and "ResNeXt-50" into a single cell spanning two rows while keeping the two error rates separate — so importing would give both results the same combined name. (2026-09-24)
- Its new local library feature: as it parses, it builds a keyword search index in a local SQLite database and gives each passage an address of document / page / block. He tested it on a 23-page financing agreement and pulled back just the payment clause without putting the whole document into the prompt. All local. (2026-09-24)

**LiteParse**
- Speed figure is LlamaIndex's, not his: about 3 milliseconds per page with OCR off (reading only the text already stored in the file).
- On Berkshire Hathaway earnings statements: he found it flagged the page as not needing OCR and as "table-likely"; revenue, investment and expense totals matched across all three years, but two separate rows were merged into one.
- His suggested use: send every "table-likely" page to a proper table parser, or use the detected table's bounding box to send only that region. (2026-09-24)

**LlamaIndex parsing modes**
- Turbo mode (beta), his two tests: a JPMorgan balance sheet took 10.5 seconds vs 41.2 seconds on Cost Effective (~4×); a Vanguard table took 9 seconds vs 30 (~3.3×). Both returned identical correct values, so no accuracy cost on those two.
- Pricing as he reports it: Turbo 35 credits per page, Cost Effective 8 credits per page.
- His summary of the ladder: Turbo = fast, expensive, fine for regular documents. Cost Effective = slow, cheap, fine for regular documents. Agentic / Agentic Plus = slow, expensive, very accurate on genuinely hard documents.
- He labels this "tiny experiments," not a benchmark. (2026-09-04, caption only)

**LandingAI**
- DPT-3 extraction on a loan estimate and a closing disclosure, loaded into a SQLite database: he found all six dollar amounts matched the source, and the two final amounts that weren't present on the loan estimate page correctly stayed empty. (2026-09-09)
- Split, which separates a bundle into individual documents given descriptions of the types you expect: he found an 18-page lease split correctly into eight documents (lease agreement, house rules, security deposit policy, concession acknowledgement, bed bug / mould / pet / satellite addenda). A 14-page hospital chart split by report type worked "really well except for one page" — page 5, explicitly stamped "Medical Report Continued," was filed under Consultation instead of History & Physical. (2026-09-16)

**Unstructured**
- Image descriptions as searchable metadata, his three tests: a NASA systems diagram — the description preserved all three process groups and the exact labels; a topographic map — it recognised the peak but skipped the printed elevation 5,414 and used the nearby BM 4668 instead; a bar chart with no printed numbers — it returned reasonable visual estimates (Hispanic ~20%, other/multiple ~22%, non-white ~12%). His conclusion: good to index alongside the page text for search, then verify exact values against the original image. (2026-09-02)
- Code blocks now come back as their own element type rather than ordinary text, with formatting kept. His read: one less thing to build — you can syntax-highlight, add a copy button, or run a syntax check on the code separately without writing a splitter. He notes it doesn't give you citations. (2026-08-30)

**Nutrient**
- Form field state model (blank vs filled), his quick test: empty text field 0.007, typed field 0.892, clearly-ticked checkbox only 0.416, signature field ~1.0. Verdict: "pretty good" overall, but he'd do more work specifically on checkboxes. Explicitly "not a benchmark, just a quick second-step check." (2026-09-05)
- Chart parsing model (commercial), his test: a CDC bar chart with no numbers printed above the bars. It correctly identified all five population groups and five frequency columns, and returned 28.8% where the accompanying report says 28.5% — within about 0.3 points. Handle as estimates. He notes Nutrient's own published benchmark shows it beating general-purpose models at pulling data values; that's the vendor's claim, not his. (2026-09-25)
- Two tutorials he relayed, no testing: rendering a PDF's existing annotations (links, notes, highlights, form widgets) in a web app, and keeping custom overlays correctly positioned through zoom and rotation. (2026-08-28)

**PDF-MCP**
- A wrapper that gives an AI agent OCR, routing, parallel processing, caching, table extraction and local search. On his 22-question set: the direct command-line loop scored ≈18, PDF-MCP ≈16, and PDF-MCP ran slower.
- His explanation for the gap is the interesting part: with direct command-line access the agent could re-render, crop, resize and change OCR settings on the hard pages (a small-print census survey, map labels) — it took longer but it got there. The wrapper didn't let it improvise.
- His verdict: good for ordinary PDFs and the local search is valuable, but for genuinely complex pages use a heavier tool or give the agent the raw tools. (2026-09-01)

**Datalab accessibility API**
- On a 19th-century integral calculus page: he found raw OCR produced garbled text ("2?r a + b [* dx") while the API separated the page into labelled text and formula blocks with the formulas rendered properly. He'd still keep a person reviewing. (2026-09-16)

### Page-finding / search tools

**NeoMME (260-million-parameter retriever)**
- Three page-finding tests. Insurance claim form: both modes found the right page. Restaurant inspection report: both modes right. A two-page procurement form where he wanted the *first* page: the heavier "late interaction" mode (many vectors per page) got page 1; the lighter "dense" mode (one vector per page) put page 2 first — wrong, but at least the right form.
- Score: late interaction 3/3, dense 2/3. Three pages. (2026-09-05)

**EVIE (Tencent, EVIE-Preview-4.5B)**
- Searches page images, so charts and diagrams can match. Three realistic queries he tried, the intended page ranked first each time. He says plainly it wasn't a broad benchmark and he'd like to find where it fails. (2026-09-09)

**STAIR**
- A research method: fine-tune a model (Mistral 7B) to pick the right section of a document using the question plus the table of contents. His own thought was the useful bit — most PDFs don't have a table of contents, but a model that identifies headings could generate one, and then this approach would apply more widely. He noted the paper's code link appeared dead. (2026-09-09)

**Jev (TypeSafe AI)**
- Not a document tool. A fast classifier that returns structured yes/no-style judgements in tenths of a second instead of seconds, without per-task training. He says he's put it into his ranking, re-ranking, retrieval and AI-grading workflows, replacing Gemini Flash in those spots. (2026-09-17)
- He also says he uses it to *find candidate stories* for his document news feed, then manually reviews and curates and writes every post himself. (2026-09-20, caption only) — a small but telling point about how he actually uses AI: for shortlisting, not for final output.

### Benchmarks and test sets

**ExtractBench (LlamaIndex + Kaggle)**
- ~5,000 pages, 370 documents, eight domains. Input is a full document plus a schema you define; output is the values plus a page number or box for each, so citations are built in.
- Contents he noticed: long tables, tables continuing across pages, forms with checkboxes, W-2s, K-1s, presentations, dense tables, electric bills, signatures.
- "Really practical dataset," but brand new — don't trust the leaderboard yet. (2026-09-03)

**OmniExtractBench (Datalab)**
- 620 documents pulled from four different vendors' benchmarks, specifically so it isn't biased toward any one vendor's idea of a hard page.
- The point of it is the scorer: matched / misread / missing / invented, per field, as a spreadsheet with expected, returned and verdict columns. (2026-09-23)

**ParseBench 1.0**
- Tests parsers across text, formatting, tables, charts and page locations. 1.0 fixed scoring and provider bugs and added rule-based and visual checks.
- **The practical warning:** scores from 0.2 and earlier are not comparable with 1.0. Rerun your old experiments before comparing anything new against them. (2026-09-05, caption only)

**ArmorOCR + AdvSpot**
- A model and benchmark for text a person can read but a machine misses. 390 images, five categories, thirteen types: rotated, mirrored, tiny, dot-pattern, line-encoded, symbol-based, pattern-overlaid, low-contrast, capture artefacts, post-processing artefacts, stylised glyphs, handwritten.
- Each item has a box, a verified transcription, a difficulty label and a question about that exact region. Code and examples released; the model weights and full dataset listed as still to come. (2026-09-02)

---

## 6. Surprising or non-obvious

- **Giving an agent fewer, rougher tools beat giving it a polished wrapper.** The wrapper scored lower *and* was slower than plain command-line access, because the agent's ability to improvise — re-render at a different size, crop, change settings, try again — was what solved the hard pages. Counterintuitive, and he investigated the *why* rather than just reporting the score. (2026-09-01)
- **The cheaper, non-AI path matched the vision model on a real table** — same output, 46% faster, 78% cheaper. Worth trying before reaching for the expensive option. (2026-08-31, caption only)
- **A model "correcting" your data is a real failure mode**, and it's worse than a garbled read because it looks fine. "HCO: 3:21" → "HCO3": "21" is plausible, tidy, and wrong. (2026-09-07)
- **The format you ask for changes the accuracy.** Asking for HTML instead of plain markdown fixed merged-cell problems more than once, because markdown has no way to express a cell spanning columns. This is a setting you may be able to change without changing tools at all. (2026-09-08, 2026-09-09)
- **Cropping recovers a lot — but only if you already know where the problem is.** He's unusually honest about this. At volume you don't know, which is exactly why he pushes the blank-form template approach instead. (2026-09-15)
- **Colour can be the data.** A grey cell meaning "not applicable" is a value, not a gap, and nearly every tool throws colour away. Applies to any schedule, roster, status grid or RAG-status table. (2026-09-16)
- **Build the template from the blank form, not from the filled ones.** If you're processing thousands of copies of one form, the empty version tells you the complete field list — which both guides the model and gives you a free missing-field check. (2026-09-15)
- **Check the file before you image it.** A CAD drawing already contained both dimensions as text; no OCR needed, and the maths could then be done in code. (2026-09-12)
- **Template-matching a symbol beat a vision model at counting.** Picking one example of a sink and finding the same shape at any rotation found all four; the vision model found two. He also had to remove near-duplicate matches so nothing counted twice. Old, boring computer vision winning on a counting task. (2026-09-14)
- **Benchmark version numbers matter.** Old scores silently becoming incomparable is the kind of thing that quietly corrupts a comparison spreadsheet. (2026-09-05, caption only)
- **Error breakdowns beat a single score.** "Was it misread, missing, or invented?" tells you what to fix. "72%" doesn't. (2026-09-23)
- **Cutting helped more than adding.** From the session with Hamel Husain on AI-written drafts: the versions they liked had one real number and *one fewer* fact. An AI draft can be factually correct and still not good. Not a document-extraction point, but a clean statement of his general taste. (2026-09-15)
- **How he describes himself,** from his own intro card: "I help builders extract and use information from documents. I test OCR on real PDFs and share the failures, fixes, and checks." That's a fair description of what these 58 posts actually are. (2026-09-25)

---

## 7. Did his advice change? (newer half vs the older material)

Comparing against the summary of the full set in `~/memory/2026-09-16-isaac-flath.md`. Treat these as impressions to confirm during the merge, not firm conclusions.

**Consistent throughout, no change:**
- Test on your own documents; nothing transfers.
- Check relationships, not just whether the right characters appear somewhere.
- Do the maths in code.
- Ask about document status (draft, redline) as a separate question.
- Use expensive models only where they're needed.
- Build a template from the blank form for high-volume repeated forms.
- Every result is a one-to-three-page demo, not proof, and he says so himself.

**Newer emphasis — things that get more airtime in this half:**
- **Cost and speed as first-class results, not footnotes.** The bus timetable post (46% faster / 78% cheaper), the Turbo mode timings, the credits-per-page comparison, choosing keyword search over meaning-based search because it scored the same and cost less. In the newer posts a tool comparison almost always reports time and money alongside accuracy.
- **Citations as a product requirement.** The Finch Legal post and the joint session both make the same argument: a pointer back to the exact spot on the page is what makes checking cheap, and cheap checking is what makes the whole thing worth doing. Older material mentioned bounding boxes as optional, for when users want clickable highlights. Here it's closer to mandatory.
- **Error breakdowns instead of single scores.** OmniExtractBench's matched/misread/missing/invented framing (2026-09-23) is a sharper version of "don't just chase the score."
- **Routing by page difficulty.** Check for embedded text first, flag pages as table-likely, crop to the region, send only hard pages to the heavy model. This shows up repeatedly in the last two weeks of posts.
- **Agentic document models arriving.** He names Reducto Deep Extract, Datalab Document Agent, and Mixedbread's Toast as an emerging category, and tested Reducto r-1 (2026-09-03, 2026-09-17). New in this half.
- **Local and cheap retrieval.** MinerU's local SQLite index and passage addresses, LiteParse's 3ms text-layer read. A move toward "don't put the whole document in the prompt" using ordinary local tooling.

**A slight softening, worth flagging:**
- The older material reads as fairly pro-Chandra on messy tables. That holds here (wide formula table, drug label, clinical note), but the newer posts also show Chandra getting flowchart connections wrong (2026-09-01, 2026-09-03), and show Docling winning on three separate pages — the bank balance sheet digit (2026-09-10), the clinical lab value (2026-09-07), and the research-paper model names (2026-09-24). The newer half is less of a ranking and more of a "each tool has specific pages it loses on."

**No contradictions found.** I didn't find a point where he reverses earlier advice. The shift is emphasis and maturity — from "which tool reads this page best" toward "how do you build and check a pipeline you can afford to run."

---

## 8. Things flagged for the merge

- The **77 pages / 22 questions** lab figure appears in 2026-09-01, 2026-09-03 and 2026-09-15. Cross-check against the older half — if it appears there too, it's his stable rig and should be stated as such in the final skill.
- The **50–100 pages, human-labelled, field-by-field exact match** advice is in the older-half summary but I did not find it restated in these 58. Confirm whether it's older-only before presenting it as current.
- **PDF-MCP score discrepancy** (2026-09-01): caption says ~18 vs ~16; the automated video description says 18/19 vs 15/16 across two agents. Use the caption.
- **Drug label post tool names** (2026-09-08): the automated description says "Docling (referred to as Chandra 2)," which is incoherent. The caption is clear and should be used: Docling split the cell, Chandra 2's HTML kept it whole.
- **Four teaching posts rest on caption alone** with no visual evidence: 2026-08-31 (PaddleOCR cost/speed), 2026-09-02 (wide formula table), 2026-09-04 (Turbo timings), 2026-09-05 (ParseBench 1.0). Their numbers — 46%, 78%, 10.5s vs 41.2s, 35 vs 8 credits — have no second source. Keep them, attribute them to the caption.
- **15 of the 58 items carry essentially no content** (undescribed highlights and one story). Don't count them toward coverage.
- Course and audience context, if the final skill needs it: he runs a "PDF to Production" course (comment "PDF"), two free guides on choosing an OCR model and handling hard documents (comment "OCR"), a document news feed at isaacflath.com/news, and an AI Product Engineering community on skool.com. Roughly two-thirds of these posts end in one of those calls to action.
