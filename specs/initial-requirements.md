# KhataMitra — Initial Requirements

> **Version**: 1.0 (April 2026)
> **Audience**: Engineering, design, and product stakeholders.
> **Status**: Draft — subject to revision before v1 release.

---

## 1. Overview

KhataMitra ("ledger friend" in Hindi/Urdu) is a mobile-first bookkeeping app for small business owners in India who manage credit and debit transactions with customers (udhaari). The app replaces physical ledger books with a digital, offline-capable register that supports multiple languages and works reliably on low-end Android devices.

**Target users**: Kirana shop owners, street vendors, small traders, and self-employed professionals who extend short-term credit to regular customers.

**Primary job to be done**: Track who owes how much, and collect or settle debts quickly without requiring literacy in English or internet connectivity.

---

## 2. Scope

### In scope (v1)
- **Authentication**: mandatory phone number login with OTP verification
- **Runtime permissions**: contextual, non-dismissible rationale flow (PhonePe-style) for contacts, notifications, and SMS
- **Image catalog**: in-app asset library for reminder attachments; no gallery/camera permissions needed
- Customer management (add, edit, archive)
- Transaction recording (credit given / payment received)
- Per-customer ledger (balance, history)
- Business summary dashboard (total receivable, total payable)
- SMS / WhatsApp reminder for outstanding balances
- Multi-language UI: English, Hindi, Telugu
- Offline-first operation with local persistence
- Light and dark theme

### Deferred to v2
- Google / social sign-in
- Multi-user / team accounts
- Cloud sync or backup
- GST / invoice generation
- Bank account integration
- Analytics or reports beyond simple summaries
- Web or desktop targets

---

## 3. Functional Requirements

### 3.1 Authentication

| ID | Requirement |
|----|-------------|
| F-AU-01 | Login is mandatory. An unauthenticated user cannot access any app screen beyond the login flow. |
| F-AU-02 | v1 supports phone number + OTP only. Google sign-in is explicitly deferred to v2. |
| F-AU-03 | Login is a **single screen** (`/login`) using progressive disclosure. Initially only the phone number field is visible. |
| F-AU-04 | Phone number field accepts a 10-digit Indian mobile number (no country code picker in v1; +91 is assumed). "Send OTP" button is disabled until exactly 10 digits are entered. |
| F-AU-05 | On "Send OTP" tap, an OTP is dispatched via SMS. On success, the OTP input section animates in on the same screen (e.g. `AnimatedSize` slide-in); the phone field remains visible above it. The OTP input is auto-focused immediately. |
| F-AU-06 | OTP input section: a 6-digit code field with auto-advance between digit cells. |
| F-AU-07 | OTP expires after 5 minutes. A countdown timer is shown below the OTP field. A "Resend OTP" link appears alongside the OTP field and is disabled for the first 30 seconds, then becomes active. |
| F-AU-08 | On successful OTP verification, persist the session locally so the user is not asked to log in again on subsequent launches. |
| F-AU-09 | On failed OTP (wrong code): show an inline error below the digit cells and allow retry. After 3 consecutive failures, block further attempts for 10 minutes and show a clear message with the remaining lockout time. |
| F-AU-10 | The user can clear the phone number field (or tap an edit icon next to it) while the OTP section is visible to re-enter their number; doing so resets the OTP state and hides the OTP section. |
| F-AU-11 | Sign out: available from Settings. Clears the local session; next launch shows the login screen. Sign-out does NOT delete local data. |
| F-AU-12 | The authenticated phone number is stored locally and never transmitted to analytics or crash reporters. |

### 3.2 Onboarding

The first-launch onboarding flow has four steps, in order:

1. **Language selection** — user picks their preferred language (EN / HI / TE).
2. **Business name entry** — user enters their shop / business name.
3. **Theme selection** — user picks Light, Dark, or System Default.
4. **Feature tour** — a skippable 3-screen walkthrough of core features.

| ID | Requirement |
|----|-------------|
| F-ON-01 | On first launch (after login), begin the onboarding flow with the Language Selection screen. |
| F-ON-02 | Language selection is mandatory; the user cannot proceed without choosing one of EN / HI / TE. The selected language takes effect immediately and is persisted via `SharedPreferences`. |
| F-ON-03 | After language selection, show the Business Name screen. The business name is mandatory; the user cannot proceed without entering one. |
| F-ON-04 | After business name entry, show the Theme Selection screen. The user chooses Light, Dark, or System Default. The choice takes effect immediately and is persisted. |
| F-ON-05 | After theme selection, show a brief (skippable) 3-screen feature tour. The three slides are: (1) "Track every rupee", (2) "Send reminders easily", (3) "Your data, always safe". |
| F-ON-06 | The feature tour has "Next" and "Skip" buttons. Tapping "Skip" on any slide, or "Get Started" on the final slide, completes onboarding and navigates to the Dashboard. |
| F-ON-07 | On subsequent launches, skip the entire onboarding flow and go directly to the Dashboard. |

### 3.3 Runtime Permissions

