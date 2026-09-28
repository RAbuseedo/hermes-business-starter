---
name: company-profile
description: "Use when learning the owner's company. Research, interview, write profile."
version: 1.0.0
author: hermes-business-starter
license: MIT
platforms: [macos]
metadata:
  hermes:
    tags: [discovery, business-profile, interview]
    related_skills: [owner-onboarding, client-crm, agency-ops]
---

# Company profile discovery

Build `~/.hermes/notes/business-profile.md` so Hermes can run the company with context.

## 1. Research first (quiet, public sources only)
Company website (services, clients/portfolio, team page, contact), LinkedIn company page, Google Business profile and reviews, public social accounts, trade licence details the owner shares. Record the source URL next to each fact. If `~/.hermes/starter/profiles/<company>.seed.md` exists, start from it; it holds public facts only.

## 2. Interview (max 3 questions per message, owner's language)
- Services and packages; typical prices, retainers, minimums; what is most profitable; what they want more of.
- Clients: top active clients, sectors (government/private), how work arrives, approval chains.
- Team: name, role, email, WhatsApp, manager, strengths, current projects. Mark all as staff (not principals). Ask who, if anyone, may give Hermes instructions (delegates) and for what.
- Tools: project management, accounting/invoicing, design suite, AI creative tools, social schedulers, ad accounts (Meta, Google, TikTok, Snap, LinkedIn, X), website hosting and domain registrar, CRM, storage, time tracking, e-signature.
- Money: quote/invoice process, VAT registration, payment terms, who chases.
- Pain: the three things the owner wants off their plate first.

## 3. Write
`business-profile.md` from the template in notes; `team.md`; `clients/*.md` (see `client-crm`); update `accounts.md` with tools found. Show the owner a one-screen summary and fix what they correct. Then fill SOUL placeholders (see `owner-onboarding`).

## Privacy
Business contact details only. Nothing personal about staff beyond work contact and role. The profile stays on this Mac (and its encrypted backup).
