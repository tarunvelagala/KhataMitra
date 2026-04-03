# KhataMitra — Implementation Plan

> **Purpose**: A commit-by-commit build order for the MVP defined in `initial-requirements.md`.
> Each commit is independently buildable, testable, and shippable — no commit leaves the app broken.
> Work through phases top to bottom. Do not skip ahead.

---

## How to use this plan

1. Pick the next unchecked commit.
2. Read the **Files** and **Tests** columns — implement everything listed before committing.
3. Run the full gate before every commit:
   ```bash
   dart analyze          # zero issues
   dart format . --set-exit-if-changed
   flutter test --coverage
   ```
4. Commit with the exact message shown (Conventional Commits).
5. Check the box and move to the next commit.

---

## Current state (baseline)

Already in `main`:
- Material 3 theme, color tokens, typography (`lib/core/theme/`)
- Responsive layout system, breakpoints, extensions (`lib/core/responsive/`)
- Riverpod locale provider, go_router scaffold (`lib/router/app_router.dart`)
- l10n: EN / HI / TE `.arb` files + generated code
- Placeholder `/home` route with language toggle FAB
- Tests: `theme_test.dart`, `responsive_test.dart`, `localization_test.dart`, `widget_test.dart`

Missing from `pubspec.yaml` (will be added per phase):
- `drift` + `drift_flutter` — local database
- `flutter_secure_storage` — session token
- `permission_handler` — runtime permissions
- `image_picker` — catalog photo import
- `image_compress` / `flutter_image_compress` — catalog compression
- `share_plus` — share sheet
- `path_provider` — app-private storage paths
- `uuid` — ID generation
- `intl` (already present) — number / date formatting

---

## Phase 0 — Project housekeeping

> **Goal**: land all new dependencies, configure Drift, and wire up the DB shell.
> After this phase the app still shows the placeholder home screen — nothing visible changes.

---

### P0-C1 — Add core dependencies

**Commit**: `chore: add drift, secure_storage, permission_handler, share_plus, uuid dependencies`

| Area | Files touched |
|------|--------------|
| Dependencies | `pubspec.yaml` |
| Drift codegen | `build.yaml` (add drift builder config) |

**What to do**:
- Add to `dependencies`: `drift: ^2.x`, `drift_flutter: ^0.x`, `flutter_secure_storage: ^9.x`, `permission_handler: ^11.x`, `share_plus: ^10.x`, `path_provider: ^2.x`, `uuid: ^4.x`, `image_picker: ^1.x`, `flutter_image_compress: ^2.x`
- Add to `dev_dependencies`: `drift_dev: ^2.x`, `build_runner` (already present)
- Add `build.yaml` configuring `drift_dev` generator
- Android: add `INTERNET` (OTP), `READ_CONTACTS`, `SEND_SMS`, `CAMERA`, `READ_MEDIA_IMAGES`, `READ_EXTERNAL_STORAGE`, `POST_NOTIFICATIONS` to `AndroidManifest.xml`
- iOS: add `NSCameraUsageDescription`, `NSPhotoLibraryUsageDescription` to `Info.plist`

**Tests**: no new tests (dependency change only); confirm `flutter test` still green.

---

### P0-C2 — Database schema and AppDatabase shell

**Commit**: `feat: add Drift database schema for business, customer, and transaction tables`

| Area | Files touched |
|------|--------------|
| DB schema | `lib/core/database/app_database.dart` |
| DB tables | `lib/core/database/tables/business_table.dart`, `customer_table.dart`, `transaction_table.dart`, `catalog_image_table.dart` |
| Generated | `lib/core/database/app_database.g.dart` (run `build_runner`) |
| Provider | `lib/core/database/database_provider.dart` |

**What to do**:
- Define `BusinessTable`, `CustomerTable`, `TransactionTable`, `CatalogImageTable` as Drift `Table` classes matching the data model in §5 of the requirements
- `AppDatabase` annotated with `@DriftDatabase(tables: [...])`
- `databaseProvider` — a `keepAlive: true` `@riverpod` provider returning `AppDatabase`
- Run `build_runner` to generate `.g.dart` files

**Tests**: `test/database/app_database_test.dart` — open in-memory DB, verify all tables exist, insert + query one row per table.

---

### P0-C3 — Shared responsive widget library

**Commit**: `feat: add core shared widget library (AppScaffold, AppCard, AppButton, AppInput, AppListTile, AppEmptyState, AppSectionHeader, AppBottomSheet, AppConfirmDialog, AppBadge)`

| Area | Files touched |
|------|--------------|
| Widgets | `lib/core/widgets/app_scaffold.dart` |
| | `lib/core/widgets/app_card.dart` |
| | `lib/core/widgets/app_button.dart` |
| | `lib/core/widgets/app_input.dart` |
| | `lib/core/widgets/app_list_tile.dart` |
| | `lib/core/widgets/app_empty_state.dart` |
| | `lib/core/widgets/app_section_header.dart` |
| | `lib/core/widgets/app_bottom_sheet.dart` |
| | `lib/core/widgets/app_confirm_dialog.dart` |
| | `lib/core/widgets/app_badge.dart` |
| Barrel | `lib/core/widgets/widgets.dart` |

**What to do**: implement every widget per the Shared Widget Library appendix at the bottom of this document. Every widget must read from `context.rDims` / `context.rText` / `Theme.of(context)` — no hardcoded numbers.

**Tests**: `test/core/widgets/` — one widget test per file verifying: renders without error on mobile size, renders without error on tablet size (using `MediaQuery` override), and core props are reflected in the tree (label text, disabled state, etc.).

---

## Phase 1 — Authentication

> **Goal**: replace the placeholder home screen with a real login gate.
> After this phase: phone entry → OTP → session persisted → dashboard placeholder shown.

---

### P1-C1 — Session repository and provider

