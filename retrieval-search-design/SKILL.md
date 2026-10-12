---
name: retrieval-search-design
description: Practical craft for making sure an AI agent finds the right record, page, or passage before it ever has to answer a question about it — choosing between exact-word search, meaning-based search, and a combined approach, diagnosing a "wrong answer" that is actually a "right answer ranked too low" problem, and searching inside charts, maps, and scanned tables. For the person who scopes and configures a search or retrieval setup in a vendor's own interface, not the person who builds the search engine.
---

# Finding the right thing before the agent reads it

Distilled from posts by Isaac Flath (@isaac_flath). See TRANSCRIPTS.md, same folder as this file,
for the full source text. See "Where this comes from" below for what this source misses.

## When to use this

Use it when you're scoping any agent that has to search across documents, tickets, chat history,
a knowledge base, or a product catalog before it can generate an answer — "ask a question across
all our project files," a support bot that needs the current policy, a catalog search. This sits
*upstream* of the PDF-extraction skill in this folder: that skill assumes the right page is
already in front of the agent and asks "did it read it correctly?" This one asks "did the agent
even get handed the right page?" It assumes you configure retrieval settings and write search
instructions inside a vendor's product, not that you build the search index yourself.

## Core principles

- **A lot of what looks like a bad answer is actually a bad search.** Isaac names three symptoms
  people usually blame on the model — the model "made things up," the answer got worse as more
  context piled in, or the task took too long — and traces all three back to the step before
  generation: retrieval. If the agent never found the right information, asking it to write a
  better answer can't fix that (2026-07-09, 2026-07-10, 2026-07-11 — "a lot of generation bugs are
  context-building bugs").
- **Exact-word search and meaning-based search catch different misses.** Exact-word search
  (think Ctrl+F — it matches the words you typed) misses a result when the right idea is written
  with different words than you searched for, e.g. an unusual name for something in a company's
  own files. Meaning-based search (sometimes called semantic search — it compares ideas, not exact
  spelling) catches that case, because it matches on what something *means*, not how it's spelled
  (2026-07-14, "unusual naming conventions can make exact search miss the right code"). The
  trade-off runs the other way for precise technical terms, model numbers, or codes — exact-word
  search is usually the stronger tool there, while meaning-based search tends to win on looser,
  more conversational material (2026-08-09, "retrieval should fit the data too").
- **A right answer ranked low is functionally a wrong answer.** A support agent answered a
  customer with an outdated refund policy. The search had actually found the current policy — it
  was correct and included in the results — but it was ranked seventh, and the system was only
  configured to use the top two results, so the model never saw it. The fix is one of two things:
  return more results (costs you more latency and more tokens), or improve the sorting so the
  right one rises higher — commonly by adding a slower, more careful second-pass sort over the top
  candidates, sometimes called a reranker (2026-08-03, "an agent answered with an old refund
  policy"; 2026-07-13, "when the relevant document is ranked seventh").
- **Combining two kinds of search needs a way to merge two different scoring systems.** Exact-word
  search and meaning-based search score things on completely different scales, so you can't just
  average their numbers together. A simple fix used in practice ignores the raw scores and only
  looks at *rank position* from each list, then combines those — this avoids the apples-to-oranges
  problem of mixing two incompatible scoring scales (2026-07-02, "how to combine different search
  and retrieval types").
- **Multimodal search finds things inside images, charts, and scanned tables — not just typed
  text.** A search system trained specifically on documents (not just general photos) found a
  place name on a topographic map even though the label was abbreviated and crossed by contour
  lines, and found a specific dollar fee buried inside a scanned table, in both cases returning
  the correct page first. This class of tool is built for "it never saw the page," not "it misread
  the page" — pair it with the PDF-extraction skill's reading checks once the right page is found
  (2026-09-28, "new embeddings trained on docs"). The same underlying idea — mapping text and
  images into one shared space that can be searched by meaning — is also what lets someone search
  a product catalog by uploading a photo instead of typing a description (2026-06-29, "how
  multimodal search works").
- **Better search isn't just more accurate, it's also fewer steps.** In a comparison across three
  retrieval setups on the same multi-step task, pairing a coding agent with a stronger search tool
  got both a higher accuracy score *and* dramatically fewer tool calls than a weaker search setup
  paired with a general model — the gap ran from about 17 calls up to over 86 for the weakest
  combination. A better search tool doesn't just help the agent get the right answer, it helps the
  agent get there in fewer, cheaper steps (2026-07-08, "better search tools can improve accuracy
  and reduce tool calls").

## Picking a search type: a quick guide

| Situation | Lean toward | Why |
|---|---|---|
| Precise technical terms, codes, model numbers, unusual internal naming you want matched exactly | Exact-word (keyword) search | Meaning-based search can drift toward the wrong thing when the term is a specific code, not a concept |
| The right words vary — synonyms, abbreviations, paraphrased questions, conversational queries | Meaning-based (semantic) search | Catches the right idea even when the exact words don't match |
| Either alone keeps missing cases the other catches | Combine both, merged by rank position, not raw score | Exact-word and meaning-based scores aren't on the same scale and can't be averaged directly |
| The right result shows up in results but ranked low, and more results would just add noise | Add a reranker (a slower, more careful second-pass sort over your top candidates) | Fixes ordering without flooding the model with extra context |
| The right result shows up ranked low and the extra results are still relevant, just not top-ranked | Return more results from the first pass | Simpler than adding a reranker, at the cost of more tokens and latency |
| The fact lives inside a chart, map, photo, or scanned table, not as typed text | Multimodal / document-trained search | Trained to match meaning across both text and images, not just text |

## A checklist before you blame the model

When an agent's answer is wrong, outdated, or looks invented, work through this before assuming
the model made it up:

1. **Check the trace**: what did the search actually return, and in what order? If you can log
   one thing, log the document ID, its rank, its score, and whether it was actually included in
   what the model saw — that's enough to localize most failures to search versus generation
   (2026-08-03).
2. **Was the right answer in the results at all, just ranked low?** If yes, this is a ranking
   problem — see the table above — not a generation problem.
3. **Was the right answer never in the results?** Check whether the query used different words
   than the source document — this is the classic exact-word-search miss, and it's a sign you need
   meaning-based search, or a reranker won't help because there was nothing to re-rank.
4. **Is the fact sitting inside an image, chart, map, or scanned table rather than typed text?**
   Standard text search returns nothing here by design — this calls for a multimodal or
   document-trained search tool, not a smarter prompt.
5. **Did more context actually make the answer worse?** That's a sign the system is returning too
   many results and drowning the right one in noise — look at reducing and re-ranking before
   increasing the count further.
6. **Did the task simply take a long time?** Check how many retrieval steps and tool calls ran
   before the final answer — a weak search tool often forces an agent into many extra searches to
   find what one good search call would have found directly.

## Where this comes from

These notes are built the same way as the PDF-extraction skill in the root of this folder, from
the same collected source — see that file's "Where this comes from" section for how the posts were
gathered and what the automated visual descriptions get wrong (captions are the creator's own
words and are trustworthy; the "on screen" descriptions are machine-generated summaries and
occasionally misdescribe what's shown — where the two disagree, this skill follows the caption).
Several of the posts above reference a fuller video on an external platform (YouTube) that was not
itself part of the collected source — only the Instagram excerpt and its caption are reflected
here. Nothing here is from this skill's own testing — it's reporting what Isaac Flath demonstrated
or stated in the cited, dated post, findable in TRANSCRIPTS.md.
