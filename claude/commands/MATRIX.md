# Persona Engineering Levels Matrix (2026 Proposal)

**Source of truth.** Reference this file when quoting rubric language verbatim. Synced from the
"Engineering Levels Matrix - Proposal 2026 - Engineering" PDF on 2026-05-06. If the user volunteers
a newer matrix location, prefer it and update this file.

## Levels

- **SWE I** — entry-level engineer
- **SWE II** — fully autonomous on team-scope work
- **SWE III** — domain expert, designs abstractions, leads projects
- **MOTS** (Member of Technical Staff) — drives technical decisions across teams/company

## Themes and competencies

The 9 competencies group under 4 themes:

- **Technical Mastery** — Code Architecture, Tooling & AI, Execution
  - *Demonstrates the ability to make well-reasoned design decisions within the team's system and
    considers broader implications for the entire organization. Balances tradeoffs effectively,
    ensuring the overall system integrity.*
- **Product Oriented Mindset** — Product Experience, Business Alignment
  - *Advocates for and improves the end-user experience by refining product requirements. Drives a
    focus on user needs and actively contributes to the product roadmap prioritization.*
- **Operational Excellence** — Observability/Productionization, Debugging
  - *Ensures the reliability and observability of deployed systems. Proactively identifies and
    addresses issues to minimize errors, running efficient on-calls and driving improvements based
    on learnings.*
- **Teamwork** — Leadership, Collaboration
  - *Elevates the team through collaborative practices such as code reviews, pairing, and technical
    discussions. Actively contributes to team improvement, providing constructive feedback and
    helping team members achieve goals.*

---

## 1. Code Architecture — engineering for long-term maintainability

### SWE I

- **Architecture & design**: Understands how well-formed tasks fit into the larger architecture
  picture and how their development work advances their team's long term architectural goals.
- **Scope**: Implements, maintains, and troubleshoots standalone components of their team's
  domain.
- **Output**: Produces functional code with correct behavior and minimal surface-level errors at a
  reasonable speed. Contributes to maintenance efforts such as reducing tech debt.

### SWE II

- **Architecture & design**: Understands domain-agnostic design patterns, principles, and best
  practices. Offers helpful comments when reviewing architecture and design proposals driven by
  others in their team to ensure alignment with team goals. Focuses on these areas in code review
  and goes beyond surface-level reviews.
- **Scope**: Implements, maintains, and troubleshoots functional surface areas of their team's
  domain. Able to work in areas outside of their team's domain.
- **Output**: Produces readable, maintainable code that consistently applies these patterns and
  principles, and improves existing code that does not meet the bar for quality. Proactively cleans
  up loose ends in own work after the fact.

### SWE III

- **Architecture & design**: Understands and makes well-reasoned design decisions and tradeoffs in
  their team's scope; considers extensibility, scale, and complexity costs. Understands abstract
  architectural principles such as domain modeling and designing good abstractions.
- **Scope**: Subject matter expert of areas of their team's domain. Consistently able to work in
  areas of the codebase outside their team's domain with minimal guidance.
- **Output**: Consistently produces high quality code with minimal oversight needed. Proactively
  drives improvement across the team via code review and code cleanups.

### MOTS

- **Architecture & design**: Drives technical decisions that impact other teams or the company
  outside of their immediate team's scope. Able to compromise and resolve tensions between product
  requirements and engineering design in a way that maximizes product value while minimizing
  complexity and maintainability costs.
- **Scope**: Subject matter expert of areas both inside and outside their team's domain. Assists
  other teams in effectively working in their domain.
- **Output**: Helps define and hold the technical bar on the team for long-term maintainability.
  Finds alternatives to avoid irreversible hacks in foundational architecture. Plans and executes
  on paying tech debt, fixing poor design, reducing complexity, and increasing maintainability.
  Identifies and proactively tackles technical debt before it grows into debt that requires
  significant up-front work to resolve.