KhataMitra requires three runtime permissions — **Contacts**, **Notifications**, and **SMS** — each tied to a specific feature. The permission model follows a lazy, contextual, non-dismissible rationale pattern (as used by PhonePe and Google Pay): permissions are never pre-requested in bulk at launch; instead, the rationale sheet appears exactly once, at the moment the feature is first needed.

#### 3.3.1 Permission Types and Trigger Points

| Permission | Android declaration | When requested | Feature gated |
|------------|-------------------|----------------|---------------|
| READ_CONTACTS | `READ_CONTACTS` | First tap of "Add Customer" → "Import from contacts" | Contact picker for customer name/phone pre-fill |
| POST_NOTIFICATIONS | `POST_NOTIFICATIONS` (Android 13+ / API 33+); auto-granted on API ≤ 32 | After first successful transaction record | Payment reminder push notifications (v2 prep) |
| SEND_SMS | `SEND_SMS` | First tap of "Send via SMS" in Reminder Composer | Direct SMS dispatch (text only) |
| CAMERA | `CAMERA` | First tap of "Take a photo" on the Catalog screen | Capture new catalog image |
| Media / Gallery | `READ_MEDIA_IMAGES` (Android 13+) / `READ_EXTERNAL_STORAGE` (≤ Android 12) | First tap of "Pick from gallery" on the Catalog screen | Import image from device library into catalog |

#### 3.3.2 Permission Flow — States and Transitions

| ID | Requirement |
|----|-------------|
| F-PM-01 | **Lazy trigger**: never request a permission at app launch or during onboarding. Request only at the moment the user initiates the feature that needs it. |
| F-PM-02 | **Rationale sheet**: before calling the OS permission dialog, show a non-dismissible bottom sheet explaining why the permission is needed and what happens without it. The sheet has two buttons: "Allow" (proceeds to OS dialog) and "Not now" (denies, degrades feature gracefully). |
| F-PM-03 | The rationale sheet cannot be dismissed by tapping outside or swiping down. The user must explicitly choose "Allow" or "Not now". |
| F-PM-04 | **Granted**: proceed with the feature immediately; do not show the rationale sheet again for this permission. |
| F-PM-05 | **Denied (first time / can ask again)**: show the rationale sheet again on the user's next attempt to use the feature. |
| F-PM-06 | **Permanently denied (blocked)**: the "Allow" button on the rationale sheet changes to "Open Settings". Tapping it opens the OS app settings page. After the user returns to the app, re-check the permission status with a 300 ms delay before continuing. |
| F-PM-07 | **Feature degradation — Contacts**: if permission is denied/blocked, the "Import from contacts" option is hidden; the user can still add a customer by typing name and phone manually. |
| F-PM-08 | **Feature degradation — Notifications**: if denied/blocked, in-app reminders still work; push notifications are silently disabled with no error shown to the user. |
| F-PM-09 | **Feature degradation — SMS**: if denied/blocked, "Send Reminder" falls back to the system share sheet only; the direct SMS option is hidden. |
| F-PM-10 | **Feature degradation — Camera / Gallery**: if denied/blocked on the Catalog screen, the corresponding "Take photo" or "Pick from gallery" option is hidden; the other option remains available. |
| F-PM-11 | Permission status is never cached across app restarts; always read from the OS on each launch to reflect changes made in device Settings. |

#### 3.3.3 Rationale Sheet Content

Each permission has a distinct rationale. Content must be localized (EN / HI / TE).

| Permission | Title | Body |
|------------|-------|------|
| Contacts | "Find customers faster" | "Allow KhataMitra to read your contacts so you can add customers by picking from your phonebook instead of typing." |
| Notifications | "Stay on top of payments" | "Allow notifications so KhataMitra can remind you when a customer's balance goes overdue." |
| SMS | "Send reminders directly" | "Allow KhataMitra to send SMS so you can remind customers of outstanding balances without leaving the app." |
| Camera | "Add photos to your catalog" | "Allow camera access so you can photograph products or offers and save them to your image catalog." |
| Gallery | "Import photos to your catalog" | "Allow KhataMitra to read your photos so you can pick existing images and save them to your catalog." |

### 3.4 Dashboard


| ID | Requirement |
|----|-------------|
| F-DA-01 | Show total outstanding receivable (you will receive) and total outstanding payable (you owe) at the top of the screen. |
| F-DA-02 | List all customers sorted by most recent transaction date (descending). |
| F-DA-03 | Each customer row shows: name, net balance (color-coded green = they owe you, red = you owe them), and last transaction date. |
| F-DA-04 | A search bar filters the customer list by name in real time. |
| F-DA-05 | A floating action button (FAB) opens the Add Customer screen. |
| F-DA-06 | Tapping a customer row navigates to that customer's Ledger screen. |
| F-DA-07 | Empty state: when no customers exist, show an illustration and a prompt to add the first customer. |

### 3.5 Customer Management

