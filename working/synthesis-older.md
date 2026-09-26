# Isaac Flath posts — working notes, OLDER half

Raw material for a later merge with the newer half. Not a finished skill.

**What I read:** the 59 oldest post files in `~/workspace/isaac-flath-pdf-skill/posts/`, dates 2024-03-05 through 2026-08-27. Two are 2024 personal videos with no document content (a dance showcase and "Demo to layla"); the other 57 run 2026-06-27 to 2026-08-27, nearly daily.

**Sourcing caveat.** Every file has a caption plus an automated description of the video. Nobody watched the videos. The descriptions themselves say exact slide text, table cells, and chart values were not captured. So numbers below are the numbers *he said out loud or wrote in the caption*, not numbers read off a screen.

**Caption-only items in this half (4 of the 59).** Per the manifest's `has_visual_description` flag, these four have no visual description at all — the description service came back empty:
- `2024-03-05-C4Ipl3XCs_a.md` (no document content)
- `2024-04-25-C6NQNNUiL9b.md` (no document content)
- `2026-08-09-Db1Wq75CRO3.md` — the "knowledge base shouldn't be one big corpus" post
- `2026-08-10-Db3gEGQkaoB.md` — the redline / strikethrough post, which is one of the more useful posts in the whole set

Anything I cite from 2026-08-09 or 2026-08-10 rests on his caption alone. I flag those inline as **(caption only)**.

**One data oddity worth carrying forward.** `2026-08-04-DboX4HSiWIx.md` and `2026-08-05-Dbq8qXYFUMp.md` carry word-for-word identical captions ("Agent history should not become the source of truth for how you work"), but their video descriptions are about different things — the second one is really about curating a knowledge base. So on at least one post the caption does not match the video. Don't assume caption and video always agree.

---

## 1. Core principles he repeats

**Getting the text out is the first bottleneck, and people skip testing it.**
He says this in almost every tool-comparison post. If the reading step gets a value wrong, nothing downstream — the AI answer, the business rule, the citation — can be right, and you will spend your time debugging the wrong layer. He calls testing the reading step "crucial and often skipped." (2026-07-21, 2026-07-24)

**Keeping the words is not the same as keeping the meaning.**
His single most repeated point. Plain text extraction usually captures every number and label on a page but throws away the grid — which row and which column each number sat in. The number is present and useless. (2026-07-15, 2026-07-16, 2026-07-17, 2026-08-04, 2026-08-25)

**Pick the tool by the output shape you need, not by which tool is "best."**
He restates this as a menu almost every week: do you need a narrative description, a clean table you can display as laid out, structured records you can run checks on, or a box on the page for a clickable source link? Different answers point to different tools. (2026-08-05 diagram post, 2026-08-04, 2026-07-24)

**Start from the failure that would break the product, then work backwards.**
Not "which OCR is most accurate" but "what wrong answer would be unacceptable here." That question tells you what fields matter, what checks to write, and what pages belong in the test set. (2026-07-24)

**Test on your own pages, not on someone's leaderboard.**
Every comparison he posts, he undercuts himself: he'd still label the data and count exact matches before trusting a model. Said explicitly on the census post, the equations post, the datasheet post. (2026-08-08, 2026-07-31, 2026-07-18)

**Two models agreeing is not proof either is right.**
On the map post, Qwen and Gemini returned nearly the same box for the same label, and he still says that's "nice, but not sufficient" — you need labelled ground truth, not consensus. (2026-08-07)

**Prefer the smaller, cheaper pipeline unless a page forces you up.**
When a plain OCR + Docling combination handled a scanned academic table, he said he'd keep the smaller pipeline if other pages pass the same checks, even though Gemini also worked. Same logic on charts: if figures only show up occasionally, use a cheap pipeline and reserve the expensive vision model for the pages that need it. (2026-07-20, 2026-08-27)

**Many "the AI made it up" bugs are actually "the AI never saw it" bugs.**
A whole run of posts in July argues that hallucination, context rot, and slowness are usually symptoms, and the disease is the fetching step. His slogan on screen: "Hallucination == Bad Retrieval." (2026-07-09, 2026-07-10, 2026-07-11, 2026-07-12)

**The real test is people's judgments; the automatic grader only copies them.**
"An LLM judge is not your eval, it's instrumentation." The eval is the set of human labels on real cases. The automatic judge exists so you can run those judgments continuously and at scale. He calls the judge "an approximation of an approximation" and says building it before you have human labels makes no sense. (2026-07-28)

**A score is a place to stand, not the goal.**
Small reference sets get over-tuned. Every metric has blind spots and can be gamed, on purpose or by accident. After every run you still read the actual cases. (2026-07-27)

**One visible failure poisons trust in everything that worked.**
On a Reddit example, an AI ran four successful steps (place search, place search, route overview, static route map) and failed the last one. The user then doubted all four earlier steps — were the searches real, was any of it made up? His line: backend logs are not the user experience. Silent failures are worse than loud ones. (2026-06-30)

