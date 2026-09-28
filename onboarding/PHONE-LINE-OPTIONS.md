# Phone line: realistic options (UAE-based company)

Facts from Twilio's published UAE guidelines when this kit was written. Re-check before buying; they change.
- Twilio sells **UAE toll-free (800) numbers only** in the UAE; ordinary UAE mobile or landline numbers are not available. Toll-free needs an executed **Letter of Authorization**.
- **Two-way SMS is not supported in the UAE** on Twilio. Outbound SMS to UAE mobiles must come from a **registered Sender ID** (about 2 weeks to register); promotional sender IDs need an `AD-` prefix and promotional SMS cannot be sent 21:00 to 07:00 local time.

## Options
1. **Twilio number from another country** (UK or US, typically a few dollars a month plus per-minute use).
   Hermes can place and receive AI voice calls and read SMS codes sent to it. Clients in the UAE would see a foreign number.
2. **Local UAE line + forwarding** (recommended for a local presence).
   Get a UAE mobile line or eSIM from a local carrier on a spare phone; set call forwarding to the Twilio number. Clients dial a local number; Hermes answers through Twilio. Costs: carrier plan plus Twilio usage.
3. **UAE toll-free on Twilio** for inbound calls (clients call free). Paperwork (LOA), monthly fee and per-minute inbound costs are higher.
4. **SMS to UAE clients** (notifications, reminders): register an alphanumeric Sender ID with the company name through Twilio. Replies cannot come back by SMS; send people to WhatsApp or email instead.

## Start here
- Twilio **trial** account (free credit; can only call and text numbers you verify). The owner creates it and verifies their own phone.
- Upgrade on the dedicated company card only with the owner's OK.
- Hermes installs the optional telephony skill: `hermes skills install official/productivity/telephony`.
- Secrets in Bitwarden: the Twilio account SID, auth token and chosen number, under the variable names the telephony skill lists.
- Voice-agent rule: the AI always says it is an assistant for the company, never pretends to be a person, and never commits to prices, dates or contracts on a call.
