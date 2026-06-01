---
name: competency-assessment
description: Evidence-based engineering competency matrix assessment against Persona's 2026 SWE I/II/III/MTS rubric. Use when evaluating an engineer's level against the 9-dimension matrix, building a promotion case, or identifying stall signals. Commands - /competency-assessment <person>, /competency-assessment <person> <competency>.
author: Cong Chen
---

# Competency Matrix Assessment

Structured, evidence-based assessment of an engineer against Persona's 2026 9-dimension competency
matrix. Designed to resist **all three** failure modes: hand-wavy praise (false-positive
promotion), GitHub-centric under-leveling (false-negative for cross-functional roles), and
AI-shipping-volume confusion (rating someone "high output" without checking whether they review
what AI produces).

## Core principles

**1. Evidence over impression.** Every rating claim must be backed by a verifiable artifact: a
commit SHA, a PR number, a Notion doc ID, a Slack message link, a customer-facing doc, an authored
skill/CLAUDE.md section, or a direct API count. If you catch yourself asserting "she doesn't do X"
or "she's strong at Y," verify with a query before writing it down. The worst failure mode of this
skill is confident unverified claims.

**2. Tenure-adjusted, not absolute.** Tenure sets the trajectory expectation. A 3+ year tenured
engineer rated at their hire-in level with no movement is *plateaued*. A 2-month engineer rated at
that same level is *on ramp*. Always state tenure and trajectory.

**3. Track-adjusted, not universal.** A backend-platform SWE, a frontend SWE, an FDE, and an
ML eng have fundamentally different evidence profiles. Ask the track upfront and use the matching
evidence playbook. A GitHub-heavy methodology applied to an FDE will systematically under-level
them.

**4. Calibrate against the right bracket.** Do NOT default-quote SWE II↔III. Quote L-1 / L / L+1
based on tenure and prior level. For a 4+ year senior engineer, quote SWE III and MOTS — not
SWE II. The rubric bracket you anchor to is the bracket you'll rate in.

**5. Competency by competency.** Do not batch all 9 into one take. Go one at a time, let the
user challenge each rating, revise with evidence. The one-by-one rhythm catches the reviewer's
own biases better than a bulk summary.

**6. The rubric is the source of truth.** [`MATRIX.md`](MATRIX.md) defines the 2026 levels. Quote
the relevant-bracket language verbatim at the top of each competency section — not a remembered
approximation. If the user mentions a newer matrix version, prefer it and resync MATRIX.md.

**7. AI shipping ≠ AI fluency.** A high commit count from someone who clearly committed
unreviewed AI output is *negative* signal on AI Fluency. Volume tells you nothing; review depth,
shared infra contributions (CLAUDE.md, skills, agent harnesses), and ability to explain committed
code tell you everything.

**8. All failure modes are real.** False-positive promotion (over-rating a strong shipper without
the design/teaching bar), false-negative under-leveling (missing MOTS work because it lives
outside GitHub), and AI-volume confusion are equally costly. Red-team for all three.

## The matrix

**Source of truth: [`MATRIX.md`](MATRIX.md)** in this skill folder. It contains the full
SWE I → MOTS rubric for all 9 competencies, structured for easy verbatim quoting. **Always read
MATRIX.md at the start of an assessment** and quote from it directly — do not paraphrase from
memory.

If MATRIX.md is missing or stale, the latest source is the
"Engineering Levels Matrix - Proposal 2026 - Engineering" PDF.

The 9 competencies (grouped by theme):

**Technical Mastery**
1. **Code Architecture** — designing abstractions, integration lifecycle
2. **Tooling & AI** — team-level process and tooling improvements + AI fluency (NEW dimension)
3. **Execution** — scoping, de-risking, delivery through roadblocks (now includes cross-team work
   at every level, not just MOTS)

**Product Oriented Mindset**
4. **Product Experience** — shaping product direction, PM partnership
5. **Business Alignment** — reconciling business goals with engineering tradeoffs

**Operational Excellence**
6. **Observability/Productionization** — building for production stability
7. **Debugging** — stack-wide fluency, pattern-level debugging

**Teamwork**
8. **Leadership** — mentorship, teaching, technical advocacy
9. **Collaboration** — teamwork via reviews, design docs, pairing (cross-team contribution
   evidence is now scored under **Execution**, not here)

