---
name: comms-channels
description: "Use when connecting WhatsApp or a phone line (Twilio). Options + setup."
version: 1.0.0
author: hermes-business-starter
license: MIT
platforms: [macos]
metadata:
  hermes:
    tags: [whatsapp, twilio, sms, voice]
    related_skills: [owner-onboarding, secrets-intake]
---

# WhatsApp and phone line

Decision guides: `~/.hermes/starter/onboarding/WHATSAPP-OPTIONS.md` and `PHONE-LINE-OPTIONS.md`. Present them in plain words, recommend, and wait for the owner's choice. Nothing paid without an explicit yes.

## WhatsApp
- Official (Cloud API): follow Hermes docs → Messaging → WhatsApp Cloud (`hermes gateway setup` → WhatsApp Cloud). Needs Meta Business verification, a dedicated number, a public webhook (Cloudflare Tunnel), templates for first contact. Tokens into Bitwarden.
- Linked-device bridge: `hermes whatsapp` (QR pairing) on a dedicated spare number only. Allow-list the numbers that may talk to Hermes; everyone else is ignored.
- All client messages are drafts until the owner OKs them, unless a standing OK is recorded for a routine.

## Phone (Twilio)
- Owner creates the Twilio account (trial first) and verifies their phone; the account SID, auth token and later the phone number go into Bitwarden under the variable names the telephony skill lists.
- Install the optional skill: `hermes skills install official/productivity/telephony` and follow it for numbers, SMS and AI calls. Hermes SMS docs: docs → Messaging → SMS.
- UAE realities (re-check Twilio's UAE guidelines before buying): only toll-free UAE numbers, with a Letter of Authorization; no two-way SMS; outbound SMS needs a registered Sender ID (about 2 weeks); promotional SMS not between 21:00 and 07:00.
- Voice agent: identifies itself as the company's AI assistant, takes messages, books callbacks; never quotes prices, commits dates, or agrees terms. Call summaries go to the Clients topic.
