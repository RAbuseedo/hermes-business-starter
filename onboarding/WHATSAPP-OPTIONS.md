# WhatsApp: which route?

Hermes supports two WhatsApp integrations. They can run side by side on different numbers.

## Route 1: WhatsApp Business Cloud API (official, Meta)
- **What:** Meta's official API on a dedicated number that is NOT used in the WhatsApp app.
- **Good for:** anything client-facing, government clients, long-term stability.
- **Ban risk:** none from the integration itself (normal WhatsApp Business policy still applies: no spam, opt-in for marketing).
- **Needs:** Meta Business account (business verification with trade licence), a Meta app with the WhatsApp product, a phone number that can receive a verification SMS/call, a permanent access token (stored in Bitwarden), a public HTTPS webhook (Cloudflare Tunnel is free; Hermes guide: docs → Messaging → WhatsApp Cloud).
- **Rules:** replies are free-form for 24 hours after the customer's last message; starting a conversation after that needs an approved template.
- **Cost:** Meta charges per template message (marketing, utility, authentication; rates vary by country). Service replies inside the 24-hour window are currently free. Check Meta's current pricing page before deciding.
- **Setup effort:** 1 to 3 hours plus Meta review time.

## Route 2: Linked-device bridge (built in, unofficial)
- **What:** Hermes links to a WhatsApp account like WhatsApp Web does (scan a QR code).
- **Good for:** a quick internal channel, the owner or team talking to Hermes, low volume.
- **Ban risk:** real. It is not an official API; WhatsApp may restrict numbers that behave like bots (bulk messages, many new contacts, fast replies to strangers).
- **Needs:** a dedicated second number with WhatsApp Business on a spare phone (or an eSIM), kept online.
- **Cost:** free.
- **Setup effort:** 15 minutes (`hermes whatsapp`).

## Never
- Never connect the owner's main personal number or the main company number to Route 2.
- Never bulk-message or cold-message from either route without the owner's OK and proper opt-in.

## Recommendation
1. Owner ↔ Hermes: Telegram (already set up in step 2).
2. Team coordination (optional): Route 2 on a spare number, allow-listed to staff numbers only.
3. Client-facing WhatsApp: Route 1 on a dedicated company number when the owner is ready; Hermes drafts, owner approves sends until a standing OK exists for routine messages.