Levels: SWE I → SWE II → SWE III → Member of Technical Staff (MOTS).

## Which rubric bracket to quote

Anchor to a 3-level bracket (L-1 / L / L+1) based on tenure and current level. Do NOT default to
SWE II↔III.

| Tenure + current level | Quote these levels verbatim |
|---|---|
| <6 months, SWE I | SWE I, SWE II |
| ~1–2 years, SWE II | SWE I, SWE II, SWE III |
| ~2–4 years, SWE II | SWE II, SWE III (plateau watch) |
| ~2–4 years, SWE III | SWE II, SWE III, MOTS |
| ~4+ years, SWE III | SWE III, MOTS |
| ~4+ years, SWE II | SWE II, SWE III (serious plateau watch) |
| MOTS | SWE III, MOTS |

Per-competency exception: if evidence for *one competency* sits above the default bracket (e.g.,
a SWE II doing framework-level product shaping, or a SWE II shipping team-wide AI infra), quote
the extra level for that competency only. Don't clip the ceiling.

## Workflow

### Phase 1 — Setup, identity, and track

1. **Confirm the target engineer**: full name, team, tenure start date, current level.
2. **Declare the track** (ask if unclear). Tracks weight evidence sources differently:
   - **Backend/platform IC** — weight GitHub commits/reviews, design docs, postmortems, AI infra
     authorship in repo (CLAUDE.md, skills, slash commands)
   - **FDE (customer-facing)** — weight customer channels, launch channels, team Notion spaces
     (e.g. go/fde), cross-team product proposals, customer-facing docs, customer-facing AI demos
   - **Frontend IC** — weight GitHub + design-system work + PR review substance + Storybook/AI
     prototyping
   - **ML/infra IC** — weight experiment docs, model-shipping evidence, on-call/incident
     follow-through, eval framework + AI agent infra contributions
3. **Define the assessment window**: default to last 12 months.
4. **Find their identifiers**:
   - Git author email (usually `first@withpersona.com` or `first.last@withpersona.com`)
   - GitHub login — derive from a recent commit:
     `gh api repos/persona-id/persona-web/commits/<SHA> --jq '.author.login'`
   - Slack user ID — `mcp__plugin_slack_slack__slack_search_users` by name or email
   - Notion user — search for docs they authored
5. **State tenure**: "N years at Persona" matters for every rating. Note it at the top.

### Phase 1.5 — Calibration hypothesis

If the user volunteers a prior ("I think this person is at low MOTS" / "solid SWE II" /
"promotion-ready"), capture it as the **working hypothesis** — the level to test against
evidence, not a bias to override. Your job is to verify, falsify, or refine it. If evidence
contradicts the prior, say so and show the evidence. If evidence supports it, say so and show the
evidence.

If the user has no prior, note that and rate cold.

This is NOT "defer to the manager." It's: the manager has context you don't, and skipping their
prior makes you waste searches on brackets the evidence won't support.

### Phase 2 — Gather evidence (track-specific)

Run the base sweep, the AI-fluency sweep, then the track-specific sweep. Parallelize.

#### Base sweep (all tracks)

**GitHub — commit volume and shape**
```bash
cd /path/to/repo && git log --author="<email>" --since="<date>" --format="%H %s" | wc -l
cd /path/to/repo && git log --author="<email>" --since="<date>" --format="%s" | head -100
```
Look for: total commit count, reverts, version churn (V2→V4 patterns), "first attempt" language,
state-specific patches months after initial ship.

**Notion — authored docs**
Search by Notion user ID + window. Categorize: finalized shared design docs / WIP decoration /
rollplans / teaching artifacts (runbooks, onboarding, brown-bag notes).

**Slack — discussion and advocacy footprint**
Search for messages across team channels AND cross-team channels. Look for: technical advocacy
memos, cross-team help, design review comments, postmortem contributions.

**Linear/Jira — ticket assignments**
Scope of work (narrow vs. broad). Proactive ticket creation vs. purely assigned.