**Commit**: `feat: add session repository and auth state provider`

| Area | Files touched |
|------|--------------|
| Repository | `lib/features/auth/data/session_repository.dart` |
| Provider | `lib/features/auth/providers/auth_state_provider.dart` + `.g.dart` |
| Secure storage key | `lib/core/constants/storage_keys.dart` |

**What to do**:
- `SessionRepository`: wraps `FlutterSecureStorage`; exposes `saveSession(phoneNumber)`, `clearSession()`, `getSession() → String?`
- `AuthState`: sealed class — `AuthState.unauthenticated()`, `AuthState.authenticated(phoneNumber)`
- `authStateProvider`: `keepAlive: true` AsyncNotifier; reads from `SessionRepository` on `build()`, exposes `login(phoneNumber)` and `logout()`
- Router redirect: update `app_router.dart` to redirect `/home` → `/login` when `authStateProvider` is unauthenticated

**Tests**: `test/auth/session_repository_test.dart`, `test/auth/auth_state_provider_test.dart` — use `ProviderContainer` with a mock `SessionRepository`.

---

### P1-C2 — OTP service (mock-friendly interface)

**Commit**: `feat: add OTP service interface with mock and Firebase stub implementations`

| Area | Files touched |
|------|--------------|
| Interface | `lib/features/auth/data/otp_service.dart` |
| Mock impl | `lib/features/auth/data/mock_otp_service.dart` |
| Provider | `lib/features/auth/providers/otp_provider.dart` + `.g.dart` |

**What to do**:
- `OtpService` abstract class: `sendOtp(String phoneNumber) → Future<void>`, `verifyOtp(String phoneNumber, String code) → Future<bool>`
- `MockOtpService`: always sends successfully; accepts `"123456"` as valid code (for development/testing)
- `otpServiceProvider`: returns `MockOtpService`; easy to swap for Firebase in v2
- `OtpState`: sealed — `idle | sending | codeSent | verifying | verified | failed(message)`
- `otpStateProvider`: `AsyncNotifier` orchestrating the OTP flow; enforces 3-failure lockout with `DateTime`-based unlock time

**Tests**: `test/auth/otp_provider_test.dart` — send, verify correct, verify wrong ×3 lockout.

---

### P1-C3 — Phone number entry screen

**Commit**: `feat: add phone number entry screen with validation`

| Area | Files touched |
|------|--------------|
| Screen | `lib/features/auth/screens/phone_entry_screen.dart` |
| Route | `lib/router/app_router.dart` (add `/login` route) |
| l10n | `lib/l10n/app_en.arb`, `app_hi.arb`, `app_te.arb` + regenerate |

**What to do**:
- Full-screen layout using `AppScaffold`; single `AppInput` for 10-digit number with numeric keyboard
- `AppButton(variant: filled, fullWidth: true)` disabled until exactly 10 digits entered
- On submit: calls `otpStateProvider.notifier.sendOtp()`; `isLoading: true` on the button while sending; navigates to `/login/otp` on `codeSent`
- Matches Stitch design reference for this screen
- All strings from l10n

**Tests**: `test/auth/phone_entry_screen_test.dart` — button disabled with 9 digits, enabled at 10, tapping it triggers provider.

---

### P1-C4 — OTP verification screen

**Commit**: `feat: add OTP verification screen with countdown and retry logic`

| Area | Files touched |
|------|--------------|
| Screen | `lib/features/auth/screens/otp_verification_screen.dart` |
| Route | `lib/router/app_router.dart` (add `/login/otp` route) |
| l10n | `.arb` files + regenerate |

**What to do**:
- `AppScaffold` with back arrow navigating back to phone entry (clears OTP state)
- 6 single-digit `AppInput` cells (narrow, centred) with auto-advance on input and auto-backspace on delete
- 5-minute countdown timer; `AppButton(variant: text)` "Resend OTP" disabled for 30 seconds then enabled
- On complete 6-digit entry: auto-calls `verifyOtp()`
- Success → `authStateProvider.notifier.login(phoneNumber)` → router redirects to `/home`
- Wrong code → inline error below digit cells; after 3 failures show lockout message with remaining time via `AppButton(isLoading: true)` or disabled state
- Matches Stitch design reference

**Tests**: `test/auth/otp_verification_screen_test.dart` — renders, auto-advances, shows error on wrong code.

---

## Phase 2 — Onboarding

> **Goal**: first-time user sees business name setup after login. Returning users skip it.

---

### P2-C1 — Business repository and onboarding state

**Commit**: `feat: add business repository and onboarding completion provider`

| Area | Files touched |
|------|--------------|
| Repository | `lib/features/onboarding/data/business_repository.dart` |
| Provider | `lib/features/onboarding/providers/onboarding_provider.dart` + `.g.dart` |

**What to do**:
- `BusinessRepository`: Drift DAO wrapping `BusinessTable`; `getBusiness() → Future<Business?>`, `saveBusiness(name) → Future<void>`
- `onboardingCompleteProvider`: returns `true` if a business record exists; `false` otherwise
- Router: add redirect — after login, if `!onboardingComplete` go to `/onboarding`; else go to `/home`

**Tests**: `test/onboarding/business_repository_test.dart`, `test/onboarding/onboarding_provider_test.dart`.

---

### P2-C2 — Onboarding screens

**Commit**: `feat: add business name entry and feature tour onboarding screens`

| Area | Files touched |
|------|--------------|
| Screens | `lib/features/onboarding/screens/business_name_screen.dart`, `feature_tour_screen.dart` |
| Route | `lib/router/app_router.dart` (add `/onboarding` sub-routes) |
| l10n | `.arb` files + regenerate |

