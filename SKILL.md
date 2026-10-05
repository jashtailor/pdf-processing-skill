---
name: pdf-document-processing
description: Practical craft for setting up and testing document-extraction agents on PDFs, scans and forms — building the test set, checking the output, knowing which pages are hard, and reading tool claims. For the person who configures and tests extraction in a product's own interface, not the person who picks text-reading engines or writes code.
---

# Getting information out of documents, reliably

Distilled from 139 posts collected from Isaac Flath (@isaac_flath), mostly June–October 2026.
See "Where this comes from" for what the source misses.

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
- **"Which reader should I use?" has no answer on its own.** What the product needs — whether
  users must click back to the source, whether you need structured records or just text, where
  it has to run, what it can cost, how fast it has to come back — narrows you to a *group* of
  candidates. You compare inside that group. Jump straight to a comparison and you are weighing
  up things that were never interchangeable.
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
- **You cannot tell whether a change to your instructions helped by reading the instructions.**
  Two people ran the same question through a carefully written instruction, a stripped-down
  version of it, and no instruction at all. The answers were all over the place, and no
  instruction at all came much closer than either of them expected. Change one thing, run it
  against the test set, and read the answers.

## The test-first method

1. **Name the wrong answer that would cause real damage** — a wrong signature status on a
   contract, a wrong amount on a loan file. Build the test around it.
2. **Write down what you need**: which fields, in what order, whether users must be able to
   click from an answer back to the page, whether you want an exact copy of what is printed or
   a tidied-up version, and what it has to cost and how fast it has to come back. This list is
   what decides which readers are candidates at all.
3. **Collect 50–100 typical pages** — typical of real intake, not the clean samples. Put the
   hard cases in on purpose: faded signatures, rotated scans, handwriting, drawing sheets.
4. **Have people write the right answers down first**, field by field. That human-labelled
   set *is* the test. An automatic scorer, AI grader included, only copies those judgments so
   they can run at scale — it comes second, never first.
5. **Score exact matches, field by field** — not "did it roughly get it." Split failures into
   misread, missing and invented: "82%" doesn't tell you what to fix, "eleven invented" does.
   Record each failure *on the page*: mark the spot it happened, write what went wrong, and tie
   that note to the answer it came from. A plain list of notes is unsearchable a week later —
   "where was the 9 read as a 3?" — and a marked-up page is not.
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
  *on top of* the text, so ask directly. Handwritten edits are worse again. On a typed page
  where "properly" was crossed out and "promptly" written in above it, three readers failed
  three different ways: one returned both words but never said one of them was deleted, one
  misread the crossed-out word as "propdriy" and flagged nothing, and a feature built
  specifically for tracked changes caught the insertion but dropped the deletion. Not one of
  the three outputs tells you what the page says.
- **Review anything the reader had to guess.** *Catches* invented text. A label cropped to
  `REQUISITION NUMBE` was completed to `NUMBER` — almost certainly the real word, but not
  visible on the page. Another tool fabricated a whole unrelated table. The dangerous version
  is invented text that happens to be *true*: asked to read a pill bottle, two readers returned
  two different copyright lines, one naming Watson Pharmaceuticals and one naming Eisai and
  Ortho-McNeil. Both are real companies with a real connection to that medicine, so both
  survive a plausibility check and a fact check. Only "is this actually printed on the page?"
  catches them.
- **Count the fields you expected.** *Catches* a section skipped silently. One reader rebuilt
  a form grid, stopped at question 33 and dropped seven fields without a word. For a form
  you'll run thousands of times, build the field list from the *blank* copy — that gives you
  the instructions and a free missing-field check at once.
- **Decide whether you want an exact copy or a tidy one, then check for the one you chose.**
  *Catches* a model "correcting" your data. A printed lab value `HCO: 3:21` came back as
  `HCO3: 21`: plausible, tidy, wrong. But a printed "put put" quietly fixed to "output" is only
  a failure if you needed the exact words — for a contract, a signed document or an archive it
  is; for something people read and search, the tidy version is the better answer. Two readers
  on that same page split exactly this way, so this is a decision you state up front, not a
  behaviour you discover. Check exact digits on clean pages either way — one readable balance
  sheet returned 369,488 for 365,848.
