---
name: skill-memory-architecture
description: Practical craft for deciding what a growing pile of agent chat history and past work should become — a reusable skill, a curated reference an agent searches, or nothing at all — so a personal or team skill library doesn't quietly turn into overlapping, unmaintained clutter. For the person curating skills, memory, and knowledge bases for themselves or a team, not the person implementing the retrieval code.
---

# Deciding what to turn into a skill, and what to leave alone

Distilled from posts by Isaac Flath (@isaac_flath). See TRANSCRIPTS.md, same folder as this file,
for the full source text. See "Where this comes from" below for what this source misses.

## When to use this

Use it when you're deciding how to grow your own (or a client's or team's) collection of agent
skills, memory files, or knowledge bases — should this past conversation become a reusable skill?
Should every chat get auto-summarized into a knowledge base? Is it time to prune? It's one level
above the other two skills in this folder: Agent Evals & Observability and Retrieval & Search
Design are both things you could, in theory, write up as a skill — this is the judgment call about
whether, and how, to do that for *any* piece of agent knowledge.

## Core principles

- **Memory is not one thing — it's a family of retrieval systems, and different content needs
  different rules.** A project wiki, a casual chat with a friend, a social post, and a code
  snippet shouldn't be stored, broken into chunks, or searched the same way. Some need exact-word
  search, some need meaning-based search, some are fine with a simple text match. Each kind also
  needs its own lifecycle rules: what gets saved, what gets updated, what gets deleted, and when it
  should actually be pulled back up. Treating "memory" as one single bucket looks fine at first and
  gets cluttered over time (2026-07-29, "Agent memory is not one thing. It is a family of retrieval
  systems"). The same logic applies to a knowledge base built from mixed sources — library
  documentation that refreshes on every release, a reference paper that goes stale on a completely
  different schedule, and notes auto-extracted from agent logs all need their own update and
  chunking rules, not one shared setting (2026-08-09, "a knowledge base shouldn't be one big
  corpus").
- **Agent history is good raw material for counter-examples — mined on purpose, not
  auto-extracted.** Searching back through past chats and work is useful for two specific things:
  finding the exact details of what you actually did or considered on a past task (people
  remember the final solution and forget the failed attempts along the way), and finding cases
  where you *didn't* follow your own stated rule — which adds the nuance that makes advice useful,
  instead of a rule that sounds clean but doesn't hold up everywhere (2026-08-03, "agent history is
  useful source material because I can search it for details and counter-examples I forgot
  about"). That's different from treating history as something to comb through automatically and
  turn into process.
- **Agent history should not become the source of truth for how you work.** A chat captures
  off-the-cuff, context-specific thinking in the moment. Automatically pulling every workflow out
  of that history to build skills or automations turns temporary decisions and one-off workarounds
  into permanent structure — which then becomes process overhead on every future project. The
  better pattern: use history to surface ideas and patterns, then deliberately decide, for each
  one, whether it's actually good, general enough to reuse, or just something specific to that one
  project (2026-08-04 / 2026-08-05, "Agent history should not become the source of truth for how
  you work").
- **A curated knowledge base has to clearly beat a plain web search, or it isn't curated enough.**
  If an agent's search over your own notes doesn't do meaningfully better than the agent just
  searching the open web, the problem usually isn't the search tool — it's that the knowledge base
  wasn't bounded tightly enough. The point of a personal or team knowledge base is that it reflects
  specific taste and trusted sources — treating every saved markdown file or offhand past opinion
  as equally important defeats that purpose. A deliberately curated set, weighted toward sources
  you already trust for a given topic, is what makes it worth having at all (2026-08-05, "Agent
  Updated Knowledge Base isn't enough").
- **Splitting into more skills to avoid one giant skill eventually creates overlapping
  triggers.** A skill is, underneath, conditional logic — "if this situation, do this" — repeated
  for every situation you've covered. Keep it as one skill and it grows until a wall of conditional
  logic inside a single prompt is too big to manage. Split it into many narrower skills instead,
  and you eventually get multiple skills whose trigger conditions overlap, so the model has to guess
  which one actually applies — and the overall list of conditions the model has to weigh keeps
  growing either way. Once a skill's trigger list gets long, the fix is to add retrieval — searching
  for the right guidance when needed — rather than adding yet another skill (2026-08-06,
  "Extracting every workflow from agent history and using skills for all your personalized
  knowledge creates overlapping trigger rules").
- **An unmaintained skill is worse than no skill.** Splitting work into skills doesn't help if
  nobody keeps them current. Across the most-used public AI agent skills, 29% had only a single
  commit ever and 40% had only two, even on skills with up to 450,000 downloads — a strong signal
  that most of those skills aren't actually being used and refined by the people who published
  them. A skill nobody is updating "probably isn't used by the creator" either, which means it's
  quietly drifting out of date for everyone relying on it (2026-06-28, "30% of the top AI Agent
  skills are not updated after first release").

## Deciding what becomes a skill

Ask these, in order, before turning anything from a past conversation or project into a durable
skill, memory entry, or knowledge-base article:

1. **Is this a repeatable pattern, or a one-off decision made in the moment for that specific
   project?** Only the former is a candidate. A workaround picked under time pressure for one
   client is not automatically good advice for the next one.
2. **Would a person deliberately choose to trust this source, or is it just something that
   happened to get saved?** A curated set beats a pile of unfiltered notes — weigh in favor of
   sources and decisions you'd stand behind, not everything that's ever been written down.
3. **Does this already fit inside an existing skill without making its trigger conditions
   messier?** If yes, add it there. A new skill is only worth creating when it doesn't overlap with
   what's already covered.
4. **If it doesn't fit cleanly into one skill and splitting creates overlap, is this actually a
   retrieval problem instead?** Past a certain number of trigger conditions, searching for the
   right guidance on demand works better than asking the model to hold a longer and longer list of
   "if this, then that" conditions in its head.
5. **Am I willing to keep this updated?** If not, it's better left as searchable history than
   shipped as a skill that will quietly go stale.

## A skill-health check

Run this periodically over any skill library you maintain, your own or a team's:

- **When was it last changed, and does that match how often the underlying work actually
  changes?** A skill with one commit from months ago, covering work that's evolved since, is a
  candidate for either an update or retirement.
- **Does its trigger overlap with another skill's?** If two skills could plausibly fire on the
  same request, that's the overlapping-trigger trap showing up in practice — merge them or narrow
  their triggers.
- **Is anyone actually hitting it?** A skill that never fires isn't pulling its weight; a skill
  that fires constantly but was never revised after first release is a sign the trigger is too
  broad, not that the skill is well-used.
- **Could the content instead be a searchable reference an agent looks up when needed**, rather
  than something baked into a trigger-based skill? If the knowledge is situational rather than a
  repeatable procedure, that's usually the better home for it.

## Where this comes from

These notes are built the same way as the PDF-extraction skill in the root of this folder, from
the same collected source — see that file's "Where this comes from" section for how the posts were
gathered and what the automated visual descriptions get wrong (captions are the creator's own
words and are trustworthy; the "on screen" descriptions are machine-generated summaries and
occasionally misdescribe what's shown — where the two disagree, this skill follows the caption).
The 2026-06-28 post also references a separate analysis by Hamel Husain that Isaac Flath cites but
did not himself produce — the Pareto/commit-count figures are reported as he presented them, not
independently verified here. Nothing here is from this skill's own testing — it's reporting what
Isaac Flath stated in the cited, dated post, findable in TRANSCRIPTS.md.
