---
name: pdf-document-processing
description: Practical craft for setting up and testing document-extraction agents on PDFs, scans and forms — building the test set, checking the output, knowing which pages are hard, and reading tool claims. For the person who configures and tests extraction in a product's own interface, not the person who picks text-reading engines or writes code.
---

# Getting information out of documents, reliably

Distilled from 154 posts collected from Isaac Flath (@isaac_flath), mostly June–October 2026.
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
  either is right — only a person's labelled answer is. Agreement is still worth recording,
  because *dis*agreement is a cheap way to pick the pages a person must check: one team builds
  its labels by running eight readers over the same table, keeping the answers that agree and
  sending the rest to a person. They say themselves that models can still all agree on the
  same wrong answer.
- **A leaderboard position is not information until you know what is in the benchmark.** Top
  of the table tells you nothing on its own — ask which pages were scored, and look at the
  examples. Real intake does not look like benchmark data: the requests Isaac gets are tables,
  scans, charts, and detailed blueprints with parts lists to pull off them, while public
  benchmarks lean towards simpler text pages. He flags a selection effect — people bring him
  their hardest pages — but the direction of the gap is the point.
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
- **Ask which model is reading the image inside the product.** The same tool can pass or fail
  on the same page depending on what is plugged into it. One table-rebuilding tool, left on
  its small default image model, misread every label and duration on a chart; the same tool
  with a larger image model read all six values correctly. Before you write a tool off, find
  out whether that part is a setting you can change.
- **You cannot tell whether a change to your instructions helped by reading the instructions.**
  Two people ran the same question through a carefully written instruction, a stripped-down
  version of it, and no instruction at all. The answers were all over the place, and no
  instruction at all came much closer than either of them expected. Change one thing, run it
  against the test set, and read the answers.

## Setting the output shape, inside the vendor UI

"Ask for structured records" and "ask for HTML instead of plain text" are not code you write —
they're a setting or an instruction you choose inside the product you already use.

- **Look for a format or output-type setting first.** Most extraction tools have a dropdown,
  toggle, or schema field somewhere in the agent or workflow configuration — words like "output
  format," "response type," "schema," or "structured output." Picking "JSON" or "structured"
  instead of "plain text" or "markdown" is usually the entire change.
- **No dropdown? Say it in the instructions box.** If the tool only takes a written prompt, you
  can ask for the shape in plain words in the same box where you describe what to extract: "return
  one record per row, with fields named X, Y, Z" or "return the table as HTML, not plain text."
- **"HTML instead of plain text" exists to fix one specific thing: a heading that spans more
  than one column.** Plain text and plain Markdown tables can only put a heading over a single
  column. HTML can say "this heading covers four columns," which is why it survives a
  merged-heading table that plain text flattens into a misaligned row.
- **A new output shape is still a change — test it like one.** Run it through your test set
  before you trust that "structured" fixed anything; don't just take the setting's word for it.

## The test-first method

1. **Name the wrong answer that would cause real damage** — a wrong signature status on a
   contract, a wrong amount on a loan file. Build the test around it.
2. **Write down what you need**: which fields, in what order, whether users must be able to
   click from an answer back to the page, whether you want an exact copy of what is printed or
   a tidied-up version, and what it has to cost and how fast it has to come back. This list is
   what decides which readers are candidates at all.
3. **Collect 50–100 typical pages** — typical of real intake, not the clean samples. Put the
   hard cases in on purpose: faded signatures, rotated scans, handwriting, drawing sheets.
   Treat that count as a start, not a finish: variety matters more than volume, and the set
   keeps growing as new document types arrive. Isaac spent over two months labelling daily and
   still did not have enough different kinds of page.
   - **Week one:** pull together your first 50–100 pages — enough of each page type you actually
     receive, plus a handful of the hard cases above — and run the whole method once, end to
     end, to get a real answer on the failure named in step 1. Don't wait for a bigger or
     cleaner set before starting; a small real test beats a long delay building a perfect one.
   - **After that, growing the set means adding, not re-collecting.** Add a few pages whenever a
     new document type, vendor, or edge case shows up in real use. It's an ongoing habit attached
     to normal work, not a second scheduled collection effort — the set is never really finished.