**Postmortems (INC-####)**
Contributing factor? Authored? Follow-up tooling changes?

#### AI Fluency sweep (all tracks — NEW)

The 2026 matrix makes AI Fluency a co-equal sub-indicator with Tooling Knowledge. You MUST run
this sweep for every assessment.

**Repo AI infrastructure — who authored shared AI tooling?**
```bash
# Skills
cd /path/to/repo && git log --since="<date>" --diff-filter=A --format="%H %an %ae %s" \
  -- '.claude/skills/**' | grep -i "<email or name>"

# CLAUDE.md / AGENTS.md sections
cd /path/to/repo && git log --since="<date>" --author="<email>" --format="%H %s" \
  -- 'CLAUDE.md' '**/CLAUDE.md' 'AGENTS.md' '**/AGENTS.md'

# Slash commands, hooks, MCP integrations
cd /path/to/repo && git log --since="<date>" --author="<email>" --format="%H %s" \
  -- '.claude/commands/**' '.claude/hooks/**' '.claude/agents/**' '.cursor/**'

# Authored skills (count distinct skill folders touched)
cd /path/to/repo && git log --since="<date>" --author="<email>" --name-only --format= \
  -- '.claude/skills/**/SKILL.md' | sort -u
```
Distinguish:
- **Authored** a skill / CLAUDE.md section (large initial commit) — SWE III/MOTS-flavor
- **Edited** an existing skill substantively — SWE II/III-flavor
- **Trivial touch** (typo fix, single-line update) — does NOT count

**AI-generated PR signals (positive AND negative)**
```bash
# Co-author trailer indicating AI assistance
cd /path/to/repo && git log --author="<email>" --since="<date>" --format="%H %s%n%b" \
  | grep -B 2 -i "Co-Authored-By: Claude\|Co-Authored-By: Cursor\|Generated with .Claude"

# Branches named claude/* or cursor/* (auto-named agent branches)
git branch -a --list 'origin/claude/*' 'origin/cursor/*'
```
Reading PR descriptions for these branches: do they explain *why*, or do they paraphrase the
diff? Paraphrasing-the-diff in PR descriptions is a "blind acceptance" signal.

**Anti-signals — bug shape that suggests un-reviewed AI output**
- Reverts on AI-attributed branches without a postmortem
- Bugs that read like AI hallucinations (calls to non-existent methods, made-up library APIs,
  wrong-version syntax)
- Defensive over-engineering (try/catch swallowing every error, validation on internal calls,
  unnecessary fallbacks) that doesn't match repo conventions

**Slack — AI advocacy and teaching**
Search `#claude-code`, `#ai-eng`, `#engineering-ai`, `#cursor`, AI-tooling channels for the
target's footprint. Look for: prompts shared, demos posted, evaluations of new AI features,
cross-team enablement.

**Notion — AI playbooks and prototypes**
Search for AI-related authored docs: PRDs written in planning mode, evaluation memos for new AI
tools, prototype demos that informed product decisions.

**Agent automations (MOTS-flavor)**
- Repo-level GitHub Actions or scheduled jobs that run an agent end-to-end (auto-PRs,
  auto-triage, auto-benchmark)
- Multi-step agent harnesses (subagent definitions in `.claude/agents/`)
- "Zones" — bounded areas with explicit AI-safe contributing guidelines

**Reporting:** "Skills authored: N. CLAUDE.md major sections authored: M. Agent automations
shipped: K. Cross-team AI advocacy posts: J." Do not claim "uses AI well" without artifacts.

#### Backend/platform IC — additional

**Outbound code reviews (weight: high for this track)**

Most important signal for backend-platform ICs. The hardest to measure correctly in a
high-volume private org. **Do NOT rely on GraphQL `contributionsCollection` or
`gh search --reviewed-by`** — both under-report private org reviews to zero.

*Tier 1 — Events API (recent snapshot)*
```bash
gh api "users/<handle>/events" --paginate \
  --jq '[.[] | select(.type == "PullRequestReviewEvent")] | length'
gh api "users/<handle>/events?per_page=100" --jq 'length, (.[-1].created_at)'
```
Returns ~90 days or 300 events, whichever is smaller. Note the oldest event timestamp.

**Validate against a known-active reviewer first.** If the control returns 0, your token lacks
scope — the whole GitHub-review methodology is compromised; escalate before using it.

*Tier 2 — Targeted teammate PR sampling (full window)*
Random persona-web sampling is useless (100+ PRs/week). Sample PRs authored by the target's
5–10 closest collaborators.
```bash
for teammate_email in "$TEAMMATE1" "$TEAMMATE2" ...; do
  cd /path/to/repo && git log --author="$teammate_email" --since="<date>" \
    --format="%s" --merges | grep -oE "#[0-9]+" >> /tmp/teammate_prs.txt
done
sort -u /tmp/teammate_prs.txt > /tmp/teammate_prs_unique.txt

while read pr_raw; do
  pr=${pr_raw#\#}
  reviews=$(gh api "repos/persona-id/persona-web/pulls/$pr/reviews" \
    --jq '[.[] | select(.user.login == "<handle>")] | length' 2>/dev/null)
  [ "$reviews" != "0" ] && [ -n "$reviews" ] && echo "PR #$pr: $reviews"
done < /tmp/teammate_prs_unique.txt
```

*Tier 3 — Review comment substance*
```bash
gh api "repos/persona-id/persona-web/pulls/<pr>/reviews" \
  --jq '.[] | select(.user.login == "<handle>") | {state, body_length: (.body | length), body: .body}'
gh api "repos/persona-id/persona-web/pulls/<pr>/comments" \
  --jq '.[] | select(.user.login == "<handle>") | {body, path, line}'
```
Distinguish rubber-stamp approvals (empty body, `APPROVED`) from substantive review (comments
with suggestions, design pushback, line-level feedback).

**Reporting:** "Events API: N review events over <range>. Targeted sample: M reviews across K
teammate PRs (<range>)." Don't claim "zero reviews in 12 months" from only Tier 1.

#### FDE (customer-facing) — additional

FDE work is concentrated OUTSIDE persona-web review threads. GitHub-only methodology will
systematically under-level FDEs. Evidence lives in:

**Customer channels — `#c-<customer>-internal`, `#launch-<###>-*`**
Search: `from:<@slack_id> in:#c-openai-internal`, etc. Look for:
- Technical POC footprint (driving implementation, not just coordinating)
- Launch channel ownership (did they create it, set the scope, run the project)
- Pushback on customer account teams when requirements are wrong (MOTS-flavor)
- Relationships with customer product/integrity teams (MOTS-flavor)
- AI-assisted demos or prototypes shared in customer threads (AI Fluency signal)

**Team Notion spaces — `go/fde` (or equivalent `go/<team>`)**
Search the team's Notion workspace path for docs they authored. For FDE specifically, the
FDEbrief database (Notion id `319ef6bcb0fd8096aa73d81db351c69d`) holds internal knowledge-share
docs.
- Founding / curating a team-wide knowledge-share program = SWE III/MOTS-flavor Tooling & AI +
  Leadership
- Individual FDEbrief contributions = teaching artifacts

**Cross-team product proposals — `#network-marketplace`, `#product-*`, `#eng-*`**
Search for proactive framework proposals (e.g. "I'd like to propose…" + product team blessing
thread). These are MOTS-flavor Code Architecture + Product Experience + Execution (cross-team
work).

**Customer-facing Google Docs**
Project management docs, integration specs, customer-shared playbooks, AI-prototype demos.
Check DMs with the user (who is usually the eng manager) for links.

**Cross-functional channels — security, product, infra**
E.g. `#engineering-security`, `#wg-*`. Driving security/infra work as an FDE (IP allowlisting,
Tailscale, vendor onboarding) is SWE III-flavor Execution (cross-team work).

**PR reviews — weight: lower for FDE**
Still check (Tier 1 + Tier 2). But for FDEs, low PR-review count is NOT an automatic floor
violation — see the soft floor below.

#### Frontend IC — additional

- Design-system contributions (tokens, primitives, shared component authorship)
- Storybook entries and accessibility PRs
- AI-assisted prototyping (high-fidelity mocks built with AI that informed product decisions)
- Visual regression evidence
- Weighting for PR review is same as backend/platform

#### ML/infra IC — additional

- Experiment docs, model-shipping logs, eval framework contributions
- On-call shifts, incident follow-through, SLO/SLI authorship
- Infrastructure migrations (dual-write, shadow traffic, cutover retros)
- AI agent infrastructure (subagent harnesses, agent eval frameworks, agentic CI)

### The Mentorship/Collaboration floor (revised)

Below-floor means **all three** of these are true:
1. Zero substantive outbound peer code review in the window
2. Zero cross-functional teaching artifacts (docs authored, design review comments,
   knowledge-share presentations, customer-POC teaching, public cross-team advocacy)
3. Zero shared AI infrastructure contributions (CLAUDE.md sections, skills, slash commands,
   agent harnesses, prompt libraries) used by anyone other than themselves

Any one above zero clears the floor. An FDE who teaches customer integrity teams, authors
FDEbrief docs, and never reviews persona-web PRs is above floor. A backend IC who ships skills
that the team uses but rarely reviews PRs is above floor. The point is *teaching footprint*,
which now includes shared AI infra.

### Phase 3 — Rate each competency one by one

**Do NOT produce a summary table before rating individual competencies.** Go one at a time. For
each:

1. **Quote the rubric verbatim** — the levels in your anchoring bracket (see "Which rubric
   bracket to quote"). Widen the bracket for a specific competency if evidence points above the
   default ceiling.
2. **For Tooling & AI specifically — rate both sub-indicators separately.** Do not collapse
   "Tooling knowledge" and "AI Fluency" into one number. Quote both rubric strings, give both
   ratings, then synthesize. They diverge: many engineers are SWE III on tooling but SWE I/II on
   AI fluency, and vice versa.
3. **For Collaboration specifically — rate both sub-indicators (Team unity, Company unity)
   separately**, then synthesize. Note: cross-team contribution evidence is scored under
   **Execution**, not Collaboration — don't double-count.
4. **State evidence for the rating** — with specific artifacts (commit SHAs, PR numbers, doc
   titles, Slack message permalinks, launch channel names, skill paths, CLAUDE.md sections).
5. **State evidence against adjacent ratings** — what would the next level look like, and which
   pieces are missing / present?
6. **Give the rating** with a confidence modifier. Examples across the full range:
   - `"SWE I (ramping)"`, `"SWE I → SWE II floor"`
   - `"SWE II (mid)"`, `"SWE II (solid)"`, `"SWE II (solid-to-high)"`
   - `"SWE III (low)"`, `"SWE III (mid)"`, `"SWE III (solid)"`
   - `"SWE III → MOTS (low)"`, `"MOTS (low)"`, `"MOTS (mid)"`
7. **Pause for user pushback** before moving to the next competency.

After the user pushes back or agrees, revise in writing with new evidence. The initial rating is
a draft, not a verdict.

### Phase 4 — Summary

Only after all 9 are individually rated and confirmed:

- Table of ratings (with sub-indicator breakdown for Tooling & AI and Collaboration)
- One-paragraph overall read anchored to the calibration hypothesis (supported / refined /
  refuted, with evidence)
- The 2–3 weakest dimensions (promotion blockers or ramp gaps)
- The 1–2 strongest dimensions (what to build from)
- Explicit tenure-adjusted trajectory statement
- **AI Fluency note**: explicitly call out whether their AI use is personally-effective only or
  scales to others (skills, CLAUDE.md, harnesses) — this is a load-bearing distinction for
  SWE III ↔ MOTS.

## Positive and negative signals

### SWE I-flavor positive signals (ramp)

- **Consistent delivery of bounded tasks** with growing surface area over the window
- **Asking questions in public channels** instead of DMs — learning visibly
- **Shadow/pair artifacts** — notes from pairing sessions, follow-up questions on reviewed PRs
- **First-attempt postmortem contributions** — small but real follow-ups
- **Reviewed-not-blindly-accepted AI output** — can explain committed AI-assisted code; PR
  descriptions explain *why*, not just paraphrase the diff
- **Open to working outside team's domain** — even small contributions, AI-assisted context
  building

### SWE II-flavor positive signals

- **Complete rollplans** executed independently (scoped → shipped → retroed)
- **Reliable code reviews on own team's surface** with occasional substantive comments
- **Small design docs** for changes they own
- **On-call shifts handled** without systematic escalation
- **AI as default workflow** — visible prompt quality (sufficient context, not one-liners),
  AI-assisted prototypes shared with team
- **Spots AI-generated bugs in review** — security/assumption/architectural-fit comments on
  AI-attributed PRs
- **Proactively contributing outside team's domain** — meaningful PRs to other teams' codebases,
  not just one-off fixes
- **Automation + guardrails** — reducing error-prone or repetitive team work

### SWE III-flavor positive signals

- **Finalized, shared design docs** with resolved decisions — not WIP or decoration
- **Framework-level investments** — building a registry/lifecycle/harness that makes the next
  version a config change, not a new class
- **Teaching artifacts** — brown bags, onboarding docs, runbooks authored
- **Substantive outbound code review** — comments that teach, not just approve
- **Cross-team presence** — commits to shared infra, advocacy in cross-team Slack
- **Postmortem follow-through** — converting incident learnings into tooling or guardrails
- **Clean migrations** — dual-write phase, shadow validation, zero-revert cutover
- **Proactive scoping memos** — "here's what we should prioritize next quarter and why"
- **Authored / co-authored CLAUDE.md sections, skills, or slash commands** that other engineers
  use — measurably improves team AI output quality
- **AI-built prototypes that informed real product decisions** (not just personal speed-ups)
- **Bridge-between-teams behavior** — identifies cross-team implications of own work and
  proactively coordinates
- **Tooling improvements that benefit teams beyond their own**

### MOTS-flavor positive signals

- **Founding or owning team-wide programs** — knowledge-share series (FDEbrief-style),
  onboarding curriculum, review rotations
- **Framework-level product proposals with product-team buy-in** — identifying the abstraction
  gap and getting org approval to ship the abstraction itself (not just using it)
- **Technical representation to business/sales/customers** — main technical POC on strategic
  accounts, running project management with customer teams, pushing back on account-team framing
  when incorrect
- **Translating fuzzy requirements into product direction** — not just implementing clear asks
  but shaping what should be built
- **Escalating systemic/org-level risks to leadership** — "this pattern will break at scale,
  here's why" with evidence
- **Cross-team influence without authority** — advocacy that changes other teams' behavior (not
  just their own)
- **Broad mentorship footprint** — multiple engineers across teams reference them as a learning
  source
- **Multi-step agent automations shipped** — auto-PRs, auto-triage, auto-benchmark harnesses
  running in production with minimal manual intervention
- **"Zones" / harnesses for other teams** — bounded AI-safe contribution paths created for
  engineers outside the original team's domain
- **Trusted voice on AI adoption** — written/presented evaluations of new AI features cited by
  others when making adoption decisions
- **Repeatable, scalable AI patterns** — adoption that propagates beyond personal use

### Plateau/stall signals (especially for 3+ year tenure)

- **Version churn without design docs** — V2→V4 skipping V3 suggests V2 didn't work and the
  team didn't write about why
- **Reverts without postmortems** — 5 reverts on a migration without a retro is an uncontained
  feedback loop
- **Handoffs completed by others** — work that ships 6 months later via a different engineer
  means the integration didn't ship on the first attempt
- **State-specific patches months after launch** — "fix id_damaged for SC, VA" in month 10
  means precision monitoring wasn't built in at launch
- **WIP design docs with the load-bearing question unresolved** — the design doc was decoration,
  not a driver
- **All three floor conditions simultaneously** — no PR review AND no cross-functional teaching
  artifacts AND no shared AI infra
- **Slack footprint only in own-work threads** — no cross-team presence, no team-level advocacy
- **High AI shipping volume + low review depth** — large commit counts that include reverts/
  bugs reading like un-reviewed Claude/Cursor output, PR descriptions that paraphrase the diff
  rather than explain why
- **Personal-only AI fluency** — visibly fast at AI-assisted work but zero shared
  artifacts (no skill, no CLAUDE.md, no documented prompt patterns); doesn't scale to teammates
- **Defensive over-engineering pattern** — try/catch around everything, validation on internal
  calls, unnecessary fallbacks that don't match repo conventions (often AI-generated
  boilerplate accepted without review)