---

## 2. Tooling & AI — improving how we engineer

### SWE I

- **Tooling knowledge**: Can use (or learn on demand) core tooling used by the company with
  minimal oversight, including but not limited to source code control, PR review, CI, release,
  monitoring, alerting, and on-call tooling. Identifies when existing tooling isn't working well
  for a task and raises it to the team.
- **AI Fluency**: Uses AI coding assistants (e.g. Cursor, Claude Code) for everyday tasks such as
  code generation, explanation, and debugging. Produces AI-generated code that is readable and
  reviewed before committing — does not blindly accept AI output and can explain the code they've
  committed. Can generate boilerplate, write basic prompts, and use AI to accelerate understanding
  of unfamiliar code. Understands that AI-generated code carries risk and applies the same review
  standards as human-written code.

### SWE II

- **Tooling knowledge**: Can use and extend internal tooling used by the company, including but
  not limited to internal maintenance tasks, minor repos with scripts, slack bots, zapier
  integrations, and admin tools. Identifies opportunities for improvement in tools and workflows
  used by the team and proposes solutions. Automates manual tasks and adds guardrails to reduce
  error-prone or repetitive work within the team.
- **AI Fluency**: Integrates AI tools into daily workflow as a default, not an afterthought.
  Writes effective prompts that provide sufficient context to get high-quality output —
  understands that prompt quality directly impacts code quality. Beginning to evaluate when AI is
  the right tool versus when manual implementation is faster or safer. Uses AI to rapidly
  prototype solutions and build demos that communicate ideas to teammates and stakeholders. Can
  identify when AI-generated code introduces subtle issues like security vulnerabilities,
  incorrect assumptions, or poor architectural fit.

### SWE III

- **Tooling knowledge**: Strong understanding of tooling used by the company. Can independently
  use these tools to problem solve. Understands the interaction between tooling and team surfaces,
  and helps maintain configurations and integrations based on team needs. Identifies and
  implements tooling improvements that benefit teams beyond their own.
- **AI Fluency**: Writes well-structured project requirements docs and effectively uses planning
  mode to break down complex work. Contributes to and maintains shared AI infrastructure such as
  CLAUDE.md files, skills, and documentation that meaningfully improve AI output quality for the
  team. Uses AI to build high-fidelity prototypes and demos that inform real product decisions.
  Actively expands AI's capabilities by integrating it with internal tools, APIs, and knowledge
  bases while evaluating the access and workflow risks of doing so. Collaborates with other teams
  to apply AI to new areas of the codebase.

### MOTS

- **Tooling knowledge**: Mastery of tooling used by the company. Coaches others on how to use
  their tools more effectively and efficiently through technical writing and presentation. Has a
  holistic understanding of the interaction between tooling and the Persona platform as a whole.
  Drives tooling and automation improvements that measurably increase productivity across the
  engineering organization.
- **AI Fluency**: Uses AI agent workflows effectively, including subagents and multi-step
  automations. Creates automations that ship PRs, close issues, and benchmark results with minimal
  manual intervention. Defines zones and creates harnesses that enable engineers on other teams to
  contribute safely to unfamiliar areas of the codebase. Evaluates and securely incorporates new
  AI features and tools as they emerge — acts as a trusted voice on what's worth adopting and what
  isn't. Drives AI adoption patterns that are repeatable and scalable, not just personally
  effective.

---

## 3. Execution — getting stuff done

### SWE I

- **Planning & execution**: Makes steady progress on well-scoped tasks. Communicates status
  effectively to the team, team lead and PM. Open to working on tasks outside their team's domain
  and uses AI tools to build context in unfamiliar areas rather than treating them as off-limits.
- **Delivery**: Knows who and when to ask for help in order to get themselves unblocked. Does not
  allow self to remain blocked for long.

### SWE II