| ID | Requirement |
|----|-------------|
| F-CM-01 | Add customer form fields: name (required), phone number (optional). |
| F-CM-02 | Phone numbers are stored locally and never sent to any external server or analytics service. |
| F-CM-03 | Duplicate detection: warn (not block) if a customer with the same name already exists. |
| F-CM-04 | Edit customer: name and phone number can be updated at any time. |
| F-CM-05 | Archive customer: hides customer from the active list but retains all transaction history. |
| F-CM-06 | Archived customers are accessible via a dedicated "Archived" filter or section. |
| F-CM-07 | Delete customer: permanently removes customer and all associated transactions; requires explicit confirmation dialog. |

### 3.6 Transaction Recording

| ID | Requirement |
|----|-------------|
| F-TX-01 | Two transaction types: **Credit** (you gave goods/money to the customer — they owe you more) and **Payment** (customer paid you — their balance decreases). |
| F-TX-02 | Transaction form fields: amount (required, numeric), note/description (optional, max 200 chars), date (defaults to today, editable). |
| F-TX-03 | Amount must be a positive number greater than zero. Decimal values up to 2 places are allowed (e.g., ₹ 49.50). |
| F-TX-04 | Currency is always INR (₹). No multi-currency support in v1. |
| F-TX-05 | A transaction is saved immediately on confirmation; no draft state. |
| F-TX-06 | Edit transaction: amount, note, and date can be edited after creation. |
| F-TX-07 | Delete transaction: requires confirmation; recomputes the customer balance after deletion. |
| F-TX-08 | Transaction timestamps are stored in local device time. |

### 3.7 Customer Ledger

| ID | Requirement |
|----|-------------|
| F-LG-01 | Show customer name, phone number, and current net balance at the top. |
| F-LG-02 | List all transactions in reverse chronological order. |
| F-LG-03 | Each transaction row shows: date, type indicator (credit / payment), amount, note (if any), running balance after this transaction. |
| F-LG-04 | Color code: credit transactions in red (money owed to you increased), payment transactions in green (balance decreased). |
| F-LG-05 | Two action buttons: "Credit" and "Payment" to add a new transaction directly from this screen. |
| F-LG-06 | Long-press (or swipe) on a transaction row reveals Edit and Delete actions. |
| F-LG-07 | Empty state: when no transactions exist for a customer, show a prompt to record the first transaction. |
| F-LG-08 | A "Send Reminder" button opens the Reminder Composer (§3.8) pre-filled with the customer's name and current balance. |

### 3.8 Send Reminder

The reminder composer is a full-featured, customisable message builder — not a one-shot share sheet. The user constructs the message before it leaves the app.

#### 3.8.1 Reminder Composer

| ID | Requirement |
|----|-------------|
| F-SR-01 | Tapping "Send Reminder" opens the in-app Reminder Composer screen (full screen or tall bottom sheet). |
| F-SR-02 | The composer has three content blocks that can each be toggled on/off independently: **Text message**, **Attachment image**, **Visiting card**. |
| F-SR-03 | The text block is pre-filled with a localized template: "Hi [customer name], your outstanding balance at [business name] is ₹[amount]. Please pay at your earliest convenience." The user can edit the full text freely. |
| F-SR-04 | The message template uses named placeholders (`{customerName}`, `{businessName}`, `{amount}`) that are substituted at render time; the user sees the resolved values, not the raw placeholders. |
| F-SR-05 | A live preview panel shows exactly what the recipient will receive (text + any attached image) before the user sends. |
| F-SR-06 | The user can save a customised text template per-customer or as the global default, replacing the built-in template for future reminders. |
| F-SR-07 | No message or attachment is sent automatically; the user always taps a final "Send" button. |

#### 3.8.2 Attachment — Image from Catalog

The app maintains an in-app image catalog (see §3.10) that the business owner keeps up to date. All reminder image attachments are chosen from this catalog — no gallery or camera permission is ever required for the reminder flow.

| ID | Requirement |
|----|-------------|
| F-SR-08 | When the image block is enabled, the user sees a grid of images from their catalog and selects one. |
| F-SR-09 | Multi-select is supported: the user can attach up to 3 catalog images in a single reminder. |
| F-SR-10 | Selected images are shown as thumbnails in the composer preview. The user can deselect any image before sending. |
| F-SR-11 | If the catalog is empty, the image block shows an "Add images to your catalog" prompt that navigates to the Catalog screen. |
| F-SR-12 | No gallery, camera, or storage permission is requested during the reminder flow; all images come from the app-managed catalog. |

#### 3.8.3 Visiting Card

| ID | Requirement |
|----|-------------|
| F-SR-13 | The visiting card is a system-generated image rendered from the business profile: business name, owner phone number, and an optional tagline. |
| F-SR-14 | A default card template is provided. The user can customise: background colour (from a curated palette), font style (2 options), and whether to show the phone number. |
| F-SR-15 | Visiting card settings are stored in the business profile and persist across sessions; the card does not need to be reconfigured per reminder. |
| F-SR-16 | The visiting card is rendered as a PNG image at 800 × 400 px before being passed to the share layer. |
| F-SR-17 | A dedicated "Edit visiting card" shortcut is available in Settings → Business Profile (in addition to the composer). |

