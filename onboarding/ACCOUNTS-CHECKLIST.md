# Accounts checklist

Plain list of the accounts Hermes works with. For each: why, cost, who creates it. The owner creates every account and enters payment details personally; Hermes prepares the steps. Every login or key goes into Bitwarden Secrets Manager, never into chat.

## Core (needed in the first session)
- **AI model provider: Nous Portal or OpenRouter.** Why: Hermes' brain. Cost: paid, usage-based or subscription; set a monthly cap (light use often tens of US dollars a month). Who: owner, on the company AI card.
- **Telegram (owner's own account) + a bot from @BotFather.** Why: owner talks to Hermes, gets briefs and To-Dos. Cost: free. Who: owner (Hermes guides).
- **Bitwarden account + Secrets Manager organization.** Why: the safe for every password and key. Cost: free tier is enough to start. Who: owner.
- **Dedicated virtual company card (low limit).** Why: pay for approved tools with a capped card. Cost: bank dependent, usually free. Who: owner at the bank.
- **Google Workspace (existing).** Why: mail, calendar, Drive, Sheets, Docs. Cost: already paid. Who: owner signs in; as admin may need to allow the app.
- **Apple ID on the Mac.** Why: macOS updates, iCloud optional. Cost: free. Who: owner.

## Communication
- **WhatsApp Business Cloud API (Meta Business account, verified).** Why: official client-facing WhatsApp. Cost: Meta per-template-message fees; service replies within 24h currently free. Who: owner (business verification needs the trade licence).
- **Spare phone number for WhatsApp (optional).** Why: linked-device bridge for internal use without risking the main number. Cost: a prepaid SIM or eSIM. Who: owner.
- **Twilio.** Why: phone line for AI calls and SMS. Cost: free trial credit, then pay-as-you-go plus number rental. Who: owner creates and upgrades with OK.
- **UAE mobile line or eSIM for forwarding (optional).** Why: a local number clients recognise, forwarded to Twilio. Cost: carrier plan. Who: owner.
- **Cloudflare account (free).** Why: secure public webhook tunnel for WhatsApp Cloud. Cost: free. Who: owner, Hermes guides.

## Company tools (have / need, found during step 8)
- **Project management** (Asana, ClickUp, Monday, Trello, Notion, or Sheets). Why: projects and deliverables. Cost: varies. Who: existing, owner grants Hermes read access first.
- **Accounting / invoicing** (Zoho Books, QuickBooks, Xero, Odoo, Tally). Why: invoices and collections tracking. Cost: existing. Who: owner grants read-only access.
- **Design and video suite** (Adobe Creative Cloud, Canva, Figma, CapCut). Why: where the team produces work; Hermes reads briefs and tracks status. Cost: existing. Who: team.
- **Higgsfield (higgsfield.ai).** Why: AI video and image generation for creative production. Status: have (confirm plan and who uses it). Cost: app subscription is existing; the developer API is billed from a separate prepaid balance. Who: owner creates an API key only if they want Hermes to generate drafts (stored in Bitwarden as `HIGGSFIELD_KEY_ID` / `HIGGSFIELD_KEY_SECRET`).
- **Social media schedulers** (Meta Business Suite, Hootsuite, Buffer, Later, Sprout). Why: content calendars. Cost: existing. Who: owner decides whether Hermes may schedule (default: no).
- **Ad accounts** (Meta, Google Ads, TikTok, Snapchat, LinkedIn, X). Why: read-only performance reporting. Cost: free access. Who: owner adds Hermes' reporting user or token with read-only role.
- **Website hosting and domain registrar.** Why: renewals, DNS, uptime. Cost: existing. Who: owner.
- **CRM** (HubSpot, Zoho CRM, Pipedrive) if used. Why: client master data. Cost: existing. Who: owner grants read access.
- **E-signature** (DocuSign, Adobe Sign, Zoho Sign) if used. Why: tracking contract status. Hermes never signs. Who: owner.

## Safety and continuity
- **Google Drive folder for encrypted backups.** Why: restore the Mac's Hermes in under an hour. Cost: uses Workspace storage. Who: owner signs in once.
- **Tailscale (optional, free for personal use).** Why: trusted remote help if the Mac stops answering. Who: owner, with named helpers only.