- **Planning & execution**: Scopes abstract work and builds implementation plans with the team
  lead and PM. Understands strategies for derisking projects including but not limited to design
  docs, kickoffs, and milestones. Proactively looks for opportunities to contribute outside their
  team's domain rather than waiting to be asked. Can independently navigate unfamiliar areas of
  the codebase using AI tools and existing documentation to build context.
- **Delivery**: Persistent in the face of roadblocks. Understands and upholds timelines and
  escalates as necessary. Incorporates feedback from others and proactively attempts to
  self-improve.

### SWE III

- **Planning & execution**: Independently scopes abstract work into well-defined, actionable
  milestones. Proactively communicates with stakeholders and ensures requirements are aligned and
  concerns are addressed. Independently applies strategies to derisk projects when appropriate.
  Regularly contributes to projects outside their team's domain with minimal guidance. Acts as a
  bridge between teams — identifies when work in their own domain has implications for other teams
  and proactively coordinates.
- **Delivery**: Regularly delivers software on-time and is constantly working to make accurate
  estimates and deliver against those estimates. Proactively diagnoses and resolves project
  roadblocks.

### MOTS

- **Planning & execution**: Drives projects that require the work of multiple engineers across
  multiple teams' domains, owning both technical execution and cross-team coordination. Has deep
  enough understanding of multiple teams' systems to make architectural decisions that account for
  cross-product impact. Enables others to contribute cross-product by creating context,
  documentation, and guardrails that lower the barrier to entry. Owns and drives strategies to
  keep project on track.
- **Delivery**: Has an extensive track record of accurate estimates and delivery against these
  estimates. Work acts as a model for others to improve and benchmark against.

---

## 4. Product Experience — improving and defining project requirements for users

### SWE I

- **Product-mindedness**: Has a basic understanding of the team's products, users, and direction.
  Knows what problems the team is trying to solve, and how their work fits in.
- **Product requirements**: Implements tech specs provided by the team lead, and able to resolve
  gaps in specs. Understands how tech specs map to product requirements. Works with PM/team lead
  to ensure completed work is properly handed off to stakeholders.

### SWE II

- **Product-mindedness**: Understands the team's core products, direction, and how the product
  fits into Persona's platform sufficiently well to be an effective engineering partner to
  product/design.
- **Product requirements**: Partners with PM and/or team lead to translate product requirements to
  tech specs. Ensures that tech specs sufficiently fulfill provided product requirements. Ensures
  that completed work is properly handed off to stakeholders (via documentation, help center,
  training, GTM motions, self-serve, etc.)

### SWE III

- **Product-mindedness**: Actively shapes direction of individual product features through
  collaboration with cross-functional partners like product/design. Develops and communicates
  opinions on what makes for a good product experience.
- **Product requirements**: Able to independently translate product requirements to tech specs,
  and executes on implementation. Ensures that tech specs and product requirements sufficiently
  fulfill stakeholder needs. Consistently hands off completed work in a clear and comprehensive
  way.

### MOTS

- **Product-mindedness**: Actively shapes overall product direction through collaboration with
  cross-functional partners like product/design. Has a strong understanding of the team's
  long-term product and engineering vision, and reconciles stakeholder needs with this vision.
- **Product requirements**: Able to independently translate stakeholder needs into product
  requirements and backfill for basic PM tasks. Prioritizes with a user-centric approach and
  conducts prototyping and validation. Partners with stakeholders to ensure release management is
  handled across the product.

---

## 5. Business Alignment — understanding and aligning with business goals

### SWE I

- **Business goals**: Has a basic understanding of the team's business objectives (e.g. winning
  specific deals/expansions, closing gaps that have lost deals, maintaining customer
  relationships, GTM/biz efforts). Has a basic understanding of prioritization based on the
  business impact of tasks.
- **Enablement**: Participates in enablement activities that advance the team's business goals,
  including but not limited to customer questions/requests, customer configuration/integration,
  data tests and audits, incident remediation, GTM efforts, etc. Understands the business value of
  these activities.