#### 3.8.4 Send Channel

| ID | Requirement |
|----|-------------|
| F-SR-18 | The "Send" button opens the OS share sheet with the composed text and any attached files (catalog images and/or visiting card PNG). The user chooses the app (WhatsApp, SMS, Telegram, etc.) from the share sheet. |
| F-SR-19 | WhatsApp direct share: if WhatsApp is installed, show it as a prominent quick-action above the share sheet alongside the generic share option. |
| F-SR-20 | SMS fallback: if `SEND_SMS` permission is granted, offer a "Send via SMS" quick-action (text only; images are not included in SMS). If the permission is denied, this quick-action is hidden per §3.3.2 F-PM-09. |
| F-SR-21 | Catalog image files are copied to a cache-scoped temporary path before being passed to the share intent, and the temp copies are deleted after the share completes. The originals in the catalog are never moved or deleted by the share flow. |

### 3.9 Settings

| ID | Requirement |
|----|-------------|
| F-ST-01 | Business name: editable at any time. |
| F-ST-02 | Language: choose from English, Hindi, Telugu; persisted across sessions. |
| F-ST-03 | Theme: Light, Dark, or System default; persisted across sessions. |
| F-ST-04 | About section: app version, developer info, open-source licences link. |

### 3.10 Image Catalog

The catalog is the business owner's personal asset library — a place to store product photos, offer banners, and any other images they want to reuse across reminders.

#### 3.10.1 Catalog Screen

| ID | Requirement |
|----|-------------|
| F-CA-01 | The Catalog screen is accessible from the bottom navigation bar (or main menu) as a top-level destination. |
| F-CA-02 | Images are displayed in a 3-column grid, sorted by date added (most recent first). |
| F-CA-03 | Each image tile shows a thumbnail; long-press reveals a context menu with "Rename" and "Delete". |
| F-CA-04 | Empty state: show an illustration and an "Add your first image" prompt. |
| F-CA-05 | An "Add" FAB (or toolbar button) lets the user add images to the catalog (see §3.10.2). |

#### 3.10.2 Adding Images to the Catalog

| ID | Requirement |
|----|-------------|
| F-CA-06 | Tapping "Add" presents two options: **Pick from gallery** and **Take a photo**. |
| F-CA-07 | Gallery and camera permissions are requested here — once, with the contextual rationale flow defined in §3.3 — not during the reminder flow. |
| F-CA-08 | Supported formats: JPEG, PNG. Images larger than 5 MB are compressed on import (target ≤ 1 MB) before being stored in app-private storage. |
| F-CA-09 | On successful import, the image is stored in the app's internal storage under a dedicated catalog directory; it is never written to the device gallery. |
| F-CA-10 | The user can add up to 50 images in v1. Attempting to exceed this limit shows a clear message. |

#### 3.10.3 Managing Catalog Images

| ID | Requirement |
|----|-------------|
| F-CA-11 | Rename: the user can give each image a short label (max 60 chars) to find it easily in the composer. |
| F-CA-12 | Delete: removes the image file from app-private storage after a confirmation prompt. If the image was used in a past reminder, that history is unaffected (the reminder record stores the text only). |
| F-CA-13 | Multi-select delete: the user can select multiple images and delete them in one action. |

---

## 4. Non-Functional Requirements

### 4.1 Performance

| ID | Requirement |
|----|-------------|
| NF-PE-01 | App cold-start to interactive Dashboard in under 2 seconds on a mid-range device (4 GB RAM, Android 10). |
| NF-PE-02 | Scrolling through a list of 500+ customers must maintain 60 fps on the same device. |
| NF-PE-03 | Transaction save (local write) must complete within 300 ms. |
| NF-PE-04 | No frame drops during language toggle or theme switch. |

### 4.2 Offline / Reliability

| ID | Requirement |
|----|-------------|
| NF-OF-01 | All read and write operations must function without any network connectivity. |
| NF-OF-02 | Data must survive app process kill, device restart, and OS-level storage compaction. |
| NF-OF-03 | No data loss on crash during a write (use transactional DB writes). |

### 4.3 Security & Privacy

| ID | Requirement |
|----|-------------|
| NF-SE-01 | No customer names, phone numbers, or financial figures are sent to any remote service (analytics, crash reporting, logging). |
| NF-SE-02 | Local database must not be world-readable; use Android's app-private storage. |
| NF-SE-03 | No network permissions are declared in the Android manifest beyond what the OS share sheet requires. |

### 4.4 Accessibility

| ID | Requirement |
|----|-------------|
| NF-AC-01 | All interactive elements (buttons, list items, FABs) meet the 48 × 48 dp minimum touch target. |
| NF-AC-02 | All icon-only controls have a `semanticsLabel` for screen readers. |
| NF-AC-03 | Color is never the sole means of conveying information (e.g., credit/payment must also use a label or icon). |
| NF-AC-04 | App passes Flutter accessibility checks (`flutter test --enable-accessibility-semantics`). |

### 4.5 Localization