## Red-team your own assessment

Before presenting the final summary, check ALL three directions:

### Am I being too generous?
- **Did I verify every specific claim?** Any "she does X" needs a query result behind it.
- **Am I generous because the person ships?** Shipping is table stakes. Higher-level bars are
  about *how* the shipping happens (design, lifecycle, stability, teaching, AI review depth).
- **Did I confuse AI shipping volume for AI fluency?** A high commit count from AI-attributed
  branches with reverts and paraphrase-the-diff PR descriptions is *negative* signal, not
  positive.
- **Would I stake the rating on the evidence?** If asked "what specifically earns this rating,"
  can you name 3 artifacts?

### Am I being too harsh?
- **Did I run the track-specific playbook?** If this is an FDE, did I search `#c-*-internal`,
  `#launch-*`, `go/<team>` Notion, `#network-marketplace`, customer-facing docs? If not, re-run
  before finalizing.
- **Did I run the AI Fluency sweep?** Did I check `.claude/skills/`, CLAUDE.md authorship,
  `.claude/commands/`, `.claude/agents/`, AI Slack channels? An engineer with deep AI infra
  contributions is doing SWE III/MOTS-flavor work that's invisible to a GitHub-only methodology.
- **Did I mistake GitHub invisibility for absence?** "I couldn't find X" ≠ "X doesn't exist."
  Note what you couldn't verify, and flag whether the search was track-appropriate.