### SWE II

- **Business goals**: Understands the team's business objectives. Understands short and long term
  goals and needs, and proactively prioritizes tasks to maximize business impact.
- **Enablement**: Consistently and effectively participates in enablement activities that advance
  the team's business goals. Directly partners with biz/sales to problem solve specific issues.

### SWE III

- **Business goals**: Understands how the team's business objectives and product/engineering goals
  relate to each other. Able to reconcile business needs that conflict with long-term engineering
  and product goals. Able to make well-reasoned tradeoffs when it comes to accepting tech debt or
  compromising roadmap goals. Actively communicates with stakeholders to drive alignment.
- **Enablement**: Actively improving processes and workflows for enablement activities in addition
  to executing on the tasks themselves. Can provide technical representation for the team when
  working with biz/sales (e.g. acting as the engineering POC for a particular deal).

### MOTS

- **Business goals**: Drives alignment between business goals, product roadmap, and engineering
  goals. Proactively identifies alignment opportunities, engages stakeholders effectively, and
  makes data-driven decisions to contribute to business goals.
- **Enablement**: Scales out enablement activities to expand the team's capabilities. E.g.
  conceptualizing and implementing the solution library, moving from customer-based audits to
  country-based audits, developing an action plan for Inquiry platform parity. Consistently
  provides timely and comprehensive technical representation for the team when working with
  biz/sales, both internally and externally (e.g. customer calls).

---

## 6. Observability / Productionization — extending our ability to understand and improving running state of system

### SWE I

- **Productionization**: Understands the principles of observability (metrics, monitoring) core
  concepts of our tooling (e.g. alerting, metrics, spans), and how to instrument code. Can build
  new instrumentation and extend existing instrumentation with support from others.
- **Operational Support**: Participates in team oncall rotation (or similar process) with
  guidance and support from other team members.
- **Remediation**: Participates in followup work from incidents and oncall (bugfixes, remediation
  analysis, collaborating with biz team). Understands what the response process for urgent/critical
  incidents entails without necessarily participating.

### SWE II

- **Productionization**: Independently builds with appropriate instrumentation, monitors, logs,
  and graphs to reduce future issues and increase ability to respond to issues. Documents and
  shares operational instructions (triage steps, etc.) for new features when appropriate.
- **Operational Support**: Participates in team oncall rotation (or similar process) with
  increased independence. Consistently resolves issues comprehensively and in a timely manner.
  Understands when to escalate, and learns from each escalation. Contributes to tooling
  improvements to ensure technical stakeholders (e.g. your/other teams oncall) and operational
  stakeholders (e.g. biz/sales) have what they need to understand and manage issues that arise.
- **Remediation**: Resolves production-level exceptions and errors. Understands how to use
  existing tooling to accelerate incident response (e.g. PagerDuty, incident.io, debugging tools).

### SWE III

- **Productionization**: Consistently builds in a way that minimizes the need for manual
  intervention, extensive debugging, or lengthy recovery times. Extensive understanding of edge
  cases, failure modes, and antipatterns.
- **Operational Support**: Has the necessary platform knowledge to participate in cross-product
  incident remediation and scaling and reliability efforts. Owns operational processes (eg.
  on-call, deployment, or release processes) and drives improvements (e.g. by improving processes
  / tooling, identifying and resolving trends and shared root causes). Works with other teams to
  ensure that cross-product issues are appropriately handled.
- **Remediation**: Can represent the team when assisting with wide-reaching alerts or emergencies
  affecting multiple surface areas in a consistent and trustworthy manner.

### MOTS

- **Productionization**: Contributes to overall observability and understandability of
  platform/system health. Has a deep understanding of product and engineering metrics, and uses
  this to establish norms and best practices for productionization on the team.
- **Operational Support**: Drives systematic improvement to oncall/operational processes (e.g.
  creating and executing plans to fix root causes and improve overall stability, holistically
  identifying and filling monitoring holes, addressing cross-team issues).
