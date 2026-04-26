#!/usr/bin/env python3
"""
Generate all KhataPro screens via Stitch API and download assets.
"""
import json
import re
import os
import subprocess
import urllib.request
import time

PROJECT_ID = "3823020204310937544"
GCP_PROJECT = "khatamitra-492302"
BASE_DIR = "/Users/C5404787/workplace/personal/khata_pro/.stitch/designs"
STITCH_URL = "https://stitch.googleapis.com/mcp"

DESIGN_SYSTEM_CONTEXT = """
DESIGN SYSTEM (REQUIRED — KhataPro Material Design 3):
- Platform: Mobile-first, 390px width, Flutter app
- Primary Blue #1565C0: CTAs, active states, neutral brand
- Secondary Green #2E7D32: income/credit (money in) — NEVER swap with red
- Tertiary Red #C62828: expenses/debit (money out) — NEVER swap with green
- Error Red #BA1A1A: validation errors only, NOT financial data
- Background #FAF9FD, Surface Container Lowest #FFFFFF
- On-Surface #1A1B1E, On-Surface-Variant #44474E
- Outline #74777F, Outline-Variant #C4C6CF
- Secondary-Container #A3F69C: green tint for income rows
- Tertiary-Container #FFDAD6: red tint for expense rows
- Tour slide background: #F2F3F5
- Corner radius: 12px cards/buttons, 16px icon containers, 9999px pills
- Font: System font (Roboto/SF Pro), no custom fonts
- Material Design 3, flat elevation, tonal surface layering
- Atmosphere: Clean, trustworthy, utilitarian, airy, professional
- Semantic: South Asian small business, Hindi/Urdu audience, ledger book aesthetic
"""


def get_token():
    result = subprocess.run(
        ["/Users/C5404787/google-cloud-sdk/bin/gcloud", "auth", "application-default", "print-access-token"],
        capture_output=True, text=True,
        env={**os.environ, "CLOUDSDK_PYTHON_SITEPACKAGES": "1", "PYTHONWARNINGS": "ignore"}
    )
    return result.stdout.strip()


def call_stitch_api(payload, token):
    import urllib.request
    import json as _json

    data = _json.dumps(payload).encode()
    req = urllib.request.Request(
        STITCH_URL,
        data=data,
        headers={
            "Authorization": f"Bearer {token}",
            "X-Goog-User-Project": GCP_PROJECT,
            "Content-Type": "application/json"
        },
        method="POST"
    )
    with urllib.request.urlopen(req, timeout=200) as resp:
        return _json.loads(resp.read())


def generate_screen(screen_name, prompt):
    print(f"\n{'='*60}")
    print(f"Generating: {screen_name}")
    print('='*60)

    output_dir = os.path.join(BASE_DIR, screen_name)
    os.makedirs(output_dir, exist_ok=True)

    token = get_token()

    full_prompt = f"{prompt}\n\n{DESIGN_SYSTEM_CONTEXT}"

    payload = {
        "jsonrpc": "2.0",
        "method": "tools/call",
        "params": {
            "name": "generate_screen_from_text",
            "arguments": {
                "projectId": PROJECT_ID,
                "prompt": full_prompt,
                "deviceType": "MOBILE"
            }
        },
        "id": 1
    }

    try:
        response = call_stitch_api(payload, token)
    except Exception as e:
        print(f"  ERROR calling API: {e}")
        return False

    # Save raw response
    resp_path = os.path.join(output_dir, "response.json")
    with open(resp_path, "w") as f:
        json.dump(response, f)

    raw = json.dumps(response)

    # Extract screen ID
    screen_ids = re.findall(r'screens/([a-f0-9]{32})', raw)
    screen_id = screen_ids[0] if screen_ids else None
    print(f"  Screen ID: {screen_id}")

    # Extract code download URL
    code_urls = re.findall(
        r'https://contribution\.usercontent\.google\.com/download\?[A-Za-z0-9=&%+/_\-]+',
        raw
    )
    code_url = code_urls[0] if code_urls else None

    # Extract full screenshot URL
    img_urls = re.findall(
        r'https://lh3\.googleusercontent\.com/aida/[A-Za-z0-9_\-]+',
        raw
    )
    img_url = img_urls[0] if img_urls else None

    print(f"  Code URL: {'found' if code_url else 'NOT FOUND'}")
    print(f"  Image URL: {'found' if img_url else 'NOT FOUND'}")

    # Download code.html
    if code_url:
        try:
            code_path = os.path.join(output_dir, "code.html")
            urllib.request.urlretrieve(code_url, code_path)
            size = os.path.getsize(code_path)
            print(f"  Downloaded code.html ({size} bytes)")
        except Exception as e:
            print(f"  ERROR downloading code: {e}")

    # Download screen.png
    if img_url:
        try:
            img_path = os.path.join(output_dir, "screen.png")
            urllib.request.urlretrieve(img_url, img_path)
            size = os.path.getsize(img_path)
            print(f"  Downloaded screen.png ({size} bytes)")
        except Exception as e:
            print(f"  ERROR downloading image: {e}")

    return True