**Interfaces meant for developers lose non-developers.**
Command-line tools carry hidden prerequisites (install a package manager, install Node, authenticate, keep it updated). A developer reads those as routine; a non-developer has no mental model connecting them to the thing they wanted, gets stuck, and stops trusting the product. (2026-06-27)

---

## 2. The test-first method — the specifics

This is the most reusable thing in the older half. The fullest single statement is 2026-07-24; the rest fills in details.

**Step 1 — name the breaking failure first.** (2026-07-24)
Begin with the mistake that would break the product. Everything else follows from that.

**Step 2 — write down what the application actually needs.** (2026-07-24)
Four things he lists: the fields you need, the reading order, whether you need source links back to the page, and whether you need boxes (page coordinates) for highlighting.

**Step 3 — test the real task, not a proxy.** (2026-07-24)
Run the actual job you intend to ship, on real pages.

**How many pages: 50–100 representative pages.** (2026-07-24)
That's his number for choosing a reading tool. "Representative" is doing work here — see the page-type section; he wants the hard cases deliberately included.

**A second, smaller number for an experiment set: 10–40 examples.** (2026-07-27)
He describes early reference ("golden") datasets as having 10, 15, 30, or 40 examples. Note these are two different numbers for two different jobs: ~50–100 pages to pick a tool, 10–40 examples as the stable set you run experiments against. He warns the small one is exactly the size that gets over-tuned.

**A third and smallest: "build a small test set" before choosing.** (2026-08-14)
On the handwritten bank form he says build a small test set of names, handwriting, and checkbox states before selecting a model, because the cost-versus-accuracy tradeoff on handwriting looks nothing like it does on printed text.

**How answers get labelled: people mark the truth, field by field.**
- "Measure field accuracy on a human-labeled set of pages." (2026-07-27)
- "Label columns and count exact matches before choosing a model to rely on." (2026-08-08)
- The eval "is the set of human labels you put on real traces." (2026-07-28)
- For maps, the ground truth is a labelled map you can measure against. (2026-08-07)

**How scoring works — four distinct scoring shapes he names:**
1. **Exact match per field.** Count exact matches, column by column. The census post is the clearest statement. (2026-08-08)
2. **Field accuracy on a human-labelled page set.** The headline number for a pipeline. (2026-07-27)
3. **Rule-based checks that pass or fail a whole record** — schema check, subtotal check, cross-field check. Records that fail get routed out. (2026-07-27)
4. **Box overlap** for anything positional. On maps, measure how much the returned box overlaps the labelled box, and also overlay it on the image and look at it with your own eyes. (2026-08-07)

**Step 4 — compare on five axes, not one.** (2026-07-24)
Accuracy, cost, speed, licensing, and hosting. Licensing is not decoration — see the license trap below.

**Step 5 — keep only outputs that pass the required checks.** (2026-07-24)

**Step 6 — routing, not just scoring.** (2026-07-27, 2026-07-21)
Records that fail a check go to re-extraction or to a person. Individual fields that fail get sent to a different model for a second opinion.

**Step 7 — rules will not catch everything, so sample the passes.** (2026-07-27)
This is the step people skip. He measures field accuracy on a labelled set *and* reads a sample of the records that passed the automatic checks. Checks only catch the failures you thought of.

**Step 8 — write a test specific to your product.** (2026-07-18)
On the Texas Instruments datasheet he validated the extracted records against the source table with what he calls a "product-specific eval." His conclusion from that page: this is exactly why you need your own evaluation on your own reading pipeline rather than a general benchmark.

**And after every experiment, read the cases.** (2026-07-27)
Inspect examples and traces, keep annotating, do error analysis. The score gives you grounding for that review; it does not replace it.

---

## 3. Checking habits — each with what it catches

**Check each label together with its value.** (2026-07-21)
Catches a right value attached to the wrong field. On a scanned form, Docling with RapidOCR read "B & W" as "BSM" *and* put it before the "MANUFACTURER:" label. A check that just asks "does this text appear on the page" passes while the field is wrong.

**Check the whole row as a unit.** (2026-07-23)
Catches a value that drifted out of its cell. Docling with RapidOCR lifted `51` up into the `# Form Types` header and left the actual row cell blank. The number 51 was still on the page, so a presence check passed. A row-level check failed it, because it tests the relationship rather than the existence of the text.

**Do the arithmetic in code and compare.** (2026-07-27)
Catches a misread digit that leaves the page looking fine. On a closing-cost form Docling turned an escrow term of "2 mo." into "23 mo." He multiplied $100.83 × 23 = $2,319, compared it to the extracted escrow total of $202, and the record failed. Nothing about the text looked wrong; only the math caught it.

**Run a schema check, a subtotal check, and a cross-field check after extraction.** (2026-07-27)
Three separate layers: is the shape right, do the parts sum to the stated total, do fields that should agree actually agree.

**Check every range boundary against the original PDF before you calculate with it.** (2026-07-17)
Catches an off-by-one bracket in a tax or tiered-pricing table, where being one dollar off on a boundary changes the answer for everyone near it.

**Test the edit boundary on redlines.** (2026-08-10) **(caption only)**
Catches a merged sentence that reads cleanly but means something different. Merged text can be off by a word or two and still look clean, and one word can flip the meaning.

