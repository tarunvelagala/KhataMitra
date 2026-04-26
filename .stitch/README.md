# Stitch Design Assets

Stitch project: `https://stitch.withgoogle.com/project/3823020204310937544`

## How to use these files

Stitch screens are **AI-generated UI references** — use them to understand layout structure, illustration intent, and content hierarchy. **Do not copy tokens, fonts, or component rules from Stitch HTML files into Dart code.** All of that comes from `DESIGN.md`.

| What to take from Stitch | What to ignore |
|---|---|
| Overall visual layout and composition | Colors (use `AppColors.*` from DESIGN.md) |
| Illustration structure and content | Fonts (use platform system font per DESIGN.md) |
| Headline copy and body copy | Exact pixel values and Tailwind class names |
| Which elements go where on screen | Any component behavior or interaction logic |

---

## Screen inventory

Update "Stitch assets" and "Status" as screens are designed and implemented. Add or remove rows freely as the roadmap evolves.

### App Shell

| Screen | Route | Stitch assets | Status |
|---|---|---|---|
| Splash | `/splash` | none — custom `CustomPainter` | Implemented |
| Tour slide 1 | `/tour` | `designs/tour_slide_1/` | Specced in DESIGN.md |
| Tour slide 2 | `/tour` | `designs/tour_slide_2/` | Specced in DESIGN.md |
| Tour slide 3 | `/tour` | `designs/tour_slide_3/` | Specced in DESIGN.md |
| Home (shell) | `/home` | `designs/home_shell/` | Pending |

### Dashboard

| Screen | Route | Stitch assets | Status |
|---|---|---|---|
| Dashboard | `/dashboard` | `designs/dashboard/` | Pending |

### Ledger (Transactions)

| Screen | Route | Stitch assets | Status |
|---|---|---|---|
| Transaction list | `/ledger` | `designs/ledger_list/` | Pending |
| Add / Edit transaction | `/ledger/add`, `/ledger/:id/edit` | `designs/ledger_add/` | Pending |
| Transaction detail | `/ledger/:id` | `designs/ledger_detail/` | Pending |

### Customers (Party Ledger)

| Screen | Route | Stitch assets | Status |
|---|---|---|---|
| Customer list | `/customers` | `designs/customer_list/` | Pending |
| Customer detail | `/customers/:id` | `designs/customer_detail/` | Pending |
| Add / Edit customer | `/customers/add`, `/customers/:id/edit` | `designs/customer_add/` | Pending |

### Reports

| Screen | Route | Stitch assets | Status |
|---|---|---|---|
| Reports home | `/reports` | `designs/reports_home/` | Pending |
| P&L detail | `/reports/pnl` | `designs/reports_pnl/` | Pending |
| Cash flow | `/reports/cashflow` | `designs/reports_cashflow/` | Pending |

### Settings

| Screen | Route | Stitch assets | Status |
|---|---|---|---|
| Settings home | `/settings` | `designs/settings_home/` | Pending |
| Business profile | `/settings/business` | `designs/settings_business/` | Pending |
| Language | `/settings/language` | `designs/settings_language/` | Pending |
| Theme | `/settings/theme` | `designs/settings_theme/` | Pending |
| Backup & Restore | `/settings/backup` | `designs/settings_backup/` | Pending |
| About | `/settings/about` | `designs/settings_about/` | Pending |