4. **Have people write the right answers down first**, field by field. That human-labelled
   set *is* the test. An automatic scorer, AI grader included, only copies those judgments so
   they can run at scale — it comes second, never first. This is skilled, slow work, not a job
   to hand to whoever is free — reading a bad page well is itself a skill, and most teams never
   build a set of their own. When a page is too degraded for a person to read with confidence,
   settle the answer from outside the page — look the product or the form up — rather than taking
   any reader's version of it.
5. **Score exact matches, field by field** — not "did it roughly get it." Split failures into
   misread, missing and invented: "82%" doesn't tell you what to fix, "eleven invented" does.
   Record each failure *on the page*: mark the spot it happened, write what went wrong, and tie
   that note to the answer it came from. A plain list of notes is unsearchable a week later —
   "where was the 9 read as a 3?" — and a marked-up page is not.
6. **Compare accuracy, cost and speed together** — and record them per page and per reader,
   not just as one average. That per-page gap is what tells you which pages actually need the
   expensive reader, and it is usually smaller than expected. Put it as a question anyone can
   answer: is five more points of accuracy worth three more seconds on this page? Send
   licensing and hosting questions to an engineer before anything ships.
7. **Decide where failures go** — re-read the page, send only the failed fields to a
   different reader, or route the document to a person. Readers disagreeing with each other is
   a good trigger for that last route, even when you cannot say which one is wrong. When several
   readers disagree, try an automated repair pass and re-check agreement before sending to a
   person — but still send it if agreement stays low.
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
  correctly still came out measured wrong. Check ranges for the impossible while you are there:
  a dropped leading digit turned a tax bracket into "over $197,300 but not over $50,525",
  which no income can satisfy, and the tool reported it without complaint.
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
- **Treat a flag as "look here", not "this is wrong".** *Catches* time spent fixing the wrong
  thing. A tool that marks risky spots is doing the job of a radiologist circling an area on a
  scan: pointing, not diagnosing. In one case the highlight landed on the right spot and the
  reason given for it was wrong, and the label never said which words to change. Useful for
  deciding where a person looks; not a substitute for the person.
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
- **Check whether the output looped or got cut off.** *Catches* a page silently thrown away,
  and a block of invented repeats. Readers built on image models are prone to repeating
  themselves: they are run at a low randomness setting because that transcribes more
  accurately, and the price is that they can get stuck copying a block they already wrote. This
  is a tradeoff, not a bug to simply disable — the same low-randomness setting that makes OCR
  accurate is what makes it prone to getting stuck, so ask an engineer to tune it, not turn it
  off. The
  repeats are not always obvious — one case repeated a whole table section at a time, another
  counted up as it went (S10, S11, S12), and both slipped past the product's own loop
  detector. The usual safety net is a cap on output length, and the cap is where your pages go
  missing: across 40,000 pages, 219 ran past the cap — 204 were genuine loops and 15 were real
  pages that were simply long. Those 15 are the ones you care about: dense tables, agreements
  with many signatures. So when a page comes back repeating or stopping mid-table, ask whether
  it looped or whether it was cut off, and check that long legitimate pages are not being
  binned as failures. The settings behind this are an engineer's to change.
- **Decide whether you want an exact copy or a tidy one, then check for the one you chose.**
  *Catches* a model "correcting" your data. A printed lab value `HCO: 3:21` came back as
  `HCO3: 21`: plausible, tidy, wrong. But a printed "put put" quietly fixed to "output" is only
  a failure if you needed the exact words — for a contract, a signed document or an archive it
  is; for something people read and search, the tidy version is the better answer. Two readers
  on that same page split exactly this way, so this is a decision you state up front, not a
  behaviour you discover. Check exact digits on clean pages either way — one readable balance
  sheet returned 369,488 for 365,848. The same decision settles smaller things: two printed
  lines on a medicine label, an NDC number and "Rx only", came back merged into one line.
  Whether that is a defect depends on who uses the output and what for — so answer that before
  you log it as one.