**Decide in writing how a blank is represented, then validate against that.** (2026-08-06)
Catches the bug you get when you swap providers. Given the same field-schema prompt on a procurement form, Qwen wrote blanks as empty strings `""` and Gemini wrote them as `null`. Both were valid output. Pick one representation, state it in the prompt, and check every response against it.

**Distinguish "this box is empty" from "I failed to read this box."** (2026-08-06)
Basic OCR does not tell you which happened. On a form, those are completely different facts.

**Review every fragment the model had to guess at.** (2026-08-01)
Catches invented text. He cropped two labels at the right edge so they read "REQUISITION NUMBE" and "SOLICITATION NUMB." One model completed both to "NUMBER" — almost certainly the real word, but not actually visible on the page. His comment: if a law firm built a case on inferred text, it needs case-by-case vetting.

**Look at positional output with your own eyes, overlaid on the image.** (2026-08-07)
Catches a plausible-looking coordinate that lands in the wrong place. Box overlap numbers plus an actual visual overlay.

**Send failed fields to a different model for review.** (2026-07-21)
A cheap second opinion on just the fields that failed, rather than reprocessing the page.

**Log enough to locate which step failed.** (2026-08-03)
He logs document ID, rank, source version, and status for retrieval. In the refund-policy case a SQL query over the candidates table showed the current policy sitting at rank 7 with score 0.74 and `selected = False`, which pinned the failure to the fetching step rather than the model. It still didn't explain *why* it ranked 7th — he's explicit that the log localises the failure without explaining it.

**Include the imperfect cases in the test set on purpose, and decide the policy in advance.** (2026-08-24)
On a page with two clear signatures and two faint marks, he lists the decisions you must make before you ship: route to a person? go find the original document? request a fresh signature? treat as signed or not — and where exactly is the line? Nice-looking test sets hide all of this.

---

## 4. Page-type difficulty — what's hard and why

Ordered roughly easy to hard, based on what he showed in this half.

**Easy: big, clean, flat tables.** Size is not difficulty.
On a Federal Reserve table (F.224 Corporate Equities, 2022–2025 with quarterly columns) AWS Textract returned both header rows — the annual years and the quarterly year groups — plus all 33 data rows. His explicit takeaway: "Table size alone doesn't make a table difficult." What makes it easy is a clean layout. (2026-08-25)

**Medium: any table, read as plain text.**
Plain text flattens the grid into spacing. The numbers survive; the row-and-column relationship does not. Three worked examples: an Apple 10-K segment table where 29,375 survives but nothing marks it as Rest of Asia Pacific for 2022 (2026-07-15); a Tesla revenue table where 5,515 could get attached to the wrong year (2026-07-16); an IRS tax table where the formula gets separated from its filing status and income range, which can produce the wrong tax (2026-07-17).

**Hard: nested and merged tables.**
When one heading spans several rows, flat output has to pick one row and it can pick wrong. On a films table Docling returned a flat four-column Markdown table and put Chris Evans under "Slumdog Millionaire" instead of "Sunshine"; Chandra 2 returned HTML with proper row spans and kept him in the right group. His framing: flat tables are easy, nested layouts need an output format that can hold hierarchy — which is why HTML beats Markdown here. (2026-08-26)

**Hard: tables with condition columns (technical datasheets).**
On a Texas Instruments LM358B datasheet, values lose their MIN / TYP / MAX / CONDITION / UNIT associations. Docling duplicated the condition columns; Chandra attached a temperature condition to the wrong row; a generic Gemini Markdown prompt left the columns ambiguous. (2026-07-18)

**Hard: scans with no text layer.**
Plain text extraction returns literally nothing. There's no text to pull; you need something that reads pixels. (2026-07-19)

**Hard: handwriting.**
Two examples. A historical handwritten vineyard register ("CONNOTATIO VINEARUM POSSESSIONIS") where Docling with RapidOCR came back with only `27`, an image marker, and the fragment "in 2" — he labels this a total failure (2026-07-22). And a scanned UBL bank form where five models produced three different spellings of one handwritten name: Jaqfiri, Jaffri, Jaferi (2026-08-14).

**Hard: checkboxes and other filled-vs-blank marks.**
On that same bank form he says checkboxes were *worse* than the handwriting, with checked boxes being missed. (2026-08-14)

**Hard: signatures.**
Faint marks are the problem, not signatures as such. On a four-signature page (two clear, two faint), Gemini marked all four as signed with no location and no confidence score; AWS Textract found only three of the four regions, at confidence between 32% and 41%. Neither tool reliably confirmed four signatures. He guesses the faint marks might be from repeated scans before the final signing, or an erased signature. This matters most on legal and medical documents, where whether the document is usable depends on it. (2026-08-24)

**Hard: charts and figures.**
Plain text gives you only the prose around the chart. And getting *complete* data out is its own problem: on an FDIC chart covering 2006–2025, a cropped-region-to-vision-model route estimated all 80 quarterly values, while Chandra reading the whole page in one pass returned only 20 annual values. Values from a chart are estimates unless the chart prints its numbers — on grouped bar charts he got all 50 bars back as CSV with a field literally called `bar_height_estimate`, and said for exact reporting you still need the source dataset. (2026-08-27, 2026-07-29)

