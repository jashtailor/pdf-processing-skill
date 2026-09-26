---
name: pdf-document-processing
description: Practical craft for setting up and testing document-extraction agents on PDFs, scans and forms — building the test set, checking the output, knowing which pages are hard, and reading tool claims. For the person who configures and tests extraction in a product's own interface, not the person who picks text-reading engines or writes code.
---

# Getting information out of documents, reliably

Distilled from 117 posts by Isaac Flath (@isaac_flath), June–September 2026. See
"Where this comes from" for what the source misses.

## When to use this

Use it when you are setting up a document-reading agent — telling it which fields to pull
from invoices, contracts, forms, drawings or scans — and deciding whether what comes back is
good enough to trust. It assumes you work in a product's own interface: you write the
instructions, pick the test documents and decide what "correct" means, but you don't choose
the software that reads the page and you don't write code. The two places where code is
genuinely needed (arithmetic on extracted numbers, counting fields) are called out so you
can ask an engineer.

## Core principles

- **Reading the page is the first thing that breaks, and the step people skip testing.**
  Every answer, dashboard and rule downstream inherits what the reader got wrong, and you'll
  debug the wrong layer for days.
- **Getting the words right is the easy half.** The usual failure is a correct value in the
  wrong row or column, or merged with its neighbour, and nothing looks broken. One value of
  `51` was lifted into the column heading and its row came back empty — "is 51 on this
  page?" passes.
- **Start from the failure that would break the product**, not from "which reader is most
  accurate." That tells you which fields matter, which checks to write, and which pages
  belong in the test set.
- **No tool wins everywhere, so test on your own pages.** On one page the cheap option is
  right and the expensive one wrong; on the next it flips. Two tools agreeing isn't proof
  either is right — only a person's labelled answer is.
- **Make checking cheap, then measure what it costs you.** If every answer points back to
  the spot on the page it came from, a person confirms it in seconds. A teacher converting
  maths worksheets said checking fell from hours to five or ten minutes — that, not the
  score, was the win. If checking costs what doing it by hand costs, you saved nothing.
- **Cost and speed are results, not footnotes.** On one timetable a plain, non-AI table
  reader matched a large image-reading model, 46% faster and 78% cheaper. Spend the
  expensive reader only on pages that need it.
- **Ask for the shape you need.** Requesting structured records, or HTML instead of plain
  text for tables with merged cells, has fixed more problems than switching tools — plain
  text can't say "this heading covers four columns." Usually a setting you control.

## The test-first method

1. **Name the wrong answer that would cause real damage** — a wrong signature status on a
   contract, a wrong amount on a loan file. Build the test around it.
2. **Write down what you need**: which fields, in what order, and whether users must be able
   to click from an answer back to the page.
3. **Collect 50–100 typical pages** — typical of real intake, not the clean samples. Put the
   hard cases in on purpose: faded signatures, rotated scans, handwriting, drawing sheets.
4. **Have people write the right answers down first**, field by field. That human-labelled
   set *is* the test. An automatic scorer, AI grader included, only copies those judgments so
   they can run at scale — it comes second, never first.
5. **Score exact matches, field by field** — not "did it roughly get it." Split failures into
   misread, missing and invented: "82%" doesn't tell you what to fix, "eleven invented" does.
6. **Compare accuracy, cost and speed together**, and send licensing and hosting questions to
   an engineer before anything ships.
7. **Decide where failures go** — re-read the page, send only the failed fields to a
   different reader, or route the document to a person.
8. **Read a sample of the ones that passed.** Automatic checks only catch mistakes you
   already thought of. This is the step everyone skips.
9. **Rerun your baseline when the scoring changes** — numbers from two versions of a scoring
   tool aren't comparable. A day-to-day set of 10–40 examples is normal, but one that small
   gets tuned into meaninglessness if you stop reading actual cases.

## Checking habits

Each habit, and what it catches.

- **Check the label together with its value.** *Catches* a right value on the wrong field. A
  manufacturer field came back as `BSM` instead of `B & W`, placed *before* its own label;
  "does this text appear on the page" passed. Check whole rows the same way — a value that
  drifted out of its cell still exists somewhere.
- **Do the totals math in code.** *Catches* a misread digit that looks plausible. An escrow
  term read as 23 months instead of 2: 23 × $100.83 is $2,319, not the stated $202, and the
  text looked fine. Pull the numbers out and let code do the arithmetic — a floor plan read
  correctly still came out measured wrong.
- **Pick one way to write "blank" and enforce it.** *Catches* a break when the model
  underneath changes. On identical instructions one model wrote empty fields as `""` and
  another as `null`; both valid. State the convention and check every response against it.
  Decide separately how "this box is empty" differs from "I couldn't read this box" — most
  readers won't say which happened — and say what formatting means, because a grey cell
  meaning "no guidance" is information, not a gap, and readers discard colour.
- **Write the rule for faint signatures and checkboxes before you test.** *Catches* an
  unsigned document treated as signed. On a page with four signature lines — two clear, two
  faint — one tool called all four signed, another found three at 32–41% confidence. Decide
  in advance: person, re-signed copy, or treat as unsigned, and where the line sits.
  Checkboxes fail more often than handwriting in almost every test; give them their own rule.