- **Remediation**: Can assist with alerts or emergencies even in areas where one lacks immediate
  context.

---

## 7. Debugging — effectively debug deployed systems, minimize downtime, and optimize system performance to ensure operational excellence

### SWE I

- **Debugging**: Understands effective troubleshooting strategy (e.g. collecting data, reproducing
  issues, bisecting). Can independently utilize resources like stack traces, logs, and error
  monitoring tools to identify root causes and propose fixes. May reach out to others for guidance
  and mentorship on issues that require more specialized knowledge. Learns from each escalation.

### SWE II

- **Debugging**: Understands one's own product well enough to identify and diagnose standard
  issues. Understands various troubleshooting techniques and tools, and actively works to increase
  one's toolbox. May reach out to others for guidance and mentorship on issues that require more
  specialized knowledge. Learns from each escalation.

### SWE III

- **Debugging**: Understands the entire application stack well enough to independently identify
  and diagnose standard issues. Is a domain expert at debugging and resolving issues in their
  team's products.

### MOTS

- **Debugging**: Resolves deep unknowns across the entire application stack via detailed and
  methodical analysis. Understands what data are needed to proceed and how to get it. Examples
  include but aren't limited to: inserting logging / alerting to collect information necessary to
  progress on issues; running long-lived coordination channels / docs to resolve customer issues;
  addressing flaky tests; addressing "intermittent" / inactionable pages.
- Investigations regularly leads to written or presented artifacts that educate their peers on
  system quirks, gotchas, or design issues that need to be fixed / worked around.

---

## 8. Leadership — enhancing teamwork and organizational success

### SWE I

- **Self-growth**: Plays an active role in their own growth (eg. Starts timely conversations with
  peers and managers on confusing topics). Speaks up when confused or needs clarification rather
  than stalling or delaying desired outcomes.

### SWE II

- **Mentorship**: Contributes to improving the team environment through pairing, design review,
  code review, or other forms of context sharing.
- **Technical leadership**: Points out potential problems and opportunities on the team and helps
  team find improvements.

### SWE III

- **Mentorship**: Proactively improves others through mentoring, technical guidance (reviews,
  pairing, etc.), and teaching (via docs, presentations, etc.).
- **Technical leadership**: Leads projects by building then executing on plans, in conjunction
  with their manager and PM. Proposes and drives alignment on technical decisions.

### MOTS

- **Mentorship**: Acts as a role model and mentor to every technical member of the team.
  Identifies growth areas in others and assists them in closing gaps.
- **Team improvements**: Has and is capable of acting as defacto tech lead for their team for
  most projects, especially those that require significant cross-team collaboration.

---

## 9. Collaboration — fostering effective teamwork and communication

### SWE I

- **Team unity**: Actively learns about the projects their teammates are driving through active
  participation in team meetings or other team processes.
- **Company unity**: Effectively communicates status to the team and cross-functional
  stakeholders.

### SWE II

- **Team unity**: Helps teammates' work through existing collaborative processes (eg. code
  reviews, design documents, pairing, etc.).
- **Company unity**: Effectively works cross-functionally with partners and stakeholders across
  the company.

### SWE III

- **Team unity**: Is an active participant in shaping the design / architecture of projects
  driven by their peers. Actively identifies opportunities to help with other projects and avoid
  execution risk across the team.
- **Company unity**: Shows a strong ability to account for and incorporate feedback given to them
  by their peers such that everyone is satisfied with how the decisions made (not necessarily the
  decision itself).

### MOTS

- **Team unity**: Contributes to conversations about the technical direction of the team and
  helps guide the team to act on those conversations.
- **Company unity**: Is a trusted cross-functional partner to help with high stakes situations.
  Viewed by stakeholders as someone reliable who resolves issues holistically and does not leave
  loose ends.
