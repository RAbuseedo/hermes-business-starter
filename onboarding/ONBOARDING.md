# Owner onboarding script (for Hermes)

You (Hermes) follow this script with the owner, one step at a time, in their language (Arabic or English, whichever they write in). Load the `owner-onboarding` skill first; it has the rules for how to run each step.

How every step works:
- **Why:** one or two sentences, plain words.
- **You do:** exactly ONE action for the owner (a button, a sign-in, or one line to paste). Never two at once.
- **Hermes checks:** what you verify yourself before moving on. Say what you saw.
- Record progress in `~/.hermes/notes/onboarding/PROGRESS.md` (step, date, done/skipped/blocked, evidence). If the owner stops halfway, the next session resumes from there.
- Anything the owner must do later goes on their To-Do list (step 2 onward) with exact steps.
- Never ask for a password, card number, or code in chat. Secrets go into Bitwarden (step 3).
- A delegate (for example a family member helping) can do the clicking; the owner still approves money, accounts and anything on the SOUL hard-line list.

Before step 0: greet the owner, explain in three lines what the next hour looks like, and ask which language they prefer for briefs. Fill `{{BRIEF_LANGUAGE}}` in `~/.hermes/SOUL.md`.

---

## Step 0. Make the Mac a reliable office machine
**Why:** Hermes only works when the Mac is awake, online, and comes back by itself after a power cut.

Do these one by one (load `mac-keep-alive`):
1. **Never sleep on power.** You do: paste `sudo pmset -c sleep 0 disksleep 0 womp 1 autorestart 1` and type the Mac password when asked (nothing shows while typing; that is normal). Hermes checks: `pmset -g | grep -E ' sleep|autorestart'` shows `sleep 0` and `autorestart 1`.
2. **Start after a power cut.** You do: System Settings → Energy → turn on "Start up automatically after a power failure". Hermes checks: `pmset -g | grep autorestart` is 1.
3. **Log in automatically** (so Hermes starts after a restart). You do: System Settings → Users & Groups → Automatically log in as → this user. Note: macOS will not allow this while FileVault is on; see 4 and choose.
4. **FileVault (disk encryption).** Recommend ON for a machine that holds company mail and client files. Tradeoff: with FileVault on, after a power cut someone must type the password once at the Mac before Hermes restarts. Let the owner choose; record the choice. Hermes checks: `fdesetup status`.
5. **Background service.** Hermes runs `hermes gateway install` (if the installer did not already) and checks `hermes gateway status` shows running.
6. **Permissions.** When macOS asks to allow Terminal / Hermes access to files, contacts, calendars or screen, the owner clicks Allow only for what the step needs (load `macos-permissions` guidance in `mac-keep-alive`). Do not ask for Full Disk Access unless a later step needs it, and say why when it does.
7. **Remote help (optional).** Tailscale (free for personal use) lets a trusted helper reach this Mac if Telegram stops answering. Only with the owner's OK, and only the helpers the owner names.
8. **Updates.** Turn on automatic macOS security updates. Hermes itself is updated only when the owner asks (`hermes update`).

## Step 1. The AI brain (pay-as-you-go, with a cap)
**Why:** Hermes thinks with a paid AI model. The owner pays the provider directly and sets a monthly limit so there are no surprises.

The installer already asked for a provider. Now confirm and cap it:
- **Option A: Nous Portal** (made by the makers of Hermes, simple subscription, sign in with the browser). Good default.
- **Option B: OpenRouter** (pay per use, many models; set a credit limit on the key).
You do: open the provider's billing page, add the company card yourself, and set a monthly limit (suggest a starting cap and explain it: light use is usually tens of dollars a month; heavy daily use can be more). If OpenRouter: create a key with a credit limit, then store the key in Bitwarden in step 3 (until then `hermes model` keeps it in `.env`; move it after step 3).
Hermes checks: `hermes model` / a one-line test answer works; tell the owner which model is used for chat and suggest a cheaper model for scheduled jobs.

## Step 2. Telegram: the owner's line to Hermes
**Why:** Telegram is where the owner talks to Hermes from the phone, gets briefs, and sees the To-Do list.

1. You do: in Telegram, open **@BotFather** → `/newbot` → pick a name (for example "{{COMPANY}} Hermes") and a username ending in `bot`. Easiest route instead: `hermes dashboard` → Messaging → Telegram → **Create with QR**, which does this and fills the settings for you.
2. If done by hand: Hermes runs `hermes gateway setup` → Telegram and the owner pastes the bot token into that hidden prompt (not into chat). The gateway restricts the bot to the owner's Telegram user ID (and named delegates).
3. Hermes checks: the owner sends "hi" to the bot and gets a reply; `hermes gateway status` is running.
4. Topics (load `telegram-topics`): create **📰 Briefs**, **✅ To-Dos**, **👥 Clients**, **📦 Projects**, **💬 General**. Then `python3 ~/.hermes/starter/scripts/todos.py setup` creates the pinned To-Do list.
5. Voice notes: tell the owner they can send voice notes in Arabic or English; Hermes transcribes them.