- **Does the calibration hypothesis conflict with my rating?** If the user said "I think they're
  at low MOTS" and I came in at SWE II, I should have found evidence either supporting MOTS or
  actively disconfirming it — not just failed to search the right channels.
- **Am I applying a hard gate that's structurally biased against this track?** The old "zero PR
  reviews = below floor regardless" gate under-levels FDEs; use the three-condition floor
  instead.

### Am I converting pushback into evidence, or just rhetoric?
- **Did I re-run the query when the user challenged?** Don't just soften the language. Re-run
  or explicitly defend the original rating with the existing evidence.

## Commands

### `/competency-assessment <person>`

Full 9-competency assessment.

1. Setup (identity, tenure, window, **track**, **calibration hypothesis if provided**)
2. Gather evidence — base sweep + AI Fluency sweep + track-specific sweep, in parallel
3. Rate competencies one by one, pausing for user input after each
4. Produce summary table and overall read (anchored to the calibration hypothesis)

### `/competency-assessment <person> <competency>`

Deep-dive on a single competency (useful when the user wants to revise or challenge a specific
rating).

Run the focused evidence gathering for that dimension, quote the rubric bracket, produce the
rating with specific artifacts. For Tooling & AI and Collaboration, rate sub-indicators
separately.

## Output style

- **Quote the rubric.** Don't paraphrase the levels. Paste the bracket language verbatim from
  MATRIX.md.