- **When an answer is wrong, ask what the agent actually saw.** Many "it made that up" cases
  are "it never saw it" — wrong page, or an old version. If something is missing, crop to
  that spot and retry; page size and resolution are often the real cause.

## Two shapes of reader

Products are built one of two ways, and it changes what they get wrong. Worth asking which one
you are buying.

- **One model reads the whole page.** It sees the picture, the caption and the table at the
  same time, so it can work out that "as you can see, the tallest bar" points at the third row.
  It is the slower and dearer option, it handles messy one-off pages best, and it is the one
  that invents things.
- **A chain of specialists.** The page is cut into pieces — text here, a table there, an
  equation in the corner — and each piece goes to a part built for that kind of thing. Cheaper
  and faster, and you can swap in something better for the one piece that keeps failing. It
  suits forms that arrive in the same layout thousands of times, because the layout is known in
  advance instead of being worked out afresh every page.
- **The chain's blind spot is the page as a whole.** It assumes every piece can be understood
  on its own. When a sentence points at a chart, the part reading the sentence never sees the
  chart, and no amount of accuracy on either piece recovers the link.

## Which pages are hard

Two pages can look identical and need completely different handling: a form with a name typed
into it and a scan of the same form filled in by hand look the same to you, but one has the
text stored inside the file and the other is nothing but a picture. The file format preserves
the page's appearance, not its meaning — even a signature might be typed text, a pasted image
or an actual scanned signature. Check whether a page already has usable text before sending it
anywhere, and route pages by difficulty instead of pushing everything down one path.

| Page type | Difficulty | What typically goes wrong |
|---|---|---|
| Large, clean, flat table | Easy | Size alone isn't difficulty — a clean 33-row table came out whole |
| Any table read as plain text | Medium | The numbers survive, the row-and-column relationships don't |
| Merged or nested table | Hard | Rows attach to the wrong group; a heading repeats onto every row or swallows a value |
| Wide table with formulas | Hard | Plus and minus signs dropped; one misread header collapsed the whole grid |
| Scan with no text stored in the file | Hard | Plain text extraction returns nothing at all |
| Handwriting | Hard | Five readers, three spellings of the same name |
| Checkboxes and signatures | Hard | Ticks missed; faint marks called signed, or unsigned, with no confidence given |
| Charts without printed numbers | Hard | Values are estimated, not read — one gave 28.8% against a published 28.5%; and a sentence pointing at the chart loses its meaning if the two are read apart |
| Diagrams and flowcharts | Hard | Labels read fine, connections dropped or invented |
| Maps and labels inside figures | Hard | Labels mangled; a printed elevation swapped for a nearby number |
| Rotated pages | Hard | Fails until the page is turned upright as a separate first step |
| Drafts, watermarks, redlines | Hard | Vanish silently and change what the document means |
| Handwritten edits over typed text | Very hard | Three readers, three different wrong answers; none of them said which words were deleted |
| Drawings and floor plans | Hard | Repeated symbols undercounted; measurements computed wrong |
| Colour-coded tables | Hard | The colour is the value, and it gets discarded |
| Dense grid forms (census-style) | Very hard | Sections skipped, columns mislabelled, output loops until it gives up |
| Scanned equations | Very hard | Replaced with placeholders, transcribed as garbage, or quietly rewritten — one dropped exponent turned a formula into a different, perfectly readable one |
| Mixed bundles (many documents in one file) | Hard | Must be split first; continuation pages get filed under the wrong type |

## Tool notes — leads to test, never facts

Every result below is a one-to-three-page demo, and the source says so himself. Use them to
have something to suggest when a page type keeps failing, and to set expectations when
scoping — never to rank vendors, never quoted to a client as a measured result.

- **Plain text pulled from the PDF** — keeps the words, loses table structure, watermarks and
  strikethroughs; returns nothing on a scan with no stored text.
- **Table-rebuilding tools (Docling and similar)** — strong on clean tables, fast and cheap;
  seen repeating headings, shifting a value into a header, missing a draft watermark — though
  duplicating a header across every column it spans is also how it corrects a merged column
  heading that plain text or Markdown can only place under one column. Also seen dropping an
  exponent boundary when asked to handle formulas, and mangling the first sentence of a
  degraded scan. It now reads PowerPoint and Apple Keynote decks too, pulling data out of the
  charts in them.