- **When an answer is wrong, ask what the agent actually saw.** Many "it made that up" cases
  are "it never saw it" — wrong page, or an old version. If something is missing, crop to
  that spot and retry; page size and resolution are often the real cause.

**Before you trust a new document type, run this list once:**

1. Checked labels together with their values, not just that the text appears on the page?
2. Had code — not the model — redo any totals or ranges that must add up or stay in bounds?
3. Confirmed the model's convention for "blank," and checked every response against it?
4. Written the rule for faint signatures and checkboxes before looking at any results?
5. Asked about document status — draft, watermark, struck-out edit — as its own question?
6. Reviewed everything the reader had to guess, not only the parts that looked wrong?
7. Counted the fields you expected, using the blank form as the checklist?
8. Checked for loops and cutoffs, and confirmed long legitimate pages weren't binned as failures?
9. Decided, in advance, exact copy or tidied-up version — and checked for the one you chose?
10. For anything wrong, checked what the agent actually saw before assuming it invented the answer?

Can't answer one yet? That's the next thing to test, not a reason to skip ahead.

## Two shapes of reader

Products are built one of two ways, and it changes what they get wrong. Worth asking which one
you are buying.

**What you need narrows you to a group — use this to pick a starting point:**

- Need to click through from an answer back to the exact spot on the page → layout and location tools.
- Need to pull one passage out of a large file, not read the whole thing → local-index readers.
- One-off page, messy or varied, and you just need it read once → a single whole-page model.
- The same layout, over and over, at volume → a chain of specialists.
- Colour on the page carries meaning (a grey cell, a highlighted row) → colour-aware extraction.

- **One model reads the whole page.** It sees the picture, the caption and the table at the
  same time, so it can work out that "as you can see, the tallest bar" points at the third row.
  It is the slower and dearer option, it handles messy one-off pages best, and it is the one
  that invents things.
- **A chain of specialists.** The page is cut into pieces — text here, a table there, an
  equation in the corner — and each piece goes to a part built for that kind of thing. Cheaper
  and faster, and you can swap in something better for the one piece that keeps failing. It
  suits forms that arrive in the same layout thousands of times, because the layout is known in
  advance instead of being worked out afresh every page. The piece that cuts the page up
  usually also decides what order the pieces are read in, and both of those can go wrong
  before a single word is read.
- **The chain's blind spot is the page as a whole.** It assumes every piece can be understood
  on its own. When a sentence points at a chart, the part reading the sentence never sees the
  chart, and no amount of accuracy on either piece recovers the link.

## Which pages are hard

Two pages can look identical and need completely different handling: a form with a name typed
into it and a scan of the same form filled in by hand look the same to you, but one has the
text stored inside the file and the other is nothing but a picture. The file format preserves
the page's appearance, not its meaning — even a signature might be typed text, a pasted image
or an actual scanned signature. Check whether a page already has usable text before sending it
anywhere, and route pages by difficulty instead of pushing everything down one path. Text you
can select is not a clean bill of health either — it may itself be the output of a scan that
was read once already, and it tells you nothing about whether the page will come back in a
sensible order.

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
| Multi-column pages (papers, newspapers) | Hard | Read in the wrong order — abstract after the introduction, one interview spliced into the next — while every word is correct |
| Charts with printed labels and values | Medium | Readable, but only by a strong enough image model — a small default one relabelled a bar "Crash" and turned 0.2 seconds into -1.5 |
| Curved, warped or angled text (photos of objects, tilted cards) | Hard | A straight rectangle round slanted text swallows its neighbours — part of the title lands in the paragraph |
| Very long or very dense pages | Hard | Output runs past a length cap and the page is discarded as a failure — big tables and many-signature agreements are the usual casualties |
| Drawings and floor plans | Hard | Repeated symbols undercounted; measurements computed wrong; parts lists off electrical and construction blueprints are a common real request and barely appear in public benchmarks |
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
  charts in them. A newer version uses the section lines printed on a page to work out reading
  order, and on two tests it fixed it: the abstract read before the introduction on a research
  paper, and a newspaper's interview columns finished before the portraits underneath. It read a
  tax worksheet's income limit correctly where a cheap classical reader dropped a digit. Left on
  its small default image model it misread an entire chart, labels and durations both, and the
  same chart read with a larger image model plugged in came back with every value right — the
  clearest example here that the tool and the model inside it are different questions.