| ID | Requirement |
|----|-------------|
| NF-LO-01 | All user-visible strings are externalized to `.arb` files; no hard-coded English strings in widget code. |
| NF-LO-02 | Number formatting uses locale-aware formats (e.g., Indian numbering system for HI/TE). |
| NF-LO-03 | Date formatting uses locale-aware short date formats. |
| NF-LO-04 | RTL layout is not required in v1 (no RTL languages supported). |

### 4.6 Platform Support

| ID | Requirement |
|----|-------------|
| NF-PL-01 | Primary target: Android (API 21+). |
| NF-PL-02 | iOS builds must compile and pass CI without crash on launch, but UI/UX parity with Android is not required for v1. |
| NF-PL-03 | Tablet layout (≥ 600 dp width) must use the two-column responsive grid defined in `lib/core/responsive/`. |

### 4.7 Testing

| ID | Requirement |
|----|-------------|
| NF-TE-01 | Every Riverpod provider must have unit tests using `ProviderContainer`. |
| NF-TE-02 | Every screen must have at least one widget smoke test verifying it renders without error. |
| NF-TE-03 | Line coverage on new code must not fall below 80%. |
| NF-TE-04 | `dart analyze` must report zero issues (warnings and hints included) before any merge to `main`. |

---

## 5. Edge & Corner Cases

This section is exhaustive. Every scenario here must have a corresponding test or be explicitly handled in code. "Handled" means the user sees a clear, localised message and the app remains in a consistent state — never a blank screen, spinner stuck forever, or silent failure.

---

### 5.1 Network

| ID | Scenario | Required behaviour |
|----|----------|--------------------|
| EC-NW-01 | **Network lost mid-OTP send** — user taps "Send OTP" and connectivity drops before the SMS is dispatched. | Show inline error: "Could not send OTP. Check your connection and try again." Button returns to enabled state. No spinner stuck. |
| EC-NW-02 | **Network lost mid-OTP verify** — user enters code and connectivity drops before the server responds. | Show inline error: "Verification failed. Check your connection and try again." OTP entry is preserved; failure counter is NOT incremented (network error ≠ wrong code). |
| EC-NW-03 | **Network restored after OTP screen was shown offline** — user navigates back, fixes connectivity, and retries. | Full retry works; no stale state from previous failed attempt. |
| EC-NW-04 | **App is fully offline after login** — all local reads and writes work normally. | No connectivity banner, no degraded state — the app is fully functional offline. Only OTP send/verify requires network; everything else does not. |
| EC-NW-05 | **Connectivity toggled rapidly** (e.g. entering and leaving a tunnel) while OTP countdown is running. | Countdown timer continues unaffected. No duplicate OTP request fires. |
| EC-NW-06 | **OTP SMS not delivered** (carrier failure, DND filter) — user never receives the code. | Countdown expires; "Resend OTP" becomes active after 30 s. User can resend up to 3 times before the app shows "Having trouble? Check your number or try again later." |

---

### 5.2 Authentication & Session

| ID | Scenario | Required behaviour |
|----|----------|--------------------|
| EC-AU-01 | **App backgrounded during OTP countdown** — user switches away and returns. | Countdown timer reflects elapsed real time (use wall-clock delta, not a paused ticker). Timer state is not reset on resume. |
| EC-AU-02 | **App killed during OTP countdown** — process is killed and relaunched. | Return to phone entry screen; OTP state is discarded. Session is not persisted until verification succeeds. |
| EC-AU-03 | **Secure storage read fails on launch** (corrupted entry, OS keystore error). | Treat as unauthenticated; show login screen. Log the error locally (no PII in log). Do not crash. |
| EC-AU-04 | **Secure storage write fails after OTP success** — session cannot be persisted. | Show error: "Couldn't save your session. Please try again." Do not navigate to the app. |
| EC-AU-05 | **OTP lockout clock tampered** — system time changed forward while locked out. | Use wall-clock monotonic time (`DateTime.now()`) stored at lockout start; if elapsed ≥ 10 min allow retry; otherwise keep locked. |
| EC-AU-06 | **User signs out while a transaction save is in progress** (race condition). | Complete the in-flight write first; then clear session and navigate to login. Never cancel a DB write mid-transaction. |
| EC-AU-07 | **Same phone number used on a new device install** — previous local data is gone. | New local database is created. No data migration is attempted. User sees empty onboarding. This is expected behaviour in v1 (no cloud backup). |

---

### 5.3 Onboarding

| ID | Scenario | Required behaviour |
|----|----------|--------------------|
| EC-ON-01 | **App killed mid-onboarding** — process killed after business name was typed but before "Continue" was tapped. | Business name not saved; on relaunch resume from the business name screen (language already saved, onboarding not complete). |
| EC-ON-02 | **Business name save fails** (DB write error). | Show error below the field: "Couldn't save. Try again." Do not navigate forward. |
| EC-ON-03 | **Business name is only whitespace** — user types spaces and taps Continue. | Treat as empty; disable/block Continue. Trim before validation. |
| EC-ON-04 | **Business name exceeds reasonable length** — e.g. 200+ characters. | Cap input at 100 characters. Show character counter at 80+. |
| EC-ON-05 | **App killed after language was saved but before business name was entered**. | On relaunch, skip language selection (already persisted) and resume from business name screen. |
| EC-ON-06 | **App killed after theme was saved but before tour was shown**. | On relaunch, skip language + business name + theme steps (all persisted) and resume from the feature tour. |
| EC-ON-07 | **Theme preference write fails** during onboarding. | Continue with the in-memory theme; show no error (non-critical). On next launch, system default is used. Onboarding still advances. |

