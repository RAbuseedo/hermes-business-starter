---
name: client-crm
description: "Use when tracking clients and contacts from email and WhatsApp."
version: 1.0.0
author: hermes-business-starter
license: MIT
platforms: [macos]
metadata:
  hermes:
    tags: [crm, clients, relationships]
    related_skills: [agency-ops, email-inbox-triage, google-workspace]
---

# Client CRM (plain notes)

A light CRM built from mail and chat, kept in `~/.hermes/notes/clients/`. If the company already runs a CRM (HubSpot, Zoho, Pipedrive, Salesforce, Odoo), use that as the master and keep these notes as Hermes' working summary only.

## One file per client: `clients/<slug>.md`
```
# <Client name>  (government | private | agency | individual)
Status: lead | proposal | active retainer | project | paused | former
Services: <what we do for them>
Retainer/contract: <amount/month, start, renewal date, notice period>
Contacts:
- <name> — <role> — <email> — <phone/WhatsApp> — prefers <EN/AR, email/WhatsApp>
Our side: account lead <staff name>
Brand notes: <tone, colours, do/don't, approval chain>
Open: <active projects, links to project files>
Last contact: <date> <channel> <one line>
Health: green | amber | red — <why>
```

## Building it
1. Seed from the owner's interview (onboarding step 8).
2. Enrich from the last 12 months of mail: sender domains, signatures (roles, phones), threads with quotes/invoices. Read only; record the source of each fact.
3. WhatsApp (if connected): add conversations with known client contacts; unknown numbers go to a "who is this?" list for the owner.
4. Keep private data minimal: business contact details only.

## Upkeep
- Update `Last contact` whenever a message is exchanged.
- Flag in the brief: clients with no contact in 30 days (active), retainers renewing in 45 days, health turning amber/red.
- Before any client meeting: a 5-line prep (who, history, open items, money, what to ask).