- **Ask about document status as its own question.** *Catches* a draft treated as a signed
  deal. On one agreement every date and amount was perfect and the diagonal "DRAFT, NOT FOR
  EXECUTION" stamp was dropped. Struck-out edits are worse: tools fuse the deleted words and
  their replacement into one sentence that reads cleanly and means something else. Both sit
  *on top of* the text, so ask directly.
- **Review anything the reader had to guess.** *Catches* invented text. A label cropped to
  `REQUISITION NUMBE` was completed to `NUMBER` — almost certainly the real word, but not
  visible on the page. Another tool fabricated a whole unrelated table.
- **Count the fields you expected.** *Catches* a section skipped silently. One reader rebuilt
  a form grid, stopped at question 33 and dropped seven fields without a word. For a form
  you'll run thousands of times, build the field list from the *blank* copy — that gives you
  the instructions and a free missing-field check at once.
- **Ask for exact copies, not tidy ones.** *Catches* a model "correcting" your data. A
  printed lab value `HCO: 3:21` came back as `HCO3: 21`: plausible, tidy, wrong. Check exact
  digits on clean pages too — one readable balance sheet returned 369,488 for 365,848.
- **When an answer is wrong, ask what the agent actually saw.** Many "it made that up" cases
  are "it never saw it" — wrong page, or an old version. If something is missing, crop to
  that spot and retry; page size and resolution are often the real cause.

## Which pages are hard

Check whether a page already has usable text before sending it anywhere, and route pages by
difficulty instead of pushing everything down one path.

| Page type | Difficulty | What typically goes wrong |
|---|---|---|
| Large, clean, flat table | Easy | Size alone isn't difficulty — a clean 33-row table came out whole |
| Any table read as plain text | Medium | The numbers survive, the row-and-column relationships don't |
| Merged or nested table | Hard | Rows attach to the wrong group; a heading repeats onto every row or swallows a value |
| Wide table with formulas | Hard | Plus and minus signs dropped; one misread header collapsed the whole grid |
| Scan with no text stored in the file | Hard | Plain text extraction returns nothing at all |
| Handwriting | Hard | Five readers, three spellings of the same name |
| Checkboxes and signatures | Hard | Ticks missed; faint marks called signed, or unsigned, with no confidence given |
| Charts without printed numbers | Hard | Values are estimated, not read — one gave 28.8% against a published 28.5% |
| Diagrams and flowcharts | Hard | Labels read fine, connections dropped or invented |
| Maps and labels inside figures | Hard | Labels mangled; a printed elevation swapped for a nearby number |
| Rotated pages | Hard | Fails until the page is turned upright as a separate first step |
| Drafts, watermarks, redlines | Hard | Vanish silently and change what the document means |
| Drawings and floor plans | Hard | Repeated symbols undercounted; measurements computed wrong |
| Colour-coded tables | Hard | The colour is the value, and it gets discarded |
| Dense grid forms (census-style) | Very hard | Sections skipped, columns mislabelled, output loops until it gives up |
| Scanned equations | Very hard | Replaced with placeholders, or transcribed as garbage |
| Mixed bundles (many documents in one file) | Hard | Must be split first; continuation pages get filed under the wrong type |

## Tool notes — leads to test, never facts

Every result below is a one-to-three-page demo, and the source says so himself. Use them to
have something to suggest when a page type keeps failing, and to set expectations when
scoping — never to rank vendors, never quoted to a client as a measured result.

- **Plain text pulled from the PDF** — keeps the words, loses table structure, watermarks and
  strikethroughs; returns nothing on a scan with no stored text.
- **Table-rebuilding tools (Docling and similar)** — strong on clean tables, fast and cheap;
  seen repeating headings, shifting a value into a header, missing a draft watermark.
- **Document-specialist readers (Chandra and similar)** — best seen on messy and handwritten
  tables and on keeping a struck-out edit exactly right; broke badly on a dense grid form.
- **General image-reading models (Gemini and similar)** — the only reader to get a handwritten
  name and all six checkboxes right on one bank form, and the most expensive tried; also seen
  misreading a digit and tidying a printed value.
- **Layout and location tools (Surya and similar)** — give the box on the page so users can
  click through to the source; weaker text, and once invented a table.
- **Cloud services (Textract and similar)** — handled a big clean table well; dropped plus and
  minus signs from formulas; weak on faint signatures.
- **Cheap classical tools (PaddleOCR and similar)** — matched an image-reading model on one
  timetable, faster and cheaper; its rotation detector fixed a sideways page nothing else read.
- **Form-field and bundle-splitting tools** — turn a flat form into fillable fields, or split
  one file into separate documents. Good scoping ideas for construction and intake paperwork.
- **Agent-driven readers** are arriving, billed as accurate on genuinely hard pages, slowly and
  expensively. Worth testing on your worst pages only.
- **To pass to an engineer, not act on:** at least one widely used Python PDF library carries a
  licence that would require a commercial project to publish its own source code.

## Where this comes from

117 items from one Instagram account: 100 reels, 16 story highlights, 1 story. Nobody watched
the videos — every claim rests on a caption plus an automated description of what was on
screen, and those descriptions state that exact slide text, table cells and chart values were
not captured. **23 of the 117 are caption-only**: the description service returned nothing, so
only the written caption survives and whatever was demonstrated on screen is absent here. Most
of those 23 are highlights with little caption text, so the practical loss is small, but a few
are substantive — a redline comparison, a wide formula table, a timetable cost comparison, a
scoring-tool version warning — and their numbers have no second source. On one post the caption
and the description describe different things, so the two don't always agree.