- **Local-index readers (MinerU and similar)** — parses a PDF once and builds a local keyword
  index, giving each passage an address (document, page, block) an agent can use later to fetch
  just that passage instead of reloading the whole document into every prompt — tested by
  retrieving one payment clause out of a 23-page financing agreement. On a table comparing two
  similarly-named models, it merged both model names into one cell spanning both rows while
  keeping their error rates in separate rows — importing those rows as written would attach the
  same combined name to both results. The same table read with a table-rebuilding tool (Docling)
  kept the two names apart. Treat a MinerU table with similar-looking row labels as a candidate
  for the label-with-its-value check above.
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
  words instead of a loose box around them. Newer ones (PP-DocLayoutV3 and similar) also
  predict the order the regions should be read in. The shape matters because of field
  extraction: a loose rectangle that swallows part of the title corrupts a single-field pull
  off an intake form, birth certificate or licence.
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
  handwriting badly. On a printed tax worksheet it dropped the leading digit of $250,525 and
  returned $50,525, producing a bracket no income can fall in.
- **Form-field and bundle-splitting tools** — turn a flat form into fillable fields, or split
  one file into separate documents. Good scoping ideas for construction and intake paperwork.
- **Routers that decide when to spend the expensive reader** (Reducto and similar) — run the
  fast and the slow reader side by side during evaluation, measure the score gain and the extra
  seconds on each page, and predict from that whether the big one is worth calling. A simple
  version: record each page's confidence score and word count, run both the cheap and the
  expensive reader, and use those two numbers to predict whether the accuracy gain is worth the
  extra time — before building anything fancier. The point for you is the measurement, not the
  machinery. The tool pair used to illustrate it was the source's own example, not the vendor's.
- **Agent-driven readers** are arriving, billed as accurate on genuinely hard pages, slowly and
  expensively. Worth testing on your worst pages only.
- **To pass to an engineer, not act on:** at least one widely used Python PDF library carries a
  licence that would require a commercial project to publish its own source code. The randomness
  setting and the output length cap that decide whether a page loops or gets truncated are also
  theirs to change, not yours.

## Where this comes from

154 items collected from one Instagram account: 134 reels, 16 story highlights, 4 stories. Two
of the 154 were posted by a collaborator (Hamel Husain, @hamelsmu) rather than by Isaac Flath,
and many of the newest are two- and three-person conversations with Hamel Husain and a co-host,
Alexis, so this is not quite one person's account. Nobody watched the videos — every claim
rests on a caption plus an automated description of what was on screen, and those descriptions
state that exact slide text, table cells and chart values were not captured. **26 of the 154
are caption-only**: the description service returned nothing, so only the written caption
survives and whatever was demonstrated on screen is absent here. Most of those 26 are
highlights with little caption text, so the practical loss is small, but a few are substantive —
a redline comparison, a wide formula table, a timetable cost comparison, a scoring-tool version
warning — and their numbers have no second source. Two of the newest items are stories with no
caption and no description at all, so nothing of them survives.

The descriptions themselves make mistakes worth knowing about. On one post the caption and the
description describe different things. On another, the description calls Chandra "a human
annotator named Chandra" when it is a piece of software, and only the caption makes that clear.
Where a caption and a description disagree, trust the caption.

## OCR models on the market (October 2026) — unverified reference