---

### 5.4 Customer Management

| ID | Scenario | Required behaviour |
|----|----------|--------------------|
| EC-CM-01 | **Add customer — name is only whitespace**. | Trim before save; treat as empty; show validation error. |
| EC-CM-02 | **Add customer — phone number is invalid** (e.g. 7 digits, letters mixed in). | Show inline error: "Enter a valid 10-digit mobile number." Do not save. |
| EC-CM-03 | **Duplicate name** — exact match (case-insensitive) with an existing active customer. | Show non-blocking warning snackbar: "A customer named [name] already exists." Allow save. |
| EC-CM-04 | **DB write fails on customer save**. | Show error snackbar: "Couldn't save customer. Try again." Sheet stays open; data not lost. |
| EC-CM-05 | **Edit customer while a transaction for that customer is being saved** (race). | DB transaction for the customer edit queues behind the in-flight write; no deadlock; both succeed. |
| EC-CM-06 | **Archive customer with outstanding non-zero balance**. | Warn in confirmation dialog: "This customer has an outstanding balance of ₹[amount]. Archive anyway?" Two buttons: "Archive" and "Cancel". |
| EC-CM-07 | **Delete customer — confirmation dialog dismissed** (back button / outside tap). | Customer is NOT deleted. State unchanged. |
| EC-CM-08 | **Delete customer DB write fails**. | Show error: "Couldn't delete customer. Try again." Customer remains. |
| EC-CM-09 | **Import from contacts — contact has no phone number**. | Pre-fill name only; phone field left empty. |
| EC-CM-10 | **Import from contacts — contact has multiple phone numbers**. | Show a picker within the contact picker flow for the user to choose one number. |
| EC-CM-11 | **Import from contacts — contact name is longer than 100 chars**. | Truncate to 100 chars; user can edit before saving. |

---

### 5.5 Transactions

| ID | Scenario | Required behaviour |
|----|----------|--------------------|
| EC-TX-01 | **Amount field — non-numeric input** (paste of text, special characters). | Field rejects non-numeric characters. Paste is sanitised. |
| EC-TX-02 | **Amount is zero or negative**. | Validation error: "Amount must be greater than ₹0." Save button stays disabled. |
| EC-TX-03 | **Amount has more than 2 decimal places** (e.g. ₹12.999). | Truncate or round to 2dp on save. Show no error — silent normalisation. |
| EC-TX-04 | **Very large amount** (e.g. ₹99,99,99,999). | Accept up to 8 digits before the decimal. Amounts beyond ₹9,99,99,999 show validation error: "Amount is too large." |
| EC-TX-05 | **Transaction date set to the future**. | Allowed — no validation restriction. Some businesses pre-record future dues. |
| EC-TX-06 | **DB write fails on transaction save**. | Sheet stays open; show error snackbar: "Couldn't save transaction. Try again." Balance not updated. |
| EC-TX-07 | **Transaction deleted — balance recompute fails** (DB error). | Show error: "Couldn't delete. Try again." Transaction remains. Balance unchanged. |
| EC-TX-08 | **Edit transaction changes type** (e.g. credit → payment). | Re-derive balance from scratch after save (sum query, not delta). Never apply delta on top of delta. |
| EC-TX-09 | **Customer has 0 transactions — balance shown**. | Show ₹0 with neutral `AppBadge`, not a negative or error state. |
| EC-TX-10 | **Rapid-fire taps on "Save" button** — double-submit. | Disable Save button immediately on first tap; re-enable only on error. Exactly one write per tap sequence. |

---

### 5.6 Reminder Composer

| ID | Scenario | Required behaviour |
|----|----------|--------------------|
| EC-SR-01 | **Share sheet not available** (no apps installed, OS restriction). | Show error snackbar: "No apps available to share. Please install WhatsApp or SMS." |
| EC-SR-02 | **WhatsApp not installed** — WhatsApp quick-action is shown. | Hide WhatsApp quick-action; show generic share only. Check with `canLaunchUrl` before rendering the button. |
| EC-SR-03 | **Catalog image file missing from disk** (deleted externally, storage cleared). | Remove the orphaned DB row silently on discovery. Show snackbar: "One image was removed from your catalog." Reopen composer without it. |
| EC-SR-04 | **Temp file creation fails** before share intent (storage full, permission revoked). | Show error: "Couldn't prepare files for sharing. Check your storage." Do not invoke share sheet with incomplete payload. |
| EC-SR-05 | **User selects 3 catalog images + visiting card** — large payload. | Compress visiting card PNG to ≤ 500 KB before attaching. Proceed normally. |
| EC-SR-06 | **User edits text template to empty string**. | "Send" button disabled when text block is on but text is empty. |
| EC-SR-07 | **User toggles all three content blocks off**. | "Send" button disabled. Show helper text: "Turn on at least one content block to send." |
| EC-SR-08 | **Share sheet dismissed by user without sending** (swipes down, presses back). | Temp files are still cleaned up. Composer stays open. No error shown. |
| EC-SR-09 | **Customer balance is ₹0 when reminder is composed**. | Placeholder `{amount}` resolves to "₹0". Allow sending — user may be confirming settlement. |