# Define all screens with their prompts
SCREENS = [
    ("tour_slide_2", """KhataPro mobile app tour screen 2 of 3: "Send reminders easily". Clean onboarding slide.

PAGE STRUCTURE:
1. Background: Solid #F2F3F5 fill (warm light grey)
2. Progress indicator: 3 horizontal dots at top-center — dot 1 grey (past), dot 2 filled Primary Blue (#1565C0) (active), dot 3 light grey — slide 2 of 3
3. Illustration area: Centered white rounded card illustration with a send/message action — shows a large circular send button in Secondary Green (#2E7D32), below that a green pill-shaped status bar showing "Reminder sent via WhatsApp", small avatar chips representing customers
4. Headline: Large bold "Send reminders easily" — center-aligned, dark on-surface
5. Body: "Send payment reminders via WhatsApp or SMS in one tap. Even attach your visiting card." — center-aligned, on-surface-variant grey
6. Swipe hint: Small uppercase "SWIPE TO EXPLORE" with chevron arrows — subtle 60% opacity
7. Sticky white footer: Full-width white bottom bar, pill "Next" primary button (blue fill), "Skip" text link below
ATMOSPHERE: Clean, trustworthy, Material Design 3, South Asian small business app"""),

    ("tour_slide_3", """KhataPro mobile app tour screen 3 of 3: "Your data, always safe". Final onboarding slide.

PAGE STRUCTURE:
1. Background: Solid #F2F3F5 fill
2. Progress indicator: 3 dots — dots 1 and 2 grey (past), dot 3 filled Primary Blue (active)
3. Illustration: White softly-rounded square card (240×240) centered, inside: large filled shield/verified_user Material icon in Primary Blue (#1565C0), below icon an "OFFLINE SAFE" pill badge in Secondary Green (#2E7D32) white text. Below the card: a horizontal row of 3 icon+label pairs: lock icon "PRIVATE", person icon "ANONYMOUS", phone icon "LOCAL" — all at 60% opacity in on-surface-variant
4. Headline: Large bold "Your data, always safe" — center-aligned
5. Body: "Everything is stored privately on your phone. No account needed. Works offline too." — center-aligned, on-surface-variant
6. NO swipe hint on last slide
7. Sticky white footer: "Get Started" primary button (blue fill, pill shape, full-width), "Skip" text link below
ATMOSPHERE: Trustworthy, secure, minimal, Material Design 3, South Asian small business"""),

    ("home_shell", """KhataPro mobile app home shell with bottom navigation bar. Material Design 3 mobile app.

PAGE STRUCTURE:
1. Full-screen mobile layout with status bar at top
2. Main content area (takes up most of screen): Shows the Dashboard tab as default selected — displays a balance card at top with "Total Balance" label, ₹ amount in large text, and two summary chips below (green income chip, red expense chip). Below that a "Recent" section header with transaction rows.
3. Bottom Navigation Bar (sticky at bottom, white/surface background, Material 3 NavigationBar style):
   - Tab 1: Home/dashboard icon + "Dashboard" label — ACTIVE state with primary blue (#1565C0) indicator pill and blue icon/label
   - Tab 2: receipt_long icon + "Ledger" label — inactive state, grey
   - Tab 3: people icon + "Customers" label — inactive state, grey
   - Tab 4: settings icon + "Settings" label — inactive state, grey
   - Active tab indicator: small primary blue rounded rectangle behind icon
4. NO floating action button at shell level
ATMOSPHERE: Material Design 3 NavigationBar, clean, professional financial app"""),

    ("dashboard", """KhataPro Dashboard screen — main financial overview for a small business owner.

PAGE STRUCTURE:
1. Top app bar: "KhataPro" title with menu/hamburger icon left, notification bell right
2. Hero Balance Card: Full-width card (#FFFFFF, 12px radius, subtle elevation), inside: "Total Balance" label small grey, large bold ₹8,300 amount in center (Primary Blue #1565C0), eye/visibility icon to toggle balance visibility (right side of amount). Below amount: two summary chips side by side in the card — left chip: green background (#A3F69C) with green text "↑ Income ₹12,500", right chip: red background (#FFDAD6) with red text "↓ Expense ₹4,200"
3. Section header: "Recent Transactions" bold label left, "See all" primary blue link right
4. Transaction list (5 rows):
   Row 1: Circle avatar "R" (primary container bg), "Ramesh Kumar" bold, "Today" grey small, right: "+₹2,000" green bold
   Row 2: Circle avatar "P" (secondary container bg), "Priya Stores" bold, "Yesterday" grey small, right: "-₹1,500" red bold
   Row 3: Circle avatar "M" (primary container bg), "Mohammed Ali" bold, "Apr 24" grey small, right: "+₹3,500" green bold
   Row 4: Circle avatar "S" (primary container bg), "Suresh Textiles" bold, "Apr 23" grey small, right: "-₹700" red bold
   Row 5: Circle avatar "A" (secondary container bg), "Anita Enterprises" bold, "Apr 22" grey small, right: "+₹1,200" green bold
5. FAB: Primary blue circular FAB bottom-right, "+" icon, with "Add Entry" label
ATMOSPHERE: Clean financial dashboard, Material Design 3, trustworthy, South Asian market"""),

    ("ledger_list", """KhataPro Ledger List screen — all transactions grouped by date.

PAGE STRUCTURE:
1. Top app bar: "Ledger" title
2. Search bar: Full-width rounded search input with search icon, placeholder "Search transactions..."
3. Date group header (sticky): "TODAY" small caps label, on-surface-variant color, left-aligned with subtle divider treatment
4. Transaction rows (3 rows under TODAY):
   Row 1: Circle avatar "R" (primary), "Ramesh Kumar" + "Grocery payment" note grey, right: "+₹2,000" green, 12px right
   Row 2: Circle avatar "P" (primary), "Priya Stores" + "Monthly dues", right: "-₹1,500" red
   Row 3: Circle avatar "M" (secondary), "Mohammed Ali" + "Balance paid", right: "+₹3,500" green
5. Date group header: "YESTERDAY" sticky header
6. Transaction rows (2 more rows similar style)
7. Pull-to-refresh indicator at top (subtle circular spinner)
8. FAB: Primary blue circle FAB bottom-right with "+" icon and "Add Entry" label
9. Bottom spacing to avoid FAB overlap
ATMOSPHERE: List view, Material Design 3, grouped by date, financial app"""),

    ("ledger_add", """KhataPro Add Transaction screen — full-screen form to add a new ledger entry.

PAGE STRUCTURE:
1. Top app bar: "Add Transaction" title, X (close) icon on the right
2. Toggle chips row at top of form: Two large segmented chips full width:
   - Left: "Got paid" chip — when selected shows Secondary Green (#2E7D32) background, white text, checkmark icon; unselected shows outline
   - Right: "Paid out" chip — when selected shows Tertiary Red (#C62828) background, white text; unselected shows outline
   Show "Got paid" as currently selected (green)
3. Amount field: Large, prominent, ₹ prefix in primary blue, large number input "1,250" in bold large font (heading scale), full-width, grey underline or minimal border
4. Customer name field: Label "Customer Name", text input with trailing contact-picker icon (person_add), placeholder "Select or type name"
5. Note field: Label "Note (optional)", multiline text input, placeholder "e.g. March dues, advance payment..."
6. Date field: Label "Date", text input showing "Today, Apr 26" with calendar icon trailing
7. Save button: Full-width pill button (#1565C0 blue, white text, "Save Transaction"), fixed at bottom above home indicator
ATMOSPHERE: Clean form, Material Design 3, prominent amount input, financial app"""),

    ("ledger_detail", """KhataPro Transaction Detail screen — read-only view of a single transaction.

PAGE STRUCTURE:
1. Top app bar: back arrow left, "Transaction" title, three-dot menu right
2. Hero section at top: Large centered amount "+₹2,000" in Secondary Green (#2E7D32), bold display typography, below it: "RECEIVED" pill badge in green container
3. Customer info row: Large circle avatar "R" (primary container), "Ramesh Kumar" bold, phone number grey small below
4. Details card (white, 12px radius):
   Row: calendar icon + "Date" label left, "April 26, 2026" right
   Row: note icon + "Note" label left, "Grocery payment for March" right
   Row: tag icon + "Type" label left, green "Income" chip right
5. Status card: "Payment Status" label, large "PAID" green pill badge
6. Action buttons row at bottom (above keyboard safe area):
   - "Edit" outlined button left (primary blue outline, blue text, half width)
   - "Delete" filled button right (tertiary red fill, white text, half width)
ATMOSPHERE: Detail view, clean, Material Design 3, financial transaction"""),

    ("customer_list", """KhataPro Customer List screen — list of all business contacts with outstanding balances.

PAGE STRUCTURE:
1. Top app bar: "Customers" title
2. Search bar: Full-width rounded "Search customers..." input
3. Customer list (6 rows, sorted by outstanding amount desc):
   Row 1: Circle "R" avatar (primary container bg), "Ramesh Kumar" bold + "+91 98765 43210" grey, right: "+₹5,500" green bold (they owe you)
   Row 2: Circle "M" avatar, "Mohammed Ali" + "+91 87654 32109", right: "+₹3,500" green
   Row 3: Circle "A" avatar, "Anita Enterprises" + "+91 76543 21098", right: "+₹2,200" green
   Row 4: Circle "S" avatar, "Suresh Textiles" + "+91 65432 10987", right: "-₹1,800" red (you owe them)
   Row 5: Circle "P" avatar, "Priya Stores" + "+91 54321 09876", right: "+₹700" green
   Row 6: Circle "K" avatar, "Kavitha Silks" + "+91 43210 98765", right: "-₹400" red
4. FAB: Primary blue "+" FAB bottom-right with "Add Customer" label
ATMOSPHERE: Clean contact list, Material Design 3, financial amounts right-aligned"""),

    ("customer_detail", """KhataPro Customer Detail screen — detailed view of one customer with transaction history.

PAGE STRUCTURE:
1. Top app bar: back arrow, "Customer" title, three-dot menu
2. Customer header card (surface container low bg):
   Large circle avatar "R" (64dp, primary container), "Ramesh Kumar" bold large, "+91 98765 43210" grey below name
   Outstanding balance: "Outstanding" label grey small, "+₹5,500" in large Secondary Green bold
3. Action buttons row (two buttons side by side):
   - "Remind" button: secondary outlined with WhatsApp icon left, green border and text
   - "Add Entry" button: primary blue filled, white text, "+" icon
4. Section header: "Transaction History" bold
5. Date header: "APRIL 2026" sticky label caps grey
6. Transaction rows (4 rows):
   Row 1: "Apr 26" date, "Grocery payment" note, "+₹2,000" green
   Row 2: "Apr 20" date, "Monthly dues" note, "+₹3,500" green
   Row 3: "Apr 15" date, "Advance taken" note, "-₹800" red (you gave advance)
   Row 4: "Apr 10" date, "Balance settled" note, "+₹800" green
ATMOSPHERE: Customer profile, transaction history, Material Design 3, South Asian app"""),

    ("customer_add", """KhataPro Add Customer screen — form to add a new business contact.

PAGE STRUCTURE:
1. Top app bar: "Add Customer" title, X close icon right
2. Form fields (with labels above each):
   Field 1: "Name *" label, text input placeholder "Full name or business name", person icon leading
   Field 2: "Phone Number" label, input with +91 country code prefix (grey), "98765 43210" placeholder, phone icon leading
   Field 3: "Opening Balance" label, ₹ prefix, number input "0.00"
3. Toggle below opening balance: "Who owes whom?" section with two toggle chips:
   - "They owe me" — Secondary Green selected state (green bg, white text) meaning they owe the user money
   - "I owe them" — unselected outlined chip
4. Helper text below toggle: "Set this if they have an existing balance from before." grey small
5. Save button: Full-width pill at bottom "#1565C0 blue, "Add Customer" label, white text
ATMOSPHERE: Simple form, Material Design 3, contact addition, financial app"""),

    ("reports_home", """KhataPro Reports Home screen — financial summary and analytics overview.

PAGE STRUCTURE:
1. Top app bar: "Reports" title
2. Period selector: Segmented control row with 4 tabs: "Day" | "Week" | "Month" (selected, primary blue indicator) | "Custom"
3. Summary cards row (3 cards, horizontal scroll or grid):
   Card 1: Green header, "Total Income" label, "₹12,500" large green bold
   Card 2: Red header, "Total Expense" label, "₹4,200" large red bold
   Card 3: Blue header, "Net Balance" label, "₹8,300" large blue bold
4. Bar chart section: "Income vs Expense" section header. Simple bar chart with 7 days (Mon-Sun), each day has two bars — green bar for income, red bar for expense. X-axis: day labels. Y-axis: ₹ amounts. Chart is clean and minimal.
5. "Top Customers" section header
6. Customer rows (3):
   Row 1: Avatar "R", "Ramesh Kumar", "+₹5,500" green right
   Row 2: Avatar "M", "Mohammed Ali", "+₹3,500" green right
   Row 3: Avatar "S", "Suresh Textiles", "-₹1,800" red right
ATMOSPHERE: Analytics dashboard, clean charts, Material Design 3, financial reporting"""),

    ("reports_pnl", """KhataPro Profit & Loss report screen — detailed P&L breakdown.

PAGE STRUCTURE:
1. Top app bar: back arrow, "P&L Report" title, share icon right. Subtitle: "April 2026"
2. Income section:
   Section header: "INCOME" label with green left border accent, total "₹12,500" right green
   Itemized rows (3):
   - "Customer Payments" ₹8,500 grey/right
   - "Sales Revenue" ₹3,000 grey/right
   - "Other Income" ₹1,000 grey/right
3. Divider with subtle tonal shift
4. Expense section:
   Section header: "EXPENSES" label with red left border accent, total "₹4,200" right red
   Itemized rows (3):
   - "Supplier Payments" ₹2,500 grey/right
   - "Operating Costs" ₹1,200 grey/right
   - "Miscellaneous" ₹500 grey/right
5. Net P&L banner: Prominent full-width card, "NET PROFIT" label center, large "₹8,300" in Primary Blue bold extra-large, green up-arrow icon
6. Export button: outlined pill "Export PDF" at bottom
ATMOSPHERE: Financial report, accounting aesthetic, Material Design 3, professional"""),

    ("reports_cashflow", """KhataPro Cash Flow report screen — cash movement over time visualization.

PAGE STRUCTURE:
1. Top app bar: back arrow, "Cash Flow" title, share icon right
2. Period selector: Segmented "Week | Month | Quarter" — Month selected
3. Line chart: Clean line chart showing cash balance over 30 days. Line starts at ₹5,000, goes up to ₹8,300. Area below line filled with gradient: above zero line uses green tinted fill (#A3F69C at 30% opacity), theoretically below zero would be red tinted. X-axis: dates (Apr 1 — Apr 30 with key dates labeled). Y-axis: ₹ amounts. Chart has subtle grid lines.
4. Stats row below chart: 3 stat chips in a row:
   - "Peak" ₹9,100 green
   - "Low" ₹4,200 grey
   - "Avg" ₹6,800 blue
5. "Daily Transactions" section header
6. Data table (5 rows): Date | Description | Amount columns. Amount green or red.
   Apr 26 | Ramesh Kumar | +₹2,000 (green)
   Apr 25 | Priya Stores | -₹1,500 (red)
   Apr 24 | Mohammed Ali | +₹3,500 (green)
   Apr 23 | Suresh Textiles | -₹700 (red)
   Apr 22 | Anita Enterprises | +₹1,200 (green)
ATMOSPHERE: Data visualization, clean chart, Material Design 3, financial analytics"""),

    ("settings_home", """KhataPro Settings screen — grouped settings list.

PAGE STRUCTURE:
1. Top app bar: "Settings" title
2. Settings groups with section headers (grouped list Material Design 3 style):
   GROUP 1 header: "Business"
   Row: store/business icon + "Business Profile" label + trailing chevron
   Row: language icon + "Language" label + "English" subtitle grey + trailing chevron
   Row: brightness icon + "Theme" label + "System" subtitle grey + trailing chevron

   GROUP 2 header: "Data"
   Row: backup icon + "Backup & Restore" label + trailing chevron
   Row: download/export icon + "Export CSV" label + trailing chevron

   GROUP 3 header: "About"
   Row: info icon + "Version" label + "1.0.0" subtitle grey right
   Row: privacy_tip icon + "Privacy Policy" label + trailing chevron
   Row: description icon + "Open Source Licenses" label + trailing chevron

   DESTRUCTIVE SECTION (no header, at bottom with top margin):
   Row: delete_forever icon (tertiary red #C62828) + "Clear All Data" label (red) — no chevron, destructive action
3. Bottom padding
ATMOSPHERE: Settings page, Material Design 3 grouped list, clean, professional"""),

    ("settings_business", """KhataPro Business Profile settings screen — edit business information.

PAGE STRUCTURE:
1. Top app bar: back arrow, "Business Profile" title, "Save" text button right (primary blue)
2. Business logo section: Centered circle placeholder (120dp) with upload/camera icon in center, "Tap to upload logo" caption grey below — dashed border circle style
3. Form fields (with labels):
   Field 1: "Business Name *" — text input "My Kirana Store" prefilled, store icon leading
   Field 2: "Business Type" — dropdown/select showing "Kirana Store", with dropdown arrow, options include: Kirana Store, Restaurant, Salon, Medical Store, Clothes Store, Electronics, Other
   Field 3: "Owner Name" — text input "Ramesh Kumar"
   Field 4: "Phone" — "+91 98765 43210" with phone icon
4. Save button: Full-width pill "#1565C0 blue "Save Changes" at bottom
ATMOSPHERE: Business settings form, Material Design 3, clean, professional setup"""),

    ("settings_language", """KhataPro Language Selection screen — choose app language from 8 supported languages.

PAGE STRUCTURE:
1. Top app bar: back arrow, "Language" title
2. Subtitle text: "Choose your preferred language. Changes take effect immediately." — grey small, left-aligned with 16px padding
3. Language grid (2-column grid, 8 items = 4 rows):
   Col1: "English" card — SELECTED state: primary blue (#1565C0) border (2px), primary blue checkmark icon top-right, "English" bold label center, "EN" code grey small below
   Col1: "বাংলা" card — unselected: subtle outline, "Bengali" grey label below
   Col1: "ಕನ್ನಡ" card — "Kannada"
   Col1: "മലയാളം" card — "Malayalam"
   Col2: "हिन्दी" card — "Hindi"
   Col2: "मराठी" card — "Marathi"
   Col2: "தமிழ்" card — "Tamil"
   Col2: "తెలుగు" card — "Telugu"
   Each card: white bg, 12px radius, 4px blue border when selected, checkmark icon, native script large + romanization small
4. Note: "The app will restart to apply the language change." — grey small at bottom
ATMOSPHERE: Language picker, 2-column grid, Material Design 3, clear selection state"""),

    ("settings_theme", """KhataPro Theme Selection screen — choose light, dark, or system theme.

PAGE STRUCTURE:
1. Top app bar: back arrow, "Theme" title
2. Subtitle: "Choose how KhataPro looks. Takes effect immediately." grey small below app bar
3. Three large theme option cards (full-width, stacked vertically, 16px gap):
   Card 1: "Light" — selected with primary blue (#1565C0) 2px border, blue checkmark top-right, sun icon (large, 40dp) in primary blue center, "Light" label bold, "Bright and clean interface" subtitle grey. Background: white.
   Card 2: "Dark" — unselected, moon icon large, "Dark" label, "Easy on the eyes at night" subtitle. Dark preview showing dark surface background in miniature.
   Card 3: "System Default" — unselected, phone/contrast icon, "System Default" label, "Follows your device setting" subtitle.
   Each card: white surface, 12px radius, when selected: 2px primary blue border + checkmark badge
4. Helper text at bottom: "Changes apply instantly without restarting." grey small
ATMOSPHERE: Theme selection, large tap targets, clear selection state, Material Design 3"""),

    ("settings_backup", """KhataPro Backup & Restore settings screen — data export and backup options.

PAGE STRUCTURE:
1. Top app bar: back arrow, "Backup & Restore" title
2. Export section header: "Export Data"
3. Two primary action cards (white, 12px radius, subtle shadow):
   Card 1: "Export to CSV" — table/grid icon (primary blue, 40dp), "Export to CSV" bold, "Compatible with Excel and Google Sheets" subtitle grey, full-width outlined "Export CSV" button with download icon
   Card 2: "Export to PDF" — pdf icon (tertiary red, 40dp), "Export to PDF" bold, "Professional report for sharing" subtitle grey, full-width outlined "Export PDF" button
4. Divider with "Cloud Backup" section header
5. Google Drive backup row: Google Drive icon left, "Google Drive Backup" bold + "Last backup: Never" grey small, toggle switch right (off state)
6. Warning card (amber/warning background, subtle): warning icon + "Enabling cloud backup requires Google sign-in. Your data will be uploaded to your private Google Drive." text
7. Restore section: "Restore from Backup" text button (primary blue, centered) with upload icon. Below: "(This will overwrite all current data)" warning text in tertiary red small
ATMOSPHERE: Data management screen, Material Design 3, backup safety, warning states"""),

    ("settings_about", """KhataPro About screen — app information, version, and links.

PAGE STRUCTURE:
1. Top app bar: back arrow, "About" title
2. App identity section (center-aligned):
   App icon/logo: 80dp rounded square, Primary Blue (#1565C0) background, white ledger/account_balance icon or "K" letter bold white inside
   App name: "KhataPro" bold large
   Version: "Version 1.0.0 (Build 1)" grey small
   Tagline: "Simple bookkeeping for every business" italic grey
3. Divider
4. Links list (Material Design 3 list, full-width rows):
   Row: star icon (amber) + "Rate the App" bold + "Tell us what you think" grey subtitle + trailing chevron
   Row: privacy_tip icon + "Privacy Policy" + trailing chevron
   Row: description icon + "Terms of Service" + trailing chevron
   Row: code icon + "Open Source Licenses" + trailing chevron
5. Footer (centered, bottom of screen):
   "Made with ♥ for small businesses" grey small
   "© 2026 KhataPro" grey small
ATMOSPHERE: About screen, Material Design 3, app info, clean, professional links list"""),
]


def main():
    print(f"Starting generation of {len(SCREENS)} screens...")
    print(f"Project ID: {PROJECT_ID}")

    results = {}

    for screen_name, prompt in SCREENS:
        # Check if already generated
        code_path = os.path.join(BASE_DIR, screen_name, "code.html")
        if os.path.exists(code_path) and os.path.getsize(code_path) > 1000:
            print(f"\nSKIPPING {screen_name} (already exists)")
            results[screen_name] = "skipped"
            continue

        success = generate_screen(screen_name, prompt)
        results[screen_name] = "success" if success else "failed"

        # Small delay to avoid rate limiting
        time.sleep(2)

    print("\n" + "="*60)
    print("GENERATION COMPLETE")
    print("="*60)
    for name, status in results.items():
        print(f"  {name}: {status}")


if __name__ == "__main__":
    main()