**Read this before the list below.** Everything from "Core principles" through "Tool notes"
above ties back to a specific test in Isaac's posts. Nothing in this section does — it's a
plain map of names and categories that exist on the market, written from general knowledge of
the field, not from a test in the source material. Where a name below also has a real test
behind it, that test lives in "Tool notes" or "Which pages are hard" above, and this section
says so and points you there. Every other name here is **not tested here — unverified**: a name
worth knowing, not a recommendation to act on. Before relying on any of them, run it through
"The test-first method" above, exactly as you would a tool nobody had ever mentioned to you.

**1. Document-specialist models.** Built only to read pages. Names on the market: Mistral OCR,
PaddleOCR-VL, GLM-OCR, DeepSeek-OCR, olmOCR, MinerU, Nanonets OCR, FireRed-OCR.
- MinerU is tested in "Tool notes" above, including a table of two similarly-named models where
  it merged both names into one cell while keeping their numbers separate — a real failure.
- PaddleOCR-VL is tested once, in the post referenced under "Layout and location tools" in Tool
  notes: compared against Datalab Accurate on whether a bounding region can follow angled,
  warped text. That's a test of region shape, not reading accuracy — and it's a different
  product from classic PaddleOCR, tested far more under "Cheap classical tools" in Tool notes.
- olmOCR appears once in the source, named only as an example of why low-temperature settings
  cause repetition loops — not as a tested reader.
- Mistral OCR, GLM-OCR, DeepSeek-OCR, Nanonets OCR, and FireRed-OCR do not appear in the source
  at all — not tested here — unverified.

**2. General vision models.** Built for everything, including reading pages. Names on the
market: GPT-5, Claude Sonnet, Gemini 3 Pro and Flash. Gemini (the Flash variant) is the most
heavily tested reader in this whole document — see "Which pages are hard" and "Tool notes" for
specifics, both its best result (a handwritten name and all six checkboxes right on one bank
form) and its failures (an invented copyright line, a "corrected" lab value). GPT-5 and Claude
Sonnet do not appear in the source at all — not tested here — unverified. Qwen, an open-weight
model not named in the original market list above but worth knowing, is the other most heavily
tested model in this document — see the checkbox, map-label, and census-form entries elsewhere.
InternVL does not appear in the source at all — not tested here — unverified.

**3. Classic OCR services.** Older enterprise tools. Names on the market: Azure Document
Intelligence, AWS Textract, Google Document AI, Tesseract, EasyOCR. AWS Textract is tested in
"Tool notes": strong on a big clean table, found only 3 of 4 faint signatures, dropped plus and
minus signs from formulas. Tesseract is tested once, wrapped inside a tool called PDF-MCP: on a
private 22-question benchmark, giving an agent direct CLI access scored slightly higher and ran
faster than going through the wrapper — a test of that wrapper, not a ranking of Tesseract
against other readers. Azure Document Intelligence, Google Document AI, and EasyOCR do not
appear in the source at all — not tested here — unverified.

**What this section is not.** It is not a routing table, and nothing here should be read as
"start with this one" — that's the exact shortcut the rest of this skill tells you not to take.
If you need a starting point grounded in an actual test, use "Tool notes" above. If none of
those fit your page type, treat the unverified names here as leads: write down what the product
needs (test-first method, step 2), narrow to a small group of candidates, and test your own
pages before anything — including this document — tells you which one wins. Public benchmarks
for this market are close to saturated at the top, so a small score gap between vendors means
little on its own — see "A leaderboard position is not information" in Core principles.

> **Note for whoever runs the weekly sync — not the reader.** This section is dated October 2026
> and was written from general market knowledge, not from a test in Isaac's posts. If the sync
> finds Isaac testing one of the "not tested here" names above, move that result into "Tool
> notes" with the test attached, rather than updating the claim here. Otherwise this section only
> needs attention when the list of names on the market goes stale.

## Post transcripts

Every collected post is transcribed in full in TRANSCRIPTS.md, in the same folder
as this file: caption plus the automated visual description, oldest first. The
weekly sync appends new posts there. 26 posts have captions only — the description
service returned nothing, so what was on screen is lost. Two stories have neither
caption nor description. Where caption and description disagree, trust the caption.