**Hard: diagrams and flowcharts.**
The nodes are usually fine; the connections are where things break. Qwen drew an edge between two boxes in a NASA systems-engineering diagram that doesn't exist in the original. (2026-08-05)

**Hard: maps and labels inside figures.**
Plain text mangles map labels — he showed "GREENWICH BAY" and "MOUNT HOPE BAY" coming back with extra spaces and "MASSACHUSETTS" broken up. Region detection finds the map but doesn't read what's inside it. (2026-07-30, 2026-08-07)

**Hardest thing in this half: dense grid forms.**
A 1950 US Census population schedule broke every tool differently — one invented a generic household form and then looped the same farm-work question until it ran out of tokens, one returned a corrupted block, one mislabelled what a column even asked. See the census row in the tool table below. (2026-08-08)

**Also hard: scanned mathematical formulas.** (2026-07-31)

**Also hard, and high-stakes: redlines and strikethrough edits.** (2026-08-10) **(caption only)**
The tools don't just miss the edit, they silently fuse the deleted text with its replacement into one sentence that reads fine.

**A category of its own: documents that look like forms but have no fillable fields.**
A two-page volunteer application looked like a form and had zero interactive fields — you'd have to print it or draw on top of it. (2026-07-26)

---

## 5. Tool comparisons

**Read every line as "he found X on N pages," where N is usually one.** These are single-page demos, and he says so himself. The pattern of failure is the transferable part; the ranking is not.

### Table: what he tested, on what page, what he found