- **Link the evidence.** Use markdown links for commits (`[abc1234](...)`), PRs (`[#12345](...)`),
  Slack (`[permalink](...)`), docs, skill paths.
- **Tables for comparative claims.** When showing version churn, revert patterns, or
  competency-level shifts, use a table so the pattern is visible at a glance.
- **Rating with confidence modifier.** `"SWE III (mid)"` beats `"SWE III"`. `"SWE III → MOTS
  (low)"` beats `"between SWE III and MOTS"`.
- **Sub-indicator breakdown for Tooling & AI and Collaboration.** Show both sub-ratings before
  synthesizing.
- **Separate revised ratings clearly.** When a rating changes based on new evidence, label it
  "Revised" and explain what changed (specifically: which evidence source, not just "new info").

## What NOT to do

- **Don't default to the SWE II↔III bracket.** Match the bracket to tenure + level.
- **Don't run only the GitHub methodology for FDE/customer-facing roles.** You will under-level
  them.
- **Don't skip the AI Fluency sweep.** It is now a co-equal sub-indicator of Tooling & AI;
  skipping it returns an incomplete rating.
- **Don't conflate AI shipping volume with AI fluency.** Volume tells you nothing; review depth
  and shared infra tell you everything.
- **Don't collapse Tooling & AI into one rating.** Tooling Knowledge and AI Fluency commonly
  diverge — rate both.
- **Don't collapse Collaboration into one rating.** Team unity and Company unity each have
  their own ladder. Cross-team contribution evidence belongs under Execution, not here.
- **Don't skip the one-by-one rhythm.** Batch summaries let bias hide.
- **Don't use qualifiers instead of queries.** "She probably reviews some PRs" is worse than
  "I didn't verify review count." Then go verify.
- **Don't grade on effort.** "She's working hard" is not a rubric dimension.
- **Don't soften ratings because the user disagrees.** Re-run the query, add evidence, or keep
  the rating. Softening without new data is the worst outcome.
- **Don't harden ratings upward just because the user has a higher prior.** Same rule — re-run
  the query, add evidence, or keep the rating.
- **Don't skip the tenure + track adjustments.** A rating without tenure-adjusted trajectory
  AND track-adjusted evidence weighting is incomplete.