---

### 5.7 Image Catalog

| ID | Scenario | Required behaviour |
|----|----------|--------------------|
| EC-CA-01 | **Import — picked image is corrupt / unreadable**. | Show error: "Couldn't import this image. Try a different one." No partial file left on disk. |
| EC-CA-02 | **Import — compression fails** (low memory, codec error). | Fall back to saving the original if ≤ 5 MB; otherwise show error: "Image too large to import." |
| EC-CA-03 | **Import — storage full**. | Show error: "Not enough storage. Free up space and try again." No partial file written. |
| EC-CA-04 | **50-image cap reached** — user taps "Add". | Show error: "Catalog is full (50/50). Delete some images to add more." FAB remains visible but shows the error on tap. |
| EC-CA-05 | **Rename — new label is only whitespace**. | Treat as empty; show validation error in the rename dialog: "Label cannot be empty." |
| EC-CA-06 | **Delete — image file already gone from disk** (cleared externally). | Delete DB row anyway; show no error to user (silent cleanup). |
| EC-CA-07 | **Multi-select delete — DB fails mid-batch**. | Use a single DB transaction for the batch; roll back entirely on failure. Show error: "Couldn't delete images. Try again." No partial deletion. |
| EC-CA-08 | **App backgrounded mid-import** (user switches away while camera/gallery is open). | Import completes normally on return (handled by `ImagePicker` callbacks). No duplicate import. |
| EC-CA-09 | **Camera permission revoked from OS settings between sessions**. | On next tap of "Take a photo", `permissionStatusProvider` reads fresh status → blocked → show rationale sheet with "Open Settings". |

---

### 5.8 Permissions

| ID | Scenario | Required behaviour |
|----|----------|--------------------|
| EC-PM-01 | **OS permission dialog dismissed without choosing** (some Android versions allow this). | Treat as denied; re-show rationale on next attempt. Do not increment a "denied" counter. |
| EC-PM-02 | **Permission granted, then revoked from OS settings while app is in background**. | On resume, `permissionStatusProvider` re-reads status (never cached). Feature is degraded immediately on next use without crashing. |
| EC-PM-03 | **"Open Settings" tapped — user changes nothing and returns immediately**. | 300 ms delay then re-check. Still blocked → rationale sheet stays shown with "Open Settings". |
| EC-PM-04 | **"Open Settings" tapped — user grants permission and returns**. | 300 ms delay then re-check. Now granted → proceed with the feature immediately. Sheet dismissed. |
| EC-PM-05 | **"Not now" tapped on rationale sheet** — feature is invoked again in the same session. | Show rationale sheet again (no memory of previous "Not now" within a session). |
| EC-PM-06 | **POST_NOTIFICATIONS auto-granted on API ≤ 32** — rationale sheet must not be shown. | Short-circuit: `permissionStatusProvider` returns `granted` without showing any UI. |

---

### 5.9 Settings

| ID | Scenario | Required behaviour |
|----|----------|--------------------|
| EC-ST-01 | **Business name edited to empty / whitespace**. | Disable "Save" in the edit dialog; show validation error. |
| EC-ST-02 | **Business name save fails** (DB write error). | Dialog stays open; show inline error. |
| EC-ST-03 | **Language switched mid-typing in a form** (e.g. user opens Settings tab while customer form is open in another route). | Language switch takes effect on next build; in-progress form text is not cleared. |
| EC-ST-04 | **Theme preference write to SharedPreferences fails**. | Continue with the in-memory theme; show no error (non-critical). On next launch, system default is used. |
| EC-ST-05 | **Sign out while the app is mid-navigation** (e.g. back stack has 4 screens). | Clear entire navigation stack; route to `/login`. No back-navigation back into the authenticated app. |

---

### 5.10 Device & OS