## Step 3. Bitwarden: the company safe for passwords and keys
**Why:** Hermes must never keep passwords in chat or in plain files. The owner keeps them in Bitwarden; Hermes reads only what it needs, with one access token.

1. You do: create a free Bitwarden account at bitwarden.com (if you do not have one) and turn on two-step login.
2. You do: in the Bitwarden web app, switch to **Secrets Manager** (free tier is enough to start) → create an organization for the company → create a **Project** named `hermes`.
3. You do: **Machine accounts** → New → name it after this Mac → give it access to the `hermes` project: **Can read, write** (so Hermes can save passwords it generates, like the backup password) or **Can read** if you prefer to add every secret yourself → **Access tokens** → Create (no expiry, or 1 year) → keep the token on screen.
4. Hermes runs `hermes secrets bitwarden setup` and the owner pastes the token into the hidden prompt (region: US or EU, whichever the account uses).
5. Hermes checks: `hermes secrets bitwarden status` is OK and lists zero or more keys (names only).
6. From now on every secret goes into that project with the UPPER_CASE environment-variable name the tool expects (the provider's docs or `hermes model` show it). Move the AI key there now and remove it from `.env` once `status` shows it resolving. Load `secrets-intake` for the rules.
Also: the owner's own personal passwords can live in the normal Bitwarden password vault; Hermes never needs that vault.

## Step 4. A dedicated company card for Hermes subscriptions
**Why:** When Hermes needs a paid tool, the owner approves it and pays with a card that has a low limit, separate from the main company card. A leak or mistake is capped.

You do: create a virtual card at the company bank (most business banks and card providers offer virtual cards in their app), with a low monthly limit (for example the equivalent of 100 to 300 US dollars), labelled "AI & software".
Rules: the owner types card details only into each vendor's own billing page. Never in chat, never in a note, never in Bitwarden Secrets Manager. Hermes keeps a list of every subscription on this card in `~/.hermes/notes/subscriptions.md` (vendor, plan, monthly cost, renewal date, who approved) and reports it monthly.
Hermes checks: nothing to check technically. Record "card ready: yes/no, limit" in PROGRESS.md.

## Step 5. Google Workspace: mail, calendar, files
**Why:** Most client work arrives by email. Hermes reads, sorts, drafts replies, tracks what is waiting, and keeps the calendar straight.

1. Load the bundled `google-workspace` skill and follow its OAuth setup for the owner's own mailbox (Gmail, Calendar, Drive, Sheets, Docs). The owner signs in with the browser when asked (open a human window first with `chrome_gate.py human-start`).
2. As Workspace admin, the owner may need to allow the app: Admin console → Security → API controls → App access control. Give one click path, not a lecture.
3. Shared inboxes (for example info@ or sales@): recommended route is read access through a Google Group or delegation to the owner's mailbox, so Hermes uses one sign-in. Ask which shared inboxes matter.
4. Hermes checks: lists the last 5 subjects from the inbox and today's calendar events (subjects only, shown to the owner).
5. First triage (bundled `email-inbox-triage`): last 14 days, show the owner "needs reply" and "waiting on others". Read and draft only. Nothing is sent without the owner's OK.
6. Watchers: set up a scheduled check that flags client mail with no reply after one working day (goes into the brief).

## Step 6. WhatsApp
**Why:** Many clients and staff in the region use WhatsApp more than email.

Read `onboarding/WHATSAPP-OPTIONS.md` with the owner and help them choose. Summary:
- **Option 1: Official WhatsApp Business Cloud API on a NEW dedicated number.** No ban risk, fits government and larger clients, but needs a Meta Business account, business verification, a public webhook (Cloudflare Tunnel, free), and approved message templates to start conversations. Per-conversation fees from Meta.
- **Option 2: Linked-device bridge** (Hermes' built-in bridge, like WhatsApp Web) on a dedicated second number (WhatsApp Business app on a spare phone or eSIM). Quick and free, but unofficial: small risk the number gets restricted, so keep it conversational and never bulk-message.
- **Do not** connect the owner's main personal or main company number to the unofficial bridge.
- **Recommendation:** start with the Owner-to-Hermes channel on Telegram (done), use Option 2 on a spare number for internal team coordination only if wanted, and plan Option 1 for anything client-facing.
Hermes checks (after the chosen setup): the owner sends a test message and Hermes answers; unknown senders are ignored or queued, never answered freely.

## Step 7. A phone line (calls and SMS)
**Why:** A number Hermes can call from, receive calls on, or read SMS codes from.

Read `onboarding/PHONE-LINE-OPTIONS.md` with the owner. Key facts (checked against Twilio's published UAE guidelines when this kit was written; re-check before buying):
- Twilio offers **UAE toll-free (800) numbers only**, which need a signed Letter of Authorization. Regular UAE mobile/local numbers are not sold by Twilio.
- **Two-way SMS is not supported in the UAE** on Twilio. Sending SMS to UAE mobiles requires a pre-registered sender name (about 2 weeks), and promotional messages have time and content limits.
- Realistic options: (a) Twilio number from another country (UK or US) for an AI voice line and SMS codes abroad; (b) a UAE eSIM line from a local carrier on a spare phone, forwarded to the Twilio number, so clients dial a local number; (c) UAE toll-free on Twilio for inbound calls, with paperwork.
- Start with a **Twilio trial** (free credit, calls only to verified numbers), then upgrade on the company card with the owner's OK.
Hermes: install the optional `telephony` skill (`hermes skills install official/productivity/telephony`) when the owner is ready. Store the Twilio account SID and auth token in Bitwarden under the variable names the telephony skill lists. Checks: a test call to the owner's phone plays a short message.

## Step 8. Company profile (the interview)
**Why:** Hermes can only lead the company if it knows the company.

Load `company-profile`. First research quietly: the company website, LinkedIn page, Google Business profile, public social accounts. If `~/.hermes/starter/profiles/` has a seed for this company, read it (public facts only). Then interview the owner in short rounds (never more than 3 questions at a time):
1. Services, packages, typical prices and retainers, what is most profitable.
2. Clients: top 10 active clients (name, contact person, what we do for them, contract/retainer, renewal), government vs private.
3. Team: each employee's name, role, email, WhatsApp, who they report to, what they are working on. Mark each as staff, not principal.
4. Tools: project management, accounting/invoicing, design tools, AI creative tools, social schedulers, ad accounts (Meta, Google, TikTok, Snap, LinkedIn, X), website hosting and domain registrar, CRM, file storage, time tracking.
5. Money: how quotes and invoices are made, payment terms, who chases payments.
6. What the owner wants off their plate first.
Write `~/.hermes/notes/business-profile.md` (template in notes) and `~/.hermes/notes/team.md`, `~/.hermes/notes/clients/` (one file per client). Show a one-screen summary for the owner to correct.
Then fill the placeholders in `~/.hermes/SOUL.md` ({{OWNER_NAME}}, {{COMPANY}}, {{DELEGATES}}, times, work week) and show the owner the changed lines.

## Step 9. Accounts inventory
**Why:** Know every account the company has, which ones Hermes can use, and what is missing.

Go through `onboarding/ACCOUNTS-CHECKLIST.md` with the owner. For each: have / need / not needed. For "have": the owner stores the login or API key in Bitwarden (never in chat) and Hermes checks it works read-only. For "need": Hermes prepares the exact sign-up steps and cost, and puts it on the To-Do list; nothing paid is created without the owner's OK. Result: `~/.hermes/notes/accounts.md` (names, purpose, owner, where the secret lives by NAME, status). No secret values in that file.

## Step 10. Operating rhythm
**Why:** The value comes from Hermes running the routine every day without being asked.

Load `agency-ops` and `daily-briefs`. With the owner's OK create scheduled jobs (deliver to the Briefs topic):
- Morning brief {{BRIEF_MORNING}}, evening brief {{BRIEF_EVENING}}, working days.
- Weekly review on {{WEEKLY_REVIEW_DAY}}.
- Hourly inbox watch for client mail waiting a reply (silent unless something needs attention).
- Daily deliverables and approvals check; staff task follow-up (drafts reminders; sends only with the owner's standing OK).
- Weekly invoices and collections check; monthly subscriptions and renewals report.
Set up the client CRM (`client-crm`) and the project tracker (`agency-ops`). Hermes checks: `hermes cron list` shows the jobs; run the morning brief once now as a test.

## Step 11. Backup
**Why:** If the Mac dies, the company's Hermes memory, notes and settings come back in under an hour.

Load `backup-to-drive`. Encrypted backup with restic to a folder in the owner's Google Drive, nightly. The backup password is created by Hermes, shown once for the owner to put in Bitwarden **and** write on paper kept in the office safe. Hermes checks: first backup completes, then a test restore into a scratch folder matches. Report size and time.

## Step 12. First week goals
Agree with the owner on 3 to 5 concrete goals for week one, for example:
- Inbox under control: every client email answered or tracked.
- All active projects and deliverables in the tracker with dates and owners.
- Team task list for the week, with follow-ups drafted each morning.
- List of overdue invoices with drafted reminders.
- One content or proposal task done end to end (for example a bilingual social calendar for one client) to show the quality bar.
Write them to `~/.hermes/notes/OPEN-LOOPS.md` and report on them in every brief. On day 7, run the weekly review and ask the owner what to change.

Onboarding is complete when steps 0 to 5, 8, 10 and 11 are done or knowingly skipped. Tell the owner plainly what is done, what is waiting on them, and what Hermes will do tomorrow morning.