**What to do**:
- `BusinessNameScreen`: single required `TextField`; "Continue" button disabled when empty; saves business on submit via `businessRepository`; navigates to tour
- `FeatureTourScreen`: 2-page `PageView` with illustration + description per page; "Skip" and "Next"/"Done" buttons; marks onboarding complete in provider on "Done" or "Skip"
- Matches Stitch design reference
- All strings from l10n

**Tests**: widget smoke tests for both screens.

---

## Phase 3 — Core data layer (customers + transactions)

> **Goal**: full repository + provider layer for customers and transactions with tests.
> No UI yet — this is the data backbone for Phases 4 and 5.

---

### P3-C1 — Customer repository

**Commit**: `feat: add customer repository with CRUD and archive support`

| Area | Files touched |
|------|--------------|
| DAO | `lib/features/customers/data/customer_dao.dart` |
| Repository | `lib/features/customers/data/customer_repository.dart` |
| Models | `lib/features/customers/models/customer.dart` |

**What to do**:
- `CustomerDao`: Drift DAO — `watchAllActive()`, `watchArchived()`, `getById()`, `insert()`, `update()`, `softDelete(archive)`, `hardDelete()`
- `CustomerRepository`: thin wrapper converting Drift data classes to domain `Customer` model
- `Customer` model: id, name, phoneNumber?, isArchived, createdAt, updatedAt, balance (derived — computed from transactions query)

**Tests**: `test/customers/customer_repository_test.dart` — in-memory DB; CRUD, archive, duplicate-name detection.

---

### P3-C2 — Customer providers

**Commit**: `feat: add customer list and detail Riverpod providers`

| Area | Files touched |
|------|--------------|
| Providers | `lib/features/customers/providers/customer_list_provider.dart`, `customer_detail_provider.dart` + `.g.dart` |

**What to do**:
- `customerListProvider`: `StreamProvider` watching `CustomerDao.watchAllActive()`; sorted by last transaction date
- `archivedCustomerListProvider`: `StreamProvider` for archived customers
- `customerDetailProvider(id)`: `StreamProvider.family` watching a single customer + their computed balance

**Tests**: `test/customers/customer_providers_test.dart` — add customer, watch stream emits, archive, watch updates.

---

### P3-C3 — Transaction repository and providers

**Commit**: `feat: add transaction repository and providers`

| Area | Files touched |
|------|--------------|
| DAO | `lib/features/transactions/data/transaction_dao.dart` |
| Repository | `lib/features/transactions/data/transaction_repository.dart` |
| Models | `lib/features/transactions/models/transaction.dart` |
| Providers | `lib/features/transactions/providers/transaction_providers.dart` + `.g.dart` |

**What to do**:
- `TransactionDao`: `watchByCustomer(customerId)`, `insert()`, `update()`, `delete()`; balance computed as `SUM(credit) - SUM(payment)` via Drift expression
- `transactionListProvider(customerId)`: `StreamProvider.family` — transactions in reverse chronological order with running balance
- `customerBalanceProvider(customerId)`: derived from transaction stream; feeds into customer detail

**Tests**: `test/transactions/transaction_repository_test.dart` — insert credit, insert payment, verify balance, delete, verify recomputed.

---

## Phase 4 — Dashboard and customer management UI

> **Goal**: the main loop — user can open the app, see customer list, add a customer.
> After this phase the core bookkeeping loop is functional end-to-end.

---

### P4-C1 — Bottom navigation shell

**Commit**: `feat: add bottom navigation shell with Dashboard, Catalog, and Settings destinations`

| Area | Files touched |
|------|--------------|
| Shell | `lib/features/shell/screens/app_shell.dart` |
| Route | `lib/router/app_router.dart` (replace placeholder `/home` with shell + nested routes) |
| l10n | `.arb` files + regenerate |

**What to do**:
- `NavigationBar` with 3 destinations: Dashboard, Catalog, Settings (using Material 3 `NavigationBar`)
- `StatefulShellRoute` in go_router preserving scroll/state per tab
- Each tab shows a placeholder screen for now (replaced in subsequent commits)
- Matches Stitch navigation design

**Tests**: `test/shell/app_shell_test.dart` — renders, tapping each tab shows correct placeholder.

---

### P4-C2 — Dashboard screen

**Commit**: `feat: add dashboard screen with summary totals and customer list`

| Area | Files touched |
|------|--------------|
| Screen | `lib/features/dashboard/screens/dashboard_screen.dart` |
| Widgets | `lib/features/dashboard/widgets/summary_card.dart`, `customer_list_tile.dart` |
| l10n | `.arb` files + regenerate |

**What to do**:
- Summary strip at top: total receivable (green), total payable (red) — two `AppCard` widgets containing `AppBadge` chips
- `ListView.builder` of `CustomerListTile` (composes `AppListTile` + `AppBadge`) — name, balance (colour-coded), last transaction date
- Real-time search bar using `AppInput` filtering customer list
- FAB → navigates to `/customer/new`
- Empty state widget with illustration and CTA
- `ref.watch(customerListProvider)` for data; `select` to minimise rebuilds on unrelated changes
- Responsive: single column on mobile, two-column on tablet
- Matches Stitch design reference

**Tests**: `test/dashboard/dashboard_screen_test.dart` — renders empty state, renders with customers, search filters list.

---

### P4-C3 — Add / Edit customer sheet

**Commit**: `feat: add add/edit customer bottom sheet with duplicate detection`

| Area | Files touched |
|------|--------------|
| Sheet | `lib/features/customers/screens/customer_form_sheet.dart` |
| Route | `lib/router/app_router.dart` (add `/customer/new`, `/customer/:id/edit`) |
| l10n | `.arb` files + regenerate |

**What to do**:
- Modal bottom sheet (full height on small phones)
- Name field (required), phone field (optional, numeric)
- On save: checks for duplicate name → shows `SnackBar` warning (does not block); saves via `customerRepository`
- Edit mode: pre-fills existing values; same save path
- Dismiss by back button or dragging down
- All strings from l10n

**Tests**: `test/customers/customer_form_sheet_test.dart` — save disabled when name empty, duplicate warning shown, saves correctly.

---

### P4-C4 — Contacts permission + import from contacts

**Commit**: `feat: add contacts permission flow and import-from-contacts in customer form`

| Area | Files touched |
|------|--------------|
| Permission core | `lib/core/permissions/permission_type.dart`, `permission_service.dart`, `permission_provider.dart`, `permission_flow.dart` |
| Widgets | `lib/core/widgets/app_bottom_sheet.dart`, `permission_rationale_sheet.dart` |
| Integration | `lib/features/customers/screens/customer_form_sheet.dart` (add "Import from contacts" button) |
| l10n | `.arb` files (permission rationale strings) + regenerate |

**What to do**:
- Generic `PermissionService` wrapping `permission_handler`; handles Granted / Denied / PermanentlyDenied states
- `permissionStatusProvider(PermissionType)` — `keepAlive: true` family; never cached across restarts (reads from OS on every `build()`)
- `PermissionRationaleSheet`: non-dismissible (`barrierDismissible: false`, `enableDrag: false`); "Allow" / "Not now" buttons; "Open Settings" when permanently denied; 300 ms re-check delay after returning from Settings
- `runPermissionFlow(context, ref, type, strings) → Future<bool>` — single call site for all features
- Contacts rationale strings: title + body per §3.3.3, localised in all 3 languages
- "Import from contacts" button in customer form sheet: hidden when permission denied/blocked; triggers `runPermissionFlow` then opens system contact picker

**Tests**: `test/core/permissions/` — service state machine, provider, rationale sheet renders correct content and buttons.

---

## Phase 5 — Customer ledger and transactions UI

---

### P5-C1 — Customer ledger screen

**Commit**: `feat: add customer ledger screen with transaction history`

| Area | Files touched |
|------|--------------|
| Screen | `lib/features/customers/screens/customer_ledger_screen.dart` |
| Widgets | `lib/features/transactions/widgets/transaction_list_tile.dart` |
| Route | `lib/router/app_router.dart` (add `/customer/:id`) |
| l10n | `.arb` files + regenerate |

**What to do**:
- Header: customer name, phone, net balance (colour-coded)
- `SliverList` of `TransactionListTile` — date, type icon + label, amount, note, running balance; credit in red, payment in green
- Two bottom action buttons: "Credit" and "Payment" — navigate to `/customer/:id/transaction/new?type=credit|payment`
- Swipe-to-reveal (or long-press) shows Edit + Delete actions on a transaction row
- "Send Reminder" button in app bar → navigate to `/customer/:id/reminder`
- Empty state
- Matches Stitch design reference

**Tests**: `test/customers/customer_ledger_screen_test.dart` — renders header, renders transactions, swipe reveals actions.

---

### P5-C2 — Add / Edit transaction sheet

**Commit**: `feat: add add/edit transaction bottom sheet`

| Area | Files touched |
|------|--------------|
| Sheet | `lib/features/transactions/screens/transaction_form_sheet.dart` |
| Route | `lib/router/app_router.dart` (add `/customer/:id/transaction/new`, `.../transaction/:txId/edit`) |
| l10n | `.arb` files + regenerate |

**What to do**:
- Amount field (numeric, decimal, required); note field (optional, 200-char limit with counter); date picker (defaults to today)
- Transaction type (credit / payment) set from route param; visually indicated in sheet header
- Validates: amount > 0, amount parseable as decimal ≤ 2dp
- Save: immediate write via `transactionRepository`; dismisses sheet; ledger stream auto-updates
- Edit mode: pre-fills existing values; delete action available with confirmation dialog
- Matches Stitch design reference

**Tests**: `test/transactions/transaction_form_sheet_test.dart` — save disabled when amount empty/invalid, saves correctly, delete triggers confirmation.

---

### P5-C3 — Archive and delete customer actions

**Commit**: `feat: add archive and delete customer actions from ledger screen`

| Area | Files touched |
|------|--------------|
| Screen | `lib/features/customers/screens/customer_ledger_screen.dart` (add overflow menu) |
| Screen | `lib/features/dashboard/screens/dashboard_screen.dart` (add Archived tab/filter) |
| l10n | `.arb` files + regenerate |

**What to do**:
- Overflow menu on ledger screen: "Archive customer", "Delete customer"
- Archive: soft-delete via `customerRepository.archive(id)`; navigates back to dashboard; customer moves to archived list
- Delete: confirmation dialog warning that all transactions will be lost; hard-delete via `customerRepository.delete(id)`; cascade handled at DB level (Drift `onDelete: cascade`)
- Dashboard "Archived" filter chip (or segmented button) to switch between active / archived lists

**Tests**: `test/customers/customer_actions_test.dart` — archive moves customer, delete removes customer and transactions.

---

## Phase 6 — Permissions: notifications and SMS

> Hooks into the existing permission infrastructure from P4-C4.

---

### P6-C1 — Notifications permission

**Commit**: `feat: trigger notifications permission after first successful transaction`

| Area | Files touched |
|------|--------------|
| Permission strings | `lib/core/permissions/permission_strings.dart` (add notifications rationale) |
| Integration | `lib/features/transactions/screens/transaction_form_sheet.dart` |
| l10n | `.arb` files + regenerate |

**What to do**:
- After a transaction saves successfully for the first time (tracked via a `SharedPreferences` flag), call `runPermissionFlow(context, ref, PermissionType.notifications, ...)`
- If denied: silently continue; no error shown (F-PM-08)
- Notifications rationale strings in all 3 languages per §3.3.3

**Tests**: `test/core/permissions/notifications_permission_test.dart` — flow triggers once only, denied result does not surface an error.

---

### P6-C2 — SMS permission

**Commit**: `feat: add SMS permission flow gating direct-SMS in reminder composer`

| Area | Files touched |
|------|--------------|
| Permission strings | `lib/core/permissions/permission_strings.dart` (add SMS rationale) |
| l10n | `.arb` files + regenerate |

**What to do**:
- SMS rationale strings in all 3 languages per §3.3.3
- `PermissionType.sms` added to the permission type enum and service
- The reminder composer (Phase 7) will call this; this commit only wires up the permission layer

**Tests**: `test/core/permissions/sms_permission_test.dart` — permission service handles SMS type correctly.

---

## Phase 7 — Reminder composer

---

### P7-C1 — Reminder composer screen — text block

**Commit**: `feat: add reminder composer with editable text template and live preview`

| Area | Files touched |
|------|--------------|
| Screen | `lib/features/reminder/screens/reminder_composer_screen.dart` |
| Provider | `lib/features/reminder/providers/reminder_provider.dart` + `.g.dart` |
| Model | `lib/features/reminder/models/reminder_draft.dart` |
| Route | `lib/router/app_router.dart` (add `/customer/:id/reminder`) |
| l10n | `.arb` files (default template, placeholders) + regenerate |

**What to do**:
- `ReminderDraft` model: text (String), attachedCatalogImageIds (List<String>), includeVisitingCard (bool)
- `reminderProvider(customerId)`: `Notifier` holding `ReminderDraft`; initialises text from saved template or built-in default with placeholders resolved
- Text block: editable `TextField` pre-filled with resolved template; save-as-default button
- Live preview panel below the editor showing resolved text
- "Send" button (disabled until text non-empty) — wires up in P7-C3
- Matches Stitch design reference

**Tests**: `test/reminder/reminder_composer_screen_test.dart` — renders, placeholder resolution correct, text editable.

---

### P7-C2 — Visiting card block

**Commit**: `feat: add visiting card generator and toggle in reminder composer`

| Area | Files touched |
|------|--------------|
| Model | `lib/features/settings/models/visiting_card_config.dart` |
| Repository | `lib/features/settings/data/visiting_card_repository.dart` |
| Widget | `lib/features/reminder/widgets/visiting_card_preview.dart` |
| Widget | `lib/features/settings/widgets/visiting_card_editor.dart` |
| Settings screen | `lib/features/settings/screens/settings_screen.dart` (add "Edit visiting card" entry) |
| l10n | `.arb` files + regenerate |

**What to do**:
- `VisitingCardConfig`: businessName, tagline?, bgColor (enum of palette), fontStyle (enum of 2), showPhone (bool)
- Stored via `BusinessRepository` (add column to business table or separate JSON field)
- `VisitingCardPreview` widget: renders an `800×400` `CustomPaint` / `Stack` widget matching the config; shown in composer when toggle is on
- `VisitingCardEditor`: colour palette chips, font style toggle, phone toggle; accessible from Settings and composer
- PNG export via `RenderRepaintBoundary.toImage()` → `image.toByteData(format: ImageByteFormat.png)`

**Tests**: `test/reminder/visiting_card_test.dart` — config persists, preview renders without error.

---

### P7-C3 — Catalog image block + send channel

**Commit**: `feat: complete reminder composer with catalog image picker and share sheet dispatch`

| Area | Files touched |
|------|--------------|
| Widget | `lib/features/reminder/widgets/catalog_image_picker.dart` |
| Provider | `lib/features/reminder/providers/reminder_provider.dart` (extend) |
| Share layer | `lib/features/reminder/data/reminder_share_service.dart` |
| l10n | `.arb` files + regenerate |

**What to do**:
- `CatalogImagePicker`: grid of catalog thumbnails; multi-select up to 3; empty-catalog prompt navigating to `/catalog`; no permission requests here
- `ReminderShareService`: copies selected catalog images to `getTemporaryDirectory()`; renders visiting card PNG to temp file; calls `SharePlus.shareXFiles(...)` with text + files; deletes temp files after share completes
- WhatsApp quick-action: if `canLaunchUrl('whatsapp://')` is true, show dedicated WhatsApp button above generic share
- SMS quick-action: gated behind `runPermissionFlow(PermissionType.sms)` — if denied, button is hidden
- "Send" button wires through `ReminderShareService`

**Tests**: `test/reminder/reminder_share_service_test.dart` — temp files created and cleaned up; share called with correct files.

---

## Phase 8 — Image catalog

---

### P8-C1 — Catalog repository and provider

**Commit**: `feat: add catalog image repository and provider`

| Area | Files touched |
|------|--------------|
| Repository | `lib/features/catalog/data/catalog_repository.dart` |
| Provider | `lib/features/catalog/providers/catalog_provider.dart` + `.g.dart` |
| Model | `lib/features/catalog/models/catalog_image.dart` |

**What to do**:
- `CatalogImage` model: id, label, filePath (app-private), createdAt
- `CatalogRepository`: Drift DAO + file I/O; `watchAll()`, `add(filePath, label)`, `rename(id, label)`, `delete(id)` (deletes DB row AND file)
- `catalogImagesProvider`: `StreamProvider` watching all catalog images sorted by `createdAt DESC`
- Enforces 50-image cap in `add()`

**Tests**: `test/catalog/catalog_repository_test.dart` — add, rename, delete (file removed), cap enforced.

---

### P8-C2 — Catalog screen

**Commit**: `feat: add image catalog screen with grid, add, rename, and delete`

| Area | Files touched |
|------|--------------|
| Screen | `lib/features/catalog/screens/catalog_screen.dart` |
| Widgets | `lib/features/catalog/widgets/catalog_image_tile.dart` |
| l10n | `.arb` files + regenerate |

**What to do**:
- `SliverGrid` of `CatalogImageTile` (3 columns); each tile shows thumbnail + label; long-press shows context menu: "Rename", "Delete"
- Multi-select mode: long-press enters select mode; toolbar shows count + bulk-delete action
- Rename: inline dialog with pre-filled label (60-char limit)
- Delete (single or bulk): confirmation dialog; calls `catalogRepository.delete(id)` for each
- Empty state with illustration and "Add your first image" CTA
- Add FAB opens bottom sheet with "Pick from gallery" / "Take a photo" options

**Tests**: `test/catalog/catalog_screen_test.dart` — renders empty state, renders grid, long-press shows menu.

---

### P8-C3 — Catalog image import with permissions

**Commit**: `feat: add camera and gallery import to catalog with permission flow`

| Area | Files touched |
|------|--------------|
| Import service | `lib/features/catalog/data/catalog_import_service.dart` |
| Permission strings | `lib/core/permissions/permission_strings.dart` (add camera + gallery rationale) |
| Integration | `lib/features/catalog/screens/catalog_screen.dart` |
| l10n | `.arb` files + regenerate |

**What to do**:
- `CatalogImportService`: wraps `ImagePicker`; picks image (gallery or camera); compresses if > 5 MB to ≤ 1 MB via `flutter_image_compress`; copies to `getApplicationDocumentsDirectory()/catalog/`; calls `catalogRepository.add()`
- Camera permission flow: `runPermissionFlow(PermissionType.camera, ...)`; button hidden if permanently denied
- Gallery permission flow: `runPermissionFlow(PermissionType.gallery, ...)`; button hidden if permanently denied
- Camera and Gallery rationale strings in all 3 languages per §3.3.3

**Tests**: `test/catalog/catalog_import_service_test.dart` — compression path called for large images, file saved to catalog dir, 50-image cap surfaced.

---

## Phase 9 — Settings screen

---

### P9-C1 — Settings screen

**Commit**: `feat: add settings screen with business name, language, theme, and sign-out`

| Area | Files touched |
|------|--------------|
| Screen | `lib/features/settings/screens/settings_screen.dart` |
| Provider | `lib/features/settings/providers/theme_provider.dart` + `.g.dart` |
| Persistence | theme preference stored via `SharedPreferences` |
| Route | `lib/router/app_router.dart` (wire settings tab to this screen) |
| l10n | `.arb` files + regenerate |

**What to do**:
- Business name: tappable row → edit dialog; saves via `businessRepository`
- Language: `SegmentedButton` / radio list for EN / HI / TE; updates `localeStateProvider`; persisted via `SharedPreferences`
- Theme: Light / Dark / System radio; `themeProvider` feeds `MaterialApp.themeMode`; persisted
- Edit visiting card: navigates to `VisitingCardEditor`
- Sign out: confirmation dialog → `authStateProvider.notifier.logout()` → router redirects to `/login`
- About: app version (from `package_info_plus`), open-source licences via `showLicensePage`

**Tests**: `test/settings/settings_screen_test.dart` — renders all sections, sign-out shows confirmation.

---

## Phase 10 — Polish and release gate

> Each commit here is a hardening pass — no new features.

---

### P10-C1 — Accessibility audit

**Commit**: `fix: add semanticsLabel to all icon-only buttons and fix touch targets`

- Audit every screen against NF-AC-01 to NF-AC-04
- Fix any icon-only buttons missing `semanticsLabel`
- Fix any interactive elements below 48×48 dp
- Run `flutter test --enable-accessibility-semantics`

---

### P10-C2 — Localization completeness

**Commit**: `fix: fill in all missing HI and TE strings and add locale-aware number/date formatting`

- Audit `app_hi.arb` and `app_te.arb` for any keys present in `app_en.arb` but missing or auto-translated
- Replace all `NumberFormat` and `DateFormat` usages with locale-aware instances from `intl`
- Verify Indian number system (lakh/crore) for HI/TE balance displays

---

### P10-C3 — Performance pass

**Commit**: `perf: add select() on providers, convert list rebuilds to const widgets`

- Audit all `ref.watch(provider)` in list items — replace with `ref.watch(provider.select(...))` to minimise rebuilds
- Convert all stateless `ListTile` subtrees that take no callbacks to `const`
- Profile with Flutter DevTools; confirm 60 fps on customer list with 100+ entries

---

### P10-C4 — Final coverage and analysis gate

**Commit**: `test: bring coverage to ≥ 80% on all new code`

- Run `flutter test --coverage`; inspect `coverage/lcov.info`
- Add missing unit or widget tests until all new files hit 80%
- Run `dart analyze` — zero warnings, zero hints

---

## Dependency reference

| Package | Version constraint | Used for |
|---------|--------------------|---------|
| `drift` | `^2.x` | Local SQLite ORM |
| `drift_flutter` | `^0.x` | Drift + Flutter integration |
| `drift_dev` | `^2.x` (dev) | Code generation |
| `flutter_secure_storage` | `^9.x` | Session token storage |
| `permission_handler` | `^11.x` | Runtime permission requests |
| `image_picker` | `^1.x` | Camera + gallery import |
| `flutter_image_compress` | `^2.x` | Catalog image compression |
| `share_plus` | `^10.x` | OS share sheet |
| `path_provider` | `^2.x` | App-private storage paths |
| `uuid` | `^4.x` | UUID generation for IDs |
| `shared_preferences` | `^2.x` | Theme + language persistence |
| `package_info_plus` | `^8.x` | App version in About screen |

---

## Route map (final)

| Route | Screen | Auth guard |
|-------|--------|-----------|
| `/login` | Phone number entry | Public |
| `/login/otp` | OTP verification | Public |
| `/onboarding` | Business name + tour | Authenticated, onboarding incomplete |
| `/home` | App shell (nav bar) | Authenticated + onboarded |
| `/home/dashboard` | Dashboard | — |
| `/home/catalog` | Image catalog | — |
| `/home/settings` | Settings | — |
| `/customer/new` | Add customer sheet | — |
| `/customer/:id` | Customer ledger | — |
| `/customer/:id/edit` | Edit customer sheet | — |
| `/customer/:id/transaction/new` | Add transaction sheet | — |
| `/customer/:id/transaction/:txId/edit` | Edit transaction sheet | — |
| `/customer/:id/reminder` | Reminder composer | — |

---

## Appendix — Shared Widget Library

All widgets live in `lib/core/widgets/`. Every widget reads layout values exclusively from `context.rDims`, text styles from `context.rText`, and colours from `Theme.of(context).colorScheme` / `Theme.of(context).extension<AppSurfaceColors>()`. No hardcoded numbers anywhere.

Import all of them via the barrel: `import 'package:khata_mitra/core/widgets/widgets.dart';`

---

### AppScaffold

**File**: `lib/core/widgets/app_scaffold.dart`

The single `Scaffold` wrapper used by every screen. Enforces the horizontal page gutter and the `contentMaxWidth` cap automatically so no screen needs to implement these manually.

```dart
AppScaffold({
  Widget? title,           // placed in AppBar; accepts Text or custom widget
  List<Widget>? actions,   // AppBar trailing actions
  required Widget body,    // content; wrapped in centering + max-width constraint
  Widget? floatingActionButton,
  Widget? bottomNavigationBar,
  bool resizeToAvoidBottomInset = true,
  PreferredSizeWidget? bottom, // AppBar bottom (e.g. TabBar, search bar)
})
```

**Behaviour**:
- Builds a `Scaffold` with a `BackdropFilter`-frosted `AppBar` (opacity = `rDims.appBarOpacity`)
- `body` is wrapped in `Center` → `ConstrainedBox(maxWidth: rDims.contentMaxWidth)` → `Padding(horizontal: rDims.screenHorizontalPadding)`
- AppBar elevation = 0; background colour = `colorScheme.surface.withOpacity(rDims.appBarOpacity)`

---

### AppCard

**File**: `lib/core/widgets/app_card.dart`

Tonal surface card matching the Material 3 card theme. Use instead of raw `Card` to get the responsive radius and padding automatically.

```dart
AppCard({
  required Widget child,
  VoidCallback? onTap,           // wraps in InkWell when provided
  EdgeInsetsGeometry? padding,   // defaults to EdgeInsets.all(rDims.cardHorizontalPadding)
  Color? color,                  // defaults to AppSurfaceColors.lowest
  double? borderRadius,          // defaults to rDims.radiusMedium
})
```

**Behaviour**:
- Renders `Material` → `InkWell` (when `onTap` != null) → `Padding` → `child`
- Radius comes from `rDims.radiusMedium`
- Padding defaults to `rDims.cardHorizontalPadding` on all sides
- `color` defaults to `Theme.of(context).extension<AppSurfaceColors>()!.lowest`

---

### AppButton

**File**: `lib/core/widgets/app_button.dart`

Wraps `FilledButton` and `OutlinedButton` in a single widget with enforced minimum touch target (48 dp height) and responsive padding.

```dart
enum AppButtonVariant { filled, outlined, text }

AppButton({
  required String label,
  required VoidCallback? onPressed,  // null = disabled
  AppButtonVariant variant = AppButtonVariant.filled,
  Widget? leadingIcon,
  Widget? trailingIcon,
  bool isLoading = false,            // replaces label with CircularProgressIndicator
  bool fullWidth = false,            // expands to fill parent width
})
```

**Behaviour**:
- Padding: `EdgeInsets.symmetric(vertical: rDims.buttonPaddingV, horizontal: rDims.buttonPaddingH)`
- Minimum height: 48 dp (meets NF-AC-01)
- `isLoading = true`: disables `onPressed` and shows a 20 dp `CircularProgressIndicator` in place of label
- `fullWidth = true`: wraps in `SizedBox(width: double.infinity)`
- `semanticsLabel` is set to `label` so icon-only usage can pass a meaningful description

---

### AppInput

**File**: `lib/core/widgets/app_input.dart`

Opinionated `TextFormField` wrapper. Reads `rDims` for padding and enforces the focused/default border widths from `AppDimensions`.

```dart
AppInput({
  required String label,
  TextEditingController? controller,
  String? hint,
  String? errorText,
  TextInputType keyboardType = TextInputType.text,
  TextInputAction textInputAction = TextInputAction.next,
  int? maxLength,
  int maxLines = 1,
  bool obscureText = false,
  bool readOnly = false,
  bool autofocus = false,
  Widget? prefixIcon,
  Widget? suffixIcon,
  ValueChanged<String>? onChanged,
  VoidCallback? onTap,
  FormFieldValidator<String>? validator,
})
```

**Behaviour**:
- `contentPadding`: `EdgeInsets.symmetric(vertical: rDims.inputPaddingV, horizontal: rDims.inputPaddingH)`
- Focused border width: `rDims.borderFocused` (2 dp); default border width: none (matches theme — filled style)
- `maxLength` shows a character counter using `rText.labelSmall`
- `errorText` overrides the validator message inline below the field

---

### AppListTile

**File**: `lib/core/widgets/app_list_tile.dart`

Responsive list tile enforcing 48 dp minimum touch target and consistent padding. Used for customer rows, transaction rows, and settings rows.

```dart
AppListTile({
  required Widget title,
  Widget? subtitle,
  Widget? leading,           // icon, avatar, or badge
  Widget? trailing,          // balance chip, chevron, switch, etc.
  VoidCallback? onTap,
  VoidCallback? onLongPress,
  bool showDivider = false,  // thin divider below (for settings-style lists)
  Color? tileColor,
})
```

**Behaviour**:
- Minimum height: 48 dp
- Horizontal padding: `rDims.screenHorizontalPadding`
- Vertical padding: 12 dp (mobile) / `12 * 1.15` dp (tablet)
- `showDivider = true`: renders a 1 dp `Divider` at `colorScheme.outlineVariant` opacity 0.3 below the tile
- `semanticsLabel` on `leading` icon enforced — callers must pass `Semantics(label: '...', child: icon)` or `Icon` with a `tooltip`

---

### AppEmptyState

**File**: `lib/core/widgets/app_empty_state.dart`

Centred illustration + heading + body + optional CTA. Used on every empty list screen.

```dart
AppEmptyState({
  required String title,
  required String body,
  String? svgAssetPath,      // illustration; shown at 160 dp (mobile) / 184 dp (tablet)
  String? ctaLabel,
  VoidCallback? onCta,
})
```

**Behaviour**:
- Centred `Column` with `MainAxisAlignment.center`
- Illustration: `SvgPicture.asset` at `160 * scaleFactor` dp; hidden when `svgAssetPath` is null
- Title: `rText.titleLarge`, colour `colorScheme.onSurface`
- Body: `rText.bodyMedium`, colour `colorScheme.onSurfaceVariant`
- CTA: `AppButton(variant: AppButtonVariant.filled)`, hidden when `ctaLabel` is null

---

### AppSectionHeader

**File**: `lib/core/widgets/app_section_header.dart`

Sticky-capable section label used between grouped list items (e.g. "Today", "Earlier", settings group labels).

```dart
AppSectionHeader({
  required String label,
  Widget? trailing,   // optional right-side action (e.g. "See all" TextButton)
})
```

**Behaviour**:
- `label` in `rText.labelMedium`, colour `colorScheme.primary`, uppercased
- Horizontal padding: `rDims.screenHorizontalPadding`
- Vertical padding: 8 dp top, 4 dp bottom
- Background: `colorScheme.surface` (so it reads correctly as a sticky header if wrapped in `SliverPersistentHeader`)

---

### AppBottomSheet

**File**: `lib/core/widgets/app_bottom_sheet.dart`

Generic non-dismissible-capable bottom sheet shell. The permission rationale sheet (P4-C4) and all modal forms compose this widget.

```dart
AppBottomSheet({
  required Widget child,
  String? title,              // bold title in sheet header
  bool isDismissible = true,  // false = barrierDismissible: false, enableDrag: false
  bool showDragHandle = true,
  EdgeInsetsGeometry? padding,
})
```

**Static helper**:
```dart
static Future<T?> show<T>(
  BuildContext context, {
  required Widget child,
  String? title,
  bool isDismissible = true,
  bool isScrollControlled = true,
})
```

**Behaviour**:
- Uses `showModalBottomSheet` internally
- `isDismissible = false`: sets `barrierDismissible: false` and `enableDrag: false` (required by permission rationale, F-PM-03)
- Top drag handle: 4 × 32 dp rounded pill in `colorScheme.outlineVariant`; hidden when `showDragHandle = false`
- `title` rendered in `rText.titleMedium`; divider below title if present
- `padding` defaults to `EdgeInsets.fromLTRB(rDims.screenHorizontalPadding, 8, rDims.screenHorizontalPadding, 24)`
- Bottom safe-area padding applied automatically via `SafeArea(bottom: true)`

---

### AppConfirmDialog

**File**: `lib/core/widgets/app_confirm_dialog.dart`

Standard destructive-action confirmation dialog. Used for delete customer, delete transaction, sign out.

```dart
AppConfirmDialog({
  required String title,
  required String body,
  required String confirmLabel,       // e.g. "Delete"
  String cancelLabel = 'Cancel',
  bool isDestructive = true,          // confirm button in error colour when true
})
```

**Static helper**:
```dart
/// Returns true when the user confirmed, false when cancelled.
static Future<bool> show(
  BuildContext context, {
  required String title,
  required String body,
  required String confirmLabel,
  String cancelLabel = 'Cancel',
  bool isDestructive = true,
})
```

**Behaviour**:
- `AlertDialog` with Material 3 styling
- `isDestructive = true`: confirm `TextButton` uses `colorScheme.error`
- Both buttons are `AppButton` instances so touch targets are met
- Returns `false` on barrier tap or cancel

---

### AppBadge

**File**: `lib/core/widgets/app_badge.dart`

Inline balance / status chip. Used in customer list rows, ledger header, and transaction tiles.

```dart
enum AppBadgeVariant { positive, negative, neutral }

AppBadge({
  required String label,
  AppBadgeVariant variant = AppBadgeVariant.neutral,
  bool compact = false,   // smaller padding for dense list rows
})
```

**Behaviour**:
- `Container` with `radiusPill` border radius
- Variants:
  - `positive` → background `colorScheme.secondaryContainer`, text `colorScheme.onSecondaryContainer` (green — they owe you)
  - `negative` → background `colorScheme.errorContainer`, text `colorScheme.onErrorContainer` (red — you owe them)
  - `neutral` → background `AppSurfaceColors.high`, text `colorScheme.onSurface`
- Padding: `compact = false` → H 12, V 6; `compact = true` → H 8, V 4
- Text style: `rText.labelMedium`

---

### Usage rules

1. **Never use raw `Scaffold`, `Card`, `ElevatedButton`, `TextFormField`, or `ListTile` in feature screens.** Always use the `App*` equivalents above.
2. **Feature-specific widgets** (e.g. `CustomerListTile`, `TransactionListTile`) are built by composing `AppListTile`, `AppCard`, `AppBadge` — not by reimplementing layout from scratch.
3. **All hardcoded numbers are banned in feature code.** If a spacing value is not covered by `rDims`, add it to `AppDimensions` and `ResponsiveDimensions` first, then reference it.
4. **No widget imports `AppDimensions` directly** — always go through `context.rDims` so the responsive layer is always in effect.