| ID | Scenario | Required behaviour |
|----|----------|--------------------|
| EC-DE-01 | **Low memory — OS kills the app process mid-use**. | On relaunch, the app restores to the correct screen for the auth/onboarding state. No data loss (all writes are transactional). |
| EC-DE-02 | **Device date/time changed manually** (clock skew). | OTP expiry and lockout use `DateTime.now()` at the time the countdown started (delta-based). Jumping the clock forward does not bypass lockout. Jumping backward does not extend it past 10 min. |
| EC-DE-03 | **App data cleared from OS settings** (Settings → Apps → Clear Data). | On next launch, treat as a fresh install: show login screen, empty database. No crash. |
| EC-DE-04 | **Storage permission revoked for the entire app** (Android "Revoke all permissions"). | App-private storage (`getApplicationDocumentsDirectory`) is not affected by this — it does not require a storage permission. Catalog images remain accessible. |
| EC-DE-05 | **Screen rotated mid-form** (e.g. transaction entry form). | Form state is preserved across rotation (use `TextEditingController` with Riverpod state, not local widget state). |
| EC-DE-06 | **Keyboard covers the input field**. | `resizeToAvoidBottomInset: true` on `AppScaffold`; focused field scrolls into view automatically. |
| EC-DE-07 | **Very small screen** (e.g. 320 dp wide — older Android devices). | Layout must not overflow. `AppScaffold` horizontal padding reduces gracefully; no `RenderFlex overflow` errors. Minimum supported width: 320 dp. |
| EC-DE-08 | **Large font size** set in OS accessibility settings (up to 200% text scale). | All text containers must use `maxLines` + `overflow: TextOverflow.ellipsis` or wrap gracefully. No overflow clipping or text cut-off. |
| EC-DE-09 | **App in split-screen mode** (Android multi-window). | Treated as a narrow-width screen; mobile layout applies. No crash. |

---

### 5.11 Data Integrity

| ID | Scenario | Required behaviour |
|----|----------|--------------------|
| EC-DI-01 | **Customer deleted while their ledger screen is open** (deleted from another route in the back stack). | Ledger screen receives null/empty stream from `customerDetailProvider`; shows "This customer no longer exists" and a back button. Does not crash. |
| EC-DI-02 | **Transaction edited concurrently from two routes** (e.g. list swipe + deep link — unlikely but possible). | Last write wins (Drift serialises writes). UI reacts to stream update; no crash, no phantom data. |
| EC-DI-03 | **Database migration fails on app upgrade** (future schema change). | Show error screen: "There was a problem updating the app data. Please contact support." Do not wipe data silently. (Plan migrations in Drift from day one.) |
| EC-DI-04 | **Balance shown while transaction stream is loading**. | Show a shimmer/skeleton on the balance field; never show ₹0 transiently before data arrives. |
| EC-DI-05 | **Drift stream emits an error** (rare — disk I/O error). | Provider transitions to error state; screen shows `AppEmptyState`-style error UI with "Retry" button that calls `ref.invalidate()`. |

---

## 6. Data Model (Conceptual)

### Session
```
userId        String (phone number, hashed for local storage key)
phoneNumber   String (E.164 format, stored in secure storage)
isVerified    bool
createdAt     DateTime
```

### Business
```
id            String (UUID)
name          String
createdAt     DateTime
```

### Customer
```
id            String (UUID)
name          String
phoneNumber   String?
isArchived    bool
createdAt     DateTime
updatedAt     DateTime
```

### Transaction
```
id            String (UUID)
customerId    String (FK → Customer.id)
type          Enum { credit, payment }
amount        Decimal (2dp)
note          String?
date          Date (local)
createdAt     DateTime
```

**Derived**: `Customer.balance = SUM(credit amounts) − SUM(payment amounts)` computed at query time.

---

## 7. Screens Summary

| Screen | Route | Notes |
|--------|-------|-------|
| Login (phone + OTP) | `/login` | Single screen; OTP section reveals inline after "Send OTP" |
| Onboarding — Language Selection | `/onboarding/language` | First-launch step 1; mandatory |
| Onboarding — Business Name | `/onboarding/name` | First-launch step 2; mandatory |
| Onboarding — Theme Selection | `/onboarding/theme` | First-launch step 3; mandatory |
| Onboarding — Feature Tour | `/onboarding/tour` | First-launch step 4; skippable 3-slide PageView |
| Dashboard | `/home` | Customer list + summary totals |
| Add / Edit Customer | `/customer/new`, `/customer/:id/edit` | Sheet or full screen |
| Customer Ledger | `/customer/:id` | Transaction history |
| Add / Edit Transaction | `/customer/:id/transaction/new`, `.../transaction/:txId/edit` | Modal bottom sheet |
| Settings | `/settings` | Business name, language, theme, sign out |
| Image Catalog | `/catalog` | Add, browse, rename, delete catalog images |

---

## 8. v2 Roadmap

Features deferred from v1 — to be scoped and prioritised for the v2 release.

- **Google / social sign-in** — additional auth method alongside phone + OTP.
- **Cloud backup & sync** — opt-in sync layer on top of local Drift DB; device-to-device data migration.
- **Multi-user / team accounts** — multiple staff members sharing one business ledger.
- **Export & reports** — CSV / PDF export of ledger history and business summary.
- **Push notifications** — automated overdue-balance reminders; requires the `POST_NOTIFICATIONS` permission already requested in v1 as prep.
- **Recurring transactions** — scheduled credit/payment entries for regular customers.
- **GST / invoice generation** — formal invoice with tax breakdown.
- **Bank account integration** — UPI or bank feed reconciliation.