---
name: agent-evals-observability
description: Practical craft for telling whether a live AI agent feature is actually working — building a small human-labeled test set, using a score as a gate instead of a target, treating an AI judge as a scaling tool rather than ground truth, and logging what the agent did somewhere you can actually inspect it. For the person who configures and monitors an agent feature in a vendor's own interface, not the person who writes the judging code.
---

# Knowing whether an agent feature is actually working

Distilled from posts by Isaac Flath (@isaac_flath), with two joint posts by Hamel Husain
(@hamelsmu). See TRANSCRIPTS.md, same folder as this file, for the full source text. See "Where
this comes from" below for what this source misses.

## When to use this

Use it once an agent feature is live, or about to go live — a client's chatbot, a document
agent, a drafting assistant, anything that answers, classifies, or writes something a person used
to do by hand. It answers "how do I know if this is good, and how do I know if a change made it
better or worse?" It assumes you work inside a product's own interface or a simple internal tool —
you decide what "good" means, you write down examples, you read the outputs — not that you write
the code that runs a judge or builds a dashboard. Where code is genuinely needed (storing traces in
a database, building an automated judge), that's called out so you know what to ask an engineer for.

## Core principles

- **A score is a gate, not a goal.** Teams build a small reference set — usually 10 to 40
  examples to start — and a metric so they're not scoring against a generic benchmark. Then they
  run experiment after experiment chasing that number up, and stop looking at the actual cases.
  Every metric has a blind spot and can be gamed, on purpose or by accident. After *every* run,
  read the examples and the traces, not just the number — that reading is called error analysis,
  and it's what the score is supposed to prompt, not replace (2026-07-27, "A golden dataset gives
  you a stable place to run experiments").
- **The eval is the human-labeled set, not the AI judge that checks it later.** The actual
  evaluation is a person going through real examples and marking each one right or wrong, with
  notes on why. An "LLM judge" — a model you ask to score outputs the way a person would — is
  instrumentation: it exists to approximate those human labels so you can run checks continuously
  and at scale, after the fact. Building the judge before you have human labels makes no sense,
  because the judge has nothing to approximate yet (2026-07-28, "An LLM judge is not your eval,
  it's instrumentation").
- **Don't pay a vendor for storage you already have.** Eval-vendor products mainly sell three
  things: a place to store traces (what went into the agent and what came out), generic
  AI-scoring features, and an annotation screen. The storage is usually no better than a database
  you already run. The annotation screen is often the weak point — judging whether an answer was
  good almost always requires context the vendor tool can't show: the user's profile, their chat
  history, what they clicked next. The fix is to log traces into your own database (Postgres is
  the example given) so you can join them to the rest of your application data when you build the
  annotation view yourself (2026-07-30, "AI eval vendors give me trace storage I can already
  handle in Postgres").
- **"Got the facts right" and "is good" are different questions.** In a live side-by-side test,
  a model turned a blog post into a short social post. The drafts that read best weren't the ones
  with the most facts crammed in — they had one real, specific number and *one fewer* fact than
  the others. Cutting helped more than adding. The version judged best was picked for being
  clearer, naming a specific score, and mentioning cost — not for completeness (2026-09-15, "An AI
  draft can get the facts right and still not be good").
- **You can't tell if an instruction helped by reading the instruction.** Two people ran the same
  question through a carefully written style guide, a stripped-down version of the same guide,
  and no instruction at all, then compared the actual outputs side by side. The outputs were all
  over the place, and the no-instruction version came out closer to the good ones than either
  person expected. The only way to know if a prompt change helped is to run it and read what comes
  back (2026-09-28, "You can't tell whether a prompt improves writing by reading the prompt").
- **A fast, cheap classifier can scale judging — after the labels exist, not before.** Tools
  built to make quick, structured yes/no or category calls (one example named is "Jev") can run in
  a fraction of a second where a general model takes several seconds, which makes them useful for
  running a judge continuously across lots of traffic. They're a faster engine for the judge you
  already defined with human labels — not a reason to skip defining it (2026-09-17, "I've put Jev
  into my ranking, retrieval, and LLM-as-a-judge workflows").

## The eval-first method

1. **Name the wrong answer that would actually cause damage** — a rude reply to a client, a
   confidently wrong number, a missed deadline detail — before you measure anything. This decides
   what your examples need to cover.
2. **Collect a small set of real examples and have a person write down the right answer for
   each one.** 10–40 examples is a normal starting size. This set, with human judgments attached,
   *is* the eval. Nothing automated comes before it.
3. **Run the current version against that set and score it** — but treat the score as the start
   of the conversation, not the end. Read every example, not just the ones that failed.
4. **Do error analysis after every single run**, not just the first one. Look for a pattern in
   what's wrong, not just a tally of how much is wrong. "Eleven answers dropped the client's name"
   tells you what to fix; "82% passed" doesn't.
5. **Only once you have enough labeled examples to trust, consider an AI judge** to scale those
   same human judgments across more traffic than a person can read. Spot-check the judge against
   fresh human labels regularly — it's an approximation, and approximations drift.
6. **Log every run with enough surrounding context to judge it later**: what the user asked, what
   the agent saw, what it answered, and anything else about that user or session an annotator would
   need. Put this in a database you control so it can be joined to the rest of your product data,
   rather than trusting a vendor's annotation screen to have that context built in.
7. **When you change an instruction, a model, or a setting, judge it by reading fresh outputs
   side by side** — never by reading the new instruction and guessing whether it sounds better.
8. **Re-run your full baseline whenever the scoring method itself changes.** A score from a new
   version of your judge or rubric is not comparable to a score from the old one.

## Reading "facts right but not good" drafts

When an AI-written draft feels off even though nothing in it is wrong, check these before blaming
the model:

- **Is it longer than it needs to be because it's trying to include everything?** Cutting a true
  but unnecessary fact often reads better than adding another one.
- **Does it have at least one specific, real number or detail**, instead of staying general? Drafts
  that named something concrete scored better than ones that didn't.
- **Would you trust it to defend itself?** The best-rated draft in one comparison explicitly stated
  its own score and cost — it didn't just assert quality, it showed its work.

## Where this comes from

These notes are built the same way as the PDF-extraction skill in the root of this folder, from
the same collected source — see that file's "Where this comes from" section for how the posts
were gathered and what the automated visual descriptions get wrong (captions are the creator's own
words and are trustworthy; the "on screen" descriptions are machine-generated summaries and
occasionally misdescribe or mislabel what's shown — where the two disagree, this skill follows the
caption). Two of the posts cited above (2026-09-15, 2026-09-28) are joint posts with Hamel Husain
(@hamelsmu), not Isaac Flath alone. Nothing here is from this skill's own testing — it's reporting
what Isaac Flath (and, on those two posts, Hamel Husain) demonstrated or stated in the cited post,
dated so you can find it in TRANSCRIPTS.md.