| Date | Page he used | What he found |
|---|---|---|
| 2026-07-15 | Apple 10-K segment table | Plain text kept 29,375 but lost which row/column it belonged to. Docling exported explicit rows and columns so the app could look the value up. His rule from this page: plain text for prose, Docling for table values. |
| 2026-07-16 | Tesla revenue recognition table | Plain text turned the grid into a vertical list; a value like 5,515 could land on the wrong year. Docling rebuilt it from the PDF's existing text layer and kept 5,515 with "Energy generation and storage sales" for 2023. |
| 2026-07-17 | IRS tax table | Plain text separated the formula from its filing status and income range. Docling rebuilt rows and columns so each record could be exported to a dataframe or CSV with those fields kept together. |
| 2026-07-18 | TI LM358B/LM358BA datasheet | Docling duplicated the condition columns. Chandra returned cleaner HTML but attached the temperature condition to the wrong LM358B row. A generic Gemini Markdown prompt left columns ambiguous. What worked: asking Gemini Flash for one JSON record per condition with explicit fields, then validating those records against the source table. |
| 2026-07-19 | Scanned table, no text layer | Plain text: nothing. Docling + RapidOCR: got the grid but misread some words. Chandra: clean, accurate HTML table. Surya: gave row, column, and cell boxes, but its text was worse on this shape. Gemini also read it correctly. His workflow: Chandra for content, add Surya only when the app needs a clickable source box. |
| 2026-07-20 | Scanned academic table (genetic programming paper) | RapidOCR recovered the text and Docling kept the GP-35 / GP-15 / GP-5 column groups with their B&B Stage1 and GP Stage subcolumns. Gemini produced the same useful table. He'd keep the smaller pipeline if other pages pass the same checks. |
| 2026-07-21 | Scanned form, manufacturer field | Docling + RapidOCR read "B & W" as "BSM" and placed it before the "MANUFACTURER:" label. Chandra and Gemini both returned "B & W" correctly. He notes Chandra is built for document reading while Gemini is a general vision model. |
| 2026-07-22 | Handwritten vineyard register | Docling + RapidOCR: total failure — `27`, an image marker, and "in 2". Chandra read the handwriting and returned nested HTML headers. Gemini returned structured Markdown. Either model worked on this page; he picks Chandra when table structure matters. |
| 2026-07-23 | NAF dataset characteristics table | Docling + RapidOCR moved `51` into the `# Form Types` header and left the row blank. Gemini Flash kept `51` in the right cell. He'd use Gemini for this page because the application needs that cell. |
| 2026-07-26 | Two-page volunteer application (Boys & Girls Club of Fond du Lac) | commonforms (open source, `jbarrow/commonforms`) — its form-field detector found 31 text inputs and 12 choice buttons across two pages, then wrote them back into the same file as real PDF widgets you can type into or fill from code. |
| 2026-07-27 | Closing Cost Details form | Plain text captured every fee and amount but lost each fee's link to its section and subtotal. Docling rebuilt the tables but changed the escrow term from "2 mo." to "23 mo." A cross-field check caught it. |
| 2026-07-29 | Grouped bar charts (MMWR 2011, fruit/vegetable consumption) | Plain extraction: unusable. Gemini 3.5 Flash with a generic prompt: prose describing the bars — better but not usable. Gemini instructed to return CSV with one row per chart, group, and frequency band: all 50 bars as estimates in a `bar_height_estimate` field. The prompt, not the model, was the difference. |
| 2026-07-30 | NOAA coastal chart (Coast Pilot 2, Chapter 6) | Plain text mangled the labels. Gemini 3.5 Flash returned "Providence" at normalized coordinates [0.24, 0.28], origin top-left, both axes 0–1. Overlaid, the dot landed on the word. |
| 2026-07-31 | Scanned textbook equations (orbital mechanics) | Plain extraction: completely wrong text. Docling: replaced several formulas with `<!-- formula-not-decoded -->`. Gemini 3.5 Flash, asked to transcribe as Markdown and LaTeX preserving symbols and equation numbers: correct on equations 1.5 and 1.6. He'd still build a reference set and test consistency before using it. |
| 2026-08-01 | Deliberately cropped form labels | One model completed "REQUISITION NUMBE" and "SOLICITATION NUMB" to "NUMBER". Surya went further and invented an unrelated project-status table. Qwen stopped at the visible letters. Gemini stopped, and added a `[cut off]` marker when prompted to. |
| 2026-08-04 | US government financial statement table | Basic OCR lost the link between each number and its column heading. Docling and Chandra both restored the complete table including the final "Net position, end of period" of −39,883.8. Qwen and Gemini returned JSON records instead. His split: Docling or Chandra when the result must be displayed as the source laid it out; Qwen or Gemini when you want to run extra checks or render it differently. |
| 2026-08-05 | NASA systems-engineering engine diagram | Chandra: accurate narrative description of the three process groups and their arrows. Surya: marked the whole diagram as one region — useful for citations. Gemini: JSON graph of nodes and edges. Qwen: similar graph but added an edge from System Design Processes to Product Realization Processes that isn't in the original. |
| 2026-08-06 | Government procurement form | Chandra rebuilt the form as HTML tables. Surya returned text with page locations (polygon coordinates plus confidence). Qwen and Gemini both returned valid JSON for all 40 records from the same field-schema prompt — but Qwen wrote blanks as `""` and Gemini as `null`. |
| 2026-08-07 | Map with internal labels (Salt Lake City area) | Plain extraction couldn't read labels inside the figure. Surya got the large map region but not the labels inside it. Qwen and Gemini both found five labels (Ensign Pk Monument, CAPITOL, Matheson Sch, Rose Park Sch, STATE FAIRGROUNDS) with boxes on a 0–1000 full-page grid. For "Ensign Pk Monument", Qwen returned [651, 158, 725, 194] and Gemini [650, 164, 731, 194] — both on the right label. |
| 2026-08-08 | 1950 US Census population schedule | Chandra: invented a generic household form, then repeated "If he is not on a farm, is he working on a farm?" until it used up its tokens. Surya: form block came back corrupted. Qwen: complete JSON, but said column 2 asks whether someone lived in the same house a year ago when column 2 is actually the house and room number. Gemini: got column 2 and column 3 (dwelling unit number) right. |
| 2026-08-10 **(caption only)** | Redlined rule amendment | PyPDF returned the text with no trace of the strikethrough. Docling structured it as a table and also dropped the edit, leaving "Rule 2002 must conform to Rule 1005 include the information that Form 416B requires" as one broken sentence. Chandra kept the strikethrough and got the edit boundary exactly right. Gemini marked the edit but struck out "must", which isn't struck in the original. |
| 2026-08-14 | Scanned UBL bank account form, handwritten name + checkboxes | Five models, three spellings of the name (Jaqfiri, Jaffri, Jaferi); checkboxes worse still. Gemini was the most expensive he tested and the only one that got both the name and all six reference checkboxes right. |
| 2026-08-24 | Legal page with four signatures (two clear, two faint) | Plain text can't read signatures at all. Gemini, with a reasonable prompt, returned `"signed": true` for all four — no location, no confidence. AWS Textract found 3 of 4 signature regions, confidence 32%–41%. |
| 2026-08-25 | Federal Reserve F.224 Corporate Equities table | PyPDF returned the numbers and header text but not as table fields, so it's hard to use programmatically (e.g. for citations). AWS Textract returned both header rows and all 33 data rows. Worked well because the layout is clean. |
| 2026-08-26 | Nested films table (Slumdog Millionaire / Sunshine) | Docling: flat four-column Markdown, Chris Evans under the wrong film. Chandra 2: HTML with row spans, Chris Evans in the right group. |
| 2026-08-27 | FDIC Chart 8, unrealized gains 2006–2025 | Plain text: surrounding prose only. Docling: kept the prose and marked the chart as an image placeholder with a box — crop that region, send it to a vision model, convert to CSV, and it estimated all 80 quarterly values even though most bars are unlabelled. Chandra reading the full page in one pass: returned text plus chart data as an HTML table, but only 20 annual values, not all 80 quarterly ones. |

### His own one-line capability summary of each tool (2026-07-24)

Worth quoting because it's his own compressed mental model:
- Plain text extraction — reads existing text only
- Docling — helps rebuild tables
- RapidOCR — reads scans
- Chandra — handles difficult document structure and handwriting well
- Gemini — general vision model, follows specific output schemes
- Surya — smaller, returns layout and table boxes

### Tools outside the reading pipeline that he named

- **commonforms** (`jbarrow/commonforms`, open source) — turns a flat form into a real fillable form. (2026-07-26)
- **AWS Textract** — strong on the clean dense table (all 33 rows), weak on faint signatures (3 of 4, 32–41% confidence). (2026-08-25, 2026-08-24)
- **Pangram** (AI-text detector Substack was adopting) — he found it easy to flip. See the surprises section. (2026-07-27)
- **Postgres** — where he stores AI activity logs, instead of a specialist eval vendor. (2026-07-30)
- **The search comparison** (2026-07-08): on multi-step tasks over complex PDFs he showed Codex + Mixbread (thinking high) at 64.42% accuracy with 17.38 tool calls, Codex + corpus (thinking high) at 56.39% with 34.5 calls, and GPT 5.4 + semantic search at 51.9% with 86.4 calls. His point: a better search tool bought both higher accuracy *and* fewer calls, which is unusual.

### The license trap (2026-07-03)

Not a comparison but the most immediately actionable item in this half. He says one of the most-used Python PDF libraries — named in the video description as **PyMuPDF** — is licensed AGPL-3.0, which requires commercial projects to publish their own code. His advice: check your codebase for it and use **pypdfium2** instead, which is Apache-2.0 / BSD-3-Clause and commercially friendly. Credited to a tip from Joe Barrow. This is why "licensing" is one of his five comparison axes.

---

## 6. Techniques and rules of thumb, collected

**When the generic prompt fails, ask for records instead of a table.** Repeatedly the fix wasn't a different model, it was a different requested output shape: one JSON record per condition on the datasheet (2026-07-18), one CSV row per chart group and frequency band on the bar charts (2026-07-29), one record per filing-status range on the tax table (2026-07-17).

**HTML beats Markdown for tables that have merged or spanning cells**, because Markdown has no way to express a cell spanning rows. (2026-08-26, 2026-07-22)

**Crop the hard region and send just that.** The chart workflow: let a cheap tool find and box the chart, crop it, send the crop to the expensive vision model. (2026-08-27)

**Only add boxes/coordinates when the product actually needs clickable source highlights.** He says this three separate times — it's a cost and complexity decision, not a default. And the reason to want them is user trust. (2026-07-19, 2026-07-20, 2026-07-24)

**Save coordinates on a 0–1 scale, plus the image size, origin, and coordinate range.** Then another service can redraw the same point without the original image dimensions. Note the tools disagree on scale — Gemini gave him 0–1 normalized coordinates on one page (2026-07-30) and 0–1000 grid coordinates on another (2026-08-07), so storing the range matters.

**Match the tool to what you'll do with the answer:** display as the source laid it out → Docling or Chandra; run checks or re-render → JSON records from Qwen or Gemini; citation region → Surya. (2026-08-04, 2026-08-05)

**Expect the expensive option to sometimes be the only one that works.** On handwriting plus checkboxes, Gemini cost the most and was the only one that got it right. His point is that the cost/accuracy tradeoff you measured on printed text does not carry over to handwriting. (2026-08-14)

---

## 7. His retrieval / search argument (the July cluster)

Six consecutive posts making one case. Relevant to document work because he keeps using documents as the example.

- **The claim:** failures that look like hallucination, context rot, or slowness often begin in the fetching step. (2026-07-09)
- **Why hallucination:** if the fetch brings back unrelated code or text, the generating step has nothing right to work from and produces a plausible-sounding reason instead. His example: asked why "Authlib" was chosen, the agent searched, missed the actual code, and invented reasons "most people" choose it. On-screen: "Hallucination == Bad Retrieval." (2026-07-11)
- **Why context rot:** the system does many searches to compensate for bad ones, the context window fills with mostly-irrelevant material, and it gets slow. Find the right files faster and a higher share of the context is actually relevant. (2026-07-10)
- **Why "just return more results" backfires:** on a flashcard use case (AnkiHub, medical students), raising top-K to 50, 100, 150 to be sure you caught every relevant card brings context rot, compaction limits, degraded performance, more latency, and more cost. (2026-07-12)
- **The diagnostic question when the right document ranks 7th:** either return seven or more results (more tokens, more latency, works if you genuinely need all seven) or sort better by adding a re-ranking step — a slower but more accurate model, e.g. a cross-encoder, that re-sorts after keyword and semantic results have been merged. If the extra results are noisy, re-ranking is the better fix. (2026-07-13)
- **When exact-match search misses:** unusual naming conventions. The idea in the query is right, the words are wrong — that's what meaning-based search is for. He rejects the alternative of maintaining a dictionary of your team's terms in an instruction file, because it needs updating every time anyone adds a module. (2026-07-14)
- **Merging two search methods with incomparable scores:** Reciprocal Rank Fusion, which throws away the raw scores and uses only rank position: `rrf_score = 1 / (k + rank)`. His illustration: keyword scores 15 / 8 / 6 versus semantic 0.8 / 0.3 / 0.2 — not comparable. With k=1 the fused scores spread out (0.5, 0.33, 0.25, 0.2); with k=100 they bunch up (~0.0099 to ~0.0096). Higher k flattens the differences. k=60 is a common default. (2026-07-02)
- **A concrete debugging case:** an agent answered with an old refund policy. The trace showed rank 1 = old policy (revision 18, selected), rank 2 = a returns FAQ (selected), rank 7 = the current policy (revision 19, score 0.74, not selected) — the context builder only kept ranks 1 and 2. Fixes he'd consider: decide whether historical revisions belong in the corpus at all and delete them if not; or boost the score by how recently a document was published or updated. (2026-08-03)

---

## 8. His views on evaluation and grading (beyond documents)

- **The eval is human labels on real traces; the automatic judge is instrumentation to scale those labels.** Build the labels first. (2026-07-28)
- **A stable reference set is for running experiments, not for chasing a number.** Teams build 10–40 examples, hill-climb the metric, and stop looking at cases. Every metric has blind spots and can be gamed. (2026-07-27)
- **He'd rather build his own annotation screen than use an eval vendor.** His three objections: trace storage is something his application database already does (he'd use Postgres); the automated features add little; and their annotation screens can't show the context each task actually needs — you have to join a trace against application data, user profile, chat history, and actions the user took outside the agent conversation. He says he can't think of a project he'd recommend a vendor tool for. Strong opinion, single source. (2026-07-30)

---

## 9. His views on agent memory, skills, and knowledge bases

- **"Memory is another word for retrieval."** Memory isn't storage, it's storing the right thing and fetching it at the right moment on the right trigger. A project wiki, a chat with a friend, a social post, and a code snippet should not be stored, chunked, or fetched the same way — some need keyword search, some meaning-based, some are fine with plain text search. Each also needs lifecycle rules: what gets stored, updated, deleted, and when it should be fetched. A single memory bucket looks fine at first and gets cluttered. (2026-07-29)
- **Same argument, restated with examples** (2026-08-09) **(caption only)**: library docs synced from a repository refresh on every release; a research paper goes out of date a completely different way; information auto-extracted from AI logs is a third thing again. Chunking differs for each. And: "for very technical work keyword search is a lot stronger; for other things semantic search wins."
- **Don't auto-extract every workflow from chat history into reusable instructions.** A chat is off-the-cuff thinking about one specific case. Turning all of it into structure converts temporary workarounds into permanent process overhead. Use history for ideas, then decide per item whether it's good, general enough to reuse, or something you should fix in your workflow instead. (2026-08-04)
- **Why it breaks mechanically:** one instruction file per activity keeps growing until it's unmanageable; splitting it produces overlapping trigger conditions. Either way the model gets a longer list of conditionals with no central view of all the triggers, and fires the wrong one. His fix: once the trigger list is large, add a search step instead of listing every trigger. (2026-08-06)
- **And the more common failure is quieter:** the workflow gets extracted once and never maintained, so it never serves its purpose — which he says is worse than not extracting it. (2026-08-06)
- **A personal knowledge base has to beat a plain web search by a lot, or it isn't curated enough.** A pile of files the agent keeps updating isn't a knowledge base. Results should reflect your taste and people whose work you trust — he names Hamel Husain as a source he'd weight highly. Continuously auto-updating it from project chats degrades quality. (2026-08-05, `Dbq8qXYFUMp` — note this is the post whose caption doesn't match its video)
- **The legitimate use of agent history: source material for writing.** Search past work for what you actually did and considered, including failed attempts you'd otherwise forget, and for places where you didn't follow your own stated rule. Those exceptions are the nuance that makes writing useful. (2026-08-03)

---

## 10. Surprising or non-obvious things

**Table size isn't difficulty.** A 33-row dense Federal Reserve table with two header rows came out clean, while a small nested films table broke most tools. Layout complexity is the variable, not volume. (2026-08-25, 2026-08-26)

**A number can be present and still be wrong.** Both the `51` case and the "BSM" case pass a text-presence check while the field is wrong. This is the single most transferable insight in the older half: any check of the form "is this value somewhere on the page" is nearly worthless. (2026-07-23, 2026-07-21)

**A wrong value can be caught by arithmetic when no amount of reading would catch it.** "23 mo." looks exactly as plausible as "2 mo." until you multiply. (2026-07-27)

**The same model gives different coordinate conventions on different pages.** 0–1 normalized in one post, 0–1000 grid in another — hence his insistence on saving the coordinate range with every result. (2026-07-30, 2026-08-07)

**Two providers can both return perfectly valid output and still break your code.** `""` versus `null` for a blank field. The bug shows up when you switch providers, not when you build. (2026-08-06)

**The prompt often mattered more than the model.** Same Gemini, generic prompt → useless prose about the bars; specific "one row per chart, group and band as CSV" prompt → all 50 bars. Same for the datasheet and the LaTeX equations. (2026-07-29, 2026-07-18, 2026-07-31)

**Failure by loop.** On the census form, Chandra didn't just get it wrong — it invented a generic form and then repeated one question ("If he is not on a farm, is he working on a farm?") until it exhausted its token budget. Worth watching for as a distinct failure shape: not a wrong answer, a runaway one. (2026-08-08)

**Invention gets worse when the input is ambiguous.** On deliberately cropped labels, Surya didn't just complete a word — it fabricated an entire unrelated project-status table. Cropping is a cheap way to probe how a model behaves under uncertainty. (2026-08-01)

**Two tools can be right about the edit and still wrong about the wording.** On the redline, Chandra got the edit boundary exactly right while Gemini marked the edit but struck out a word ("must") that isn't struck in the original. A half-correct redline is arguably more dangerous than a missed one. (2026-08-10, **caption only**)

**A widely used PDF library can legally require you to publish your source code.** AGPL-3.0 on PyMuPDF. Most people never check. (2026-07-03)

**Popularity says nothing about maintenance.** Of the top 300 reusable AI instruction sets on skills.sh, 29% had exactly one commit and 40% had two, while some had up to 450,000 downloads. He reads a package that's never been updated after release as a sign the creator doesn't actually use it. Sourced from a post by Hamel. (2026-06-28)

**A very popular instruction set can be optimized for the wrong thing.** He critiques a front-end design skill with ~450,000 installs (and used by Anthropic) for producing output tuned for social-media impact — extreme aesthetics, unconventional spacing — rather than usable interfaces. His distinction: an interface people use every day for real transactions needs maximum clarity and no surprises in layout or hover behaviour; a landing page can break patterns and be delightful. Popularity measures shareability, not fitness. (2026-06-28)

**An AI-text detector flipped on a formatting change.** He tested Pangram (which Substack was adopting for a "Scan for AI text" feature) and found that adding a section divider moved one sample from 100% human to 100% AI, and removing it reversed that. Separately, telling an AI to insert small grammar mistakes moved AI-written text toward "AI-assisted" with a much better score. He notes it tends to flag structured elements like bullet lists. His worry is the incentive: writers stripping out useful structure or adding errors to look human. "Be weary [wary] of turning a metric into a target." (2026-07-27)

**Speculative decoding is the one speed trick with no quality cost** — and his explanation of why is the non-obvious part. Most speed-ups trade quality: swapping in a diffusion model can cost around 10% accuracy, quantization degrades as it compresses. Speculative decoding has a small draft model guess several tokens ahead and the large model verify all of them in one pass, keeping the correct prefix and replacing the first wrong token. Because the big model checks every token, the output is mathematically guaranteed to come from the same distribution as the big model alone. Roughly half the latency, same answers. (2026-08-15, 2026-08-18, 2026-08-19)
- **Why more total work is still faster:** at small batch sizes, generating one token spends most of its time loading model weights from memory while the arithmetic units sit idle. Verifying several drafted tokens uses that idle capacity, so the extra work is nearly free. At large batch sizes the hardware is already busy and the speed-up disappears — serving systems can switch speculation off automatically when batches get big. (2026-08-20)
- **Why it matters specifically for document work:** positional output is token-expensive. One bounding box written as `[12 24 48 53]` is 13 tokens (8 digits, 2 brackets, 3 spaces) and therefore 13 sequential passes under normal decoding. (2026-08-18)
- The draft model in his example was trained by Joe Barrow for Chandra 2 and is open source. (2026-08-15)

**One failure erases several successes.** The Seoul map example: four tool calls worked, the fifth failed, and the user's reaction was to doubt all four. Someone in the comments checked the logs and confirmed the calls had worked — his response is that backend logs are not the user experience. (2026-06-30)

**How your product gets into someone's AI assistant is a product surface too.** He argues an MCP server, a command-line tool, or a skill file deserves the same design attention as the web app — teams give a command-line tool real thought about safety and composability, then throw together an agent integration in a two-hour sprint by wrapping existing endpoints, and it goes unused because the usage context is completely different. (2026-06-30)

---

## 11. Things in this half that are context, not document technique

Flagged so the merge doesn't over-weight them: how meaning-based image search is trained using paired images and captions (2026-06-29, part of his search course); the speculative-decoding engineering cluster (2026-08-15 through 2026-08-20) — real content, but about serving models rather than reading documents; the AI-writing-detector post (2026-07-27); the three posts about how he uses his own chat history for writing (2026-08-03, 2026-08-04, 2026-08-05); and the two 2024 personal videos, which have no document content at all.

---

## 12. Open questions to resolve when merging with the newer half

- He gives three different test-set sizes for three different jobs (50–100 pages to choose a tool; 10–40 examples as an experiment set; "a small test set" for handwriting). Check whether the newer posts firm any of these up or contradict them.
- Chandra vs. Chandra 2 — he starts naming "Chandra 2" from 2026-08-15 onward (2026-08-26 too). Earlier posts just say "Chandra." Don't merge the two names into one row without checking dates.
- Whether he ever states an accuracy threshold — a "good enough" field accuracy number. Nothing in the older half gives one.
- Whether the newer half revisits the eval-vendor position (2026-07-30), which is his strongest single-sourced opinion here.