- **Document-specialist readers (Chandra and similar)** — best seen on messy and handwritten
  tables, and read a degraded declassified cable — first sentence and routing grid both — that
  a table-rebuilding tool mangled. On a handwritten crossed-out edit it returned both the
  deleted and the inserted word but never marked which was which, and on another page it
  quietly corrected a printed typo; broke badly on a dense grid form.
- **General image-reading models (Gemini and similar)** — the only reader to get a handwritten
  name and all six checkboxes right on one bank form, and the most expensive tried; also seen
  misreading a digit, tidying a printed value, returning a Markdown table with a merged column
  heading left under only one of the columns it actually spans, and returning a copyright line
  for a pill bottle that is not printed anywhere on it. Writing an instruction around the
  merged-heading problem fixed that one page and did not carry over to others.
- **Colour-aware extraction** — asked for structured records, one general image-reading model
  (Qwen 3 VL and similar) returned a cell's colour alongside its contents and mapped grey to
  the legend's "No guidance / Not applicable", where a table-rebuilding tool returned the same
  cell blank. If colour carries meaning on your pages, ask whether colour comes back as a field.
- **Layout and location tools (Surya and similar)** — give the box on the page so users can
  click through to the source; weaker text, and once invented a table. Its equation block kept
  an exponent that a table-rebuilding tool lost. Worth knowing that these regions need not be
  horizontal rectangles — they can follow angled and warped text, so click-through lands on the
  words instead of a loose box around them.
- **Track-changes features (Datalab and similar)** — built to report what was inserted and what
  was removed, rather than only the final sentence. On a handwritten edit it caught the
  insertion and dropped the deletion; the vendor's own examples are digital revisions, so
  handwriting may be outside what it is meant for.
- **Document-trained search (Ovis-VL-Embedding and similar)** — for finding the right page
  rather than reading it, trained on document questions, text inside images and infographics.
  It brought back the right page first for a place name that was abbreviated and crossed by
  contour lines on a map, and for a fee buried in a scanned table. Relevant when the complaint
  is "it never saw the page", not "it misread the page".
- **Cloud services (Textract and similar)** — handled a big clean table well; dropped plus and
  minus signs from formulas; weak on faint signatures.
- **Cheap classical tools (PaddleOCR and similar)** — matched an image-reading model on one
  timetable, faster and cheaper; its rotation detector fixed a sideways page nothing else read.
  It left a printed typo exactly as printed where others silently fixed it, which is the right
  behaviour or the wrong one depending on what you decided you wanted; it misread struck-through
  handwriting badly.
- **Form-field and bundle-splitting tools** — turn a flat form into fillable fields, or split
  one file into separate documents. Good scoping ideas for construction and intake paperwork.
- **Agent-driven readers** are arriving, billed as accurate on genuinely hard pages, slowly and
  expensively. Worth testing on your worst pages only.
- **To pass to an engineer, not act on:** at least one widely used Python PDF library carries a
  licence that would require a commercial project to publish its own source code.

## Where this comes from

139 items collected from one Instagram account: 120 reels, 16 story highlights, 3 stories. Two
of the 139 were posted by a collaborator (Hamel Husain, @hamelsmu) rather than by Isaac Flath,
and several of the newest are two-person conversations, so this is not quite one person's
account. Nobody watched the videos — every claim rests on a caption plus an automated
description of what was on screen, and those descriptions state that exact slide text, table
cells and chart values were not captured. **25 of the 139 are caption-only**: the description
service returned nothing, so only the written caption survives and whatever was demonstrated on
screen is absent here. Most of those 25 are highlights with little caption text, so the
practical loss is small, but a few are substantive — a redline comparison, a wide formula table,
a timetable cost comparison, a scoring-tool version warning — and their numbers have no second
source. One of the newest items is a story with no caption and no description at all, so
nothing of it survives.

The descriptions themselves make mistakes worth knowing about. On one post the caption and the
description describe different things. On another, the description calls Chandra "a human
annotator named Chandra" when it is a piece of software, and only the caption makes that clear.
Where a caption and a description disagree, trust the caption.
