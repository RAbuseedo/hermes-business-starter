---
name: agency-ops
description: "Use when running an agency's clients, projects and team. Tracker + rhythm."
version: 1.0.0
author: hermes-business-starter
license: MIT
platforms: [macos]
metadata:
  hermes:
    tags: [agency, projects, clients, team, invoices, content-calendar]
    related_skills: [client-crm, daily-briefs, open-loops, owner-todos, agency-marketing, google-workspace]
---

# Agency operations

Day-to-day operating system for a service company (marketing, creative, content, web, video). Hermes keeps the records, watches the dates, drafts the follow-ups, and reports in the briefs. The owner decides; staff deliver; Hermes makes sure nothing slips.

## Where things live (plain Markdown, one source of truth)
- `~/.hermes/notes/business-profile.md` services, packages, prices, tools.
- `~/.hermes/notes/team.md` one section per employee: name, role, email, WhatsApp, manager, skills, current load. **Staff are not principals.**
- `~/.hermes/notes/clients/<client-slug>.md` see `client-crm`.
- `~/.hermes/notes/projects/<client-slug>--<project-slug>.md` one per project (template below).
- `~/.hermes/notes/money.md` quotes out, invoices issued, due dates, payments received, overdue.
- `~/.hermes/notes/content-calendar/<client-slug>-<yyyy-mm>.md` social calendar per client per month.
- `~/.hermes/notes/subscriptions.md` every paid tool, cost, renewal, card, approver.
If the company already uses a tool (Asana, ClickUp, Monday, Trello, Notion, Google Sheets, Zoho, Odoo...), mirror it read-only first and ask the owner whether that tool or these notes are the source of truth. Never keep two masters.

## Project file template
```
# <Project> — <Client>
Status: brief | quoted | approved | in production | client review | revisions | delivered | invoiced | paid | on hold
Owner (staff): <name>   Account lead: <name>
Quote: <amount, currency, ref>   PO/contract: <ref or none>
Start: <date>   Due: <date>   Client approval needed by: <date>
## Deliverables
- [ ] <deliverable> — <assignee> — due <date> — status — link
## Approvals
- <date> <what> sent to <client contact> — waiting / approved (evidence: email subject+date)
## Log
- <date> <what happened> (source)
```

## Daily loop (morning brief and evening brief feed from this)
1. **Intake:** new client requests from email/WhatsApp → create or update the client file and a project file with status `brief`; draft a reply acknowledging receipt for the owner to OK.
2. **Deliverables due in 48h:** list with assignee; if no update in 24h, draft a check-in to the assignee.
3. **Client approvals waiting > 2 working days:** draft a polite reminder in the client's language.
4. **Staff follow-up:** each morning, per person: what is due today, what is overdue. Drafts only, unless the owner gave a standing OK ("send the daily task reminders to the team"); record standing OKs in `team.md`.
5. **Timesheets (if used):** weekly, compare logged hours vs retainer hours per client; flag overruns before they happen (80 percent used).
6. **Money:** quotes with no answer after 5 days → reminder draft; invoices due in 7 days → heads-up; overdue invoices → escalating reminder drafts (friendly, firm, final). Never send a payment demand without the owner's OK. Never promise discounts.
7. **Renewals:** domains, hosting, licences, retainers ending in 30 days.

## Quotes and invoices
- Draft quotes from `business-profile.md` price list; show the owner the draft and margin assumptions. Numbering, VAT (UAE VAT is 5 percent; confirm the company's TRN and whether prices are VAT-inclusive) and payment terms come from the profile.
- Invoices are issued in the company's accounting tool by the person responsible; Hermes tracks status and chases, it does not issue invoices without the owner's OK.

## Social content calendar (for clients on social media management)
- Per client per month: date, platform (Instagram, TikTok, Snapchat, X, LinkedIn, Facebook, YouTube), format (post, carousel, reel, story), pillar/theme, caption EN, caption AR, hashtags, visual brief, assignee, status (idea → copy → design → internal review → client approval → scheduled → published), link.
- Include local calendar dates: Ramadan and Eid (dates shift yearly, check), UAE National Day (2 December), Commemoration Day (30 November), Flag Day (November), New Year, back-to-school, Dubai Shopping Festival, GITEX, and the client's own campaigns.
- Arabic captions are written, not translated (see `agency-marketing`). Government clients: formal tone, check naming of entities and officials, never use sensitive imagery; always their approval before posting.
- Hermes never publishes or schedules posts itself unless the owner has connected a scheduler and given a standing OK for a named client.

## Creative production tools
- Design, video and AI tools the company uses are listed in `business-profile.md`. For AI video and image generation, a common tool is **Higgsfield** (higgsfield.ai). It has a developer API (docs.higgsfield.ai; keys created in its cloud console) that is billed from a **separate prepaid balance**, not the app subscription credits. If the owner wants Hermes to generate drafts through it: they create an API key themselves, store it in Bitwarden as `HIGGSFIELD_KEY_ID` and `HIGGSFIELD_KEY_SECRET`, and set a small prepaid top-up on the company card. Until then, Hermes writes prompts and shot lists that staff run in the app.
- Every AI-generated asset is labelled as such in the project file; client and talent likeness, brand marks, and music rights are checked before delivery.

## Reporting
Morning and evening briefs pull: new requests, due in 48h, waiting on client, overdue staff tasks, money due/overdue, renewals. Weekly review adds: projects delivered, revenue invoiced and collected this week, utilisation per person (if timesheets), client health (green/amber/red with reason).

## Hard lines
Hermes drafts; the owner sends, publishes, spends, and signs, unless a standing OK is recorded for a named routine.
