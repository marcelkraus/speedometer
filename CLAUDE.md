# CLAUDE.md – Speedometer

## Project Overview

Speedometer ("How Fast Am I?") is a focused, single-purpose iOS app that displays the device's GPS-derived speed in multiple units alongside geographic coordinates. It is available free of charge on the App Store (ID: 1361655713). A one-time in-app purchase unlocks additional themes via a "tip jar" model.

- **Platform:** iOS (iPhone only)
- **Minimum deployment target:** iOS 17.6
- **Swift version:** 5.0
- **Localization:** English (development language) and German
- **Bundle ID:** `de.marcelkraus.speedometer`

---

## Architecture

The app follows a "Better MVC" pattern (per Dave DeLong's approach). Key principles:

- **No Storyboards for app screens** – all UI is built programmatically with Auto Layout. Only `LaunchScreen.storyboard` exists.
- **Container-based view controllers** – `RootViewController` manages child view controllers and transitions between them based on location authorization state.
- **Protocol-based delegation** – all cross-VC communication uses `weak var delegate` with custom protocols.
- **Global state via `AppDelegate.shared`** – theme and supporter status are stored here and accessed app-wide.

### VC hierarchy

```
AppDelegate → RootViewController
    ├── LoadingViewController       (brief, shown during auth check)
    ├── OnboardingViewController    (CLAuthorizationStatus.notDetermined)
    ├── MessageViewController       (.restricted or .denied)
    └── ContentViewController       (.authorizedWhenInUse / .authorizedAlways)
            ├── SpeedViewController     (large speed readout + unit badge)
            └── LocationViewController  (DMS coordinates)
```

`ContentViewController` also embeds a `CircularView` (quarter-arc gauge) and opens `SettingsViewController` modally via the Info button.

---

## Project Structure

```
Speedometer/
├── AppDelegate.swift                   # Entry point, RevenueCat setup, global state
├── RootViewController.swift            # CLLocationManager, authorization, VC transitions
├── Helpers/
│   ├── ActionHandlerSleeve+Extension.swift   # UIButton.addAction { } closure helper
│   ├── StoreKitReviewHelper.swift            # SKStoreReviewController logic (start 5, then every 10)
│   ├── String+Localization.swift             # String.localized computed property
│   └── UIViewController+Transition.swift    # Crossfade transition helper
├── Model/
│   ├── Location.swift                  # Struct with lat/lon, DMS formatting
│   ├── Message.swift                   # Enum for onboarding/denied/restricted screens
│   └── Unit.swift                      # Enum for speed units, conversion, formatting
├── Supporting Files/
│   ├── Assets.xcassets/                # App icon, named color sets per theme
│   ├── Alternate App Icons/            # Blueberry, Orange, Raspberry PNGs
│   ├── Fonts/                          # SourceCodePro-Medium.ttf, SourceCodePro-Regular.ttf
│   ├── Localizable.xcstrings           # All UI strings (en + de)
│   ├── InfoPlist.xcstrings             # App display name + location usage description
│   ├── Key.swift                       # UserDefaults key constants
│   ├── Theme.swift                     # Theme enum with colors and fonts
│   └── LaunchScreen.storyboard
└── Views/
    ├── Components/
    │   ├── BlockingOverlayViewController.swift   # Full-screen overlay during IAP
    │   ├── CircularView.swift                    # Quarter-arc speed gauge (CAShapeLayer)
    │   ├── FillableCircleView.swift              # Theme selector dot (filled/outlined)
    │   ├── InAppStoreViewController.swift        # RevenueCat tip jar UI
    │   ├── LocationViewController.swift          # DMS coordinate display
    │   ├── ParagraphViewController.swift         # Generic heading + text view
    │   └── SpeedViewController.swift             # Speed number + unit badge
    └── Screens/
        ├── ContentViewController.swift           # Main speedometer screen
        ├── LoadingViewController.swift
        ├── MessageViewController.swift
        ├── OnboardingViewController.swift
        └── SettingsViewController.swift          # Themes (supporters) or IAP (others)
SpeedometerTests/
└── Model/
    ├── LocationTests.swift             # DMS formatting tests
    └── UnitTests.swift                 # Speed conversion and unit cycling tests
```

---

## Key Components

### `Unit` (Model/Unit.swift)
Enum with five cases: `.kilometersPerHour`, `.milesPerHour`, `.metersPerSecond`, `.knots`, `.split500`. Default is locale-driven (metric → km/h, otherwise mph). Key behaviors:
- `calculateSpeed(for:)` converts m/s from CLLocation; returns 0 below 0.5 m/s threshold.
- `calculcateFillment(for:)` returns 0.0–1.0 for the gauge; max reference is 66.67 m/s (normal units) or 7.0 (split500).
- `localizedString(for:)` formats as integer or `M:SS` for split500.
- `next` cycles to the next case and persists the selection to UserDefaults.

### `Theme` (Supporting Files/Theme.swift)
Enum: `.pear` (free, default), `.blueberry`, `.orange`, `.raspberry` (all require supporter status). Provides:
- Colors: `backgroundColor`, `primaryContentColor`, `secondaryContentColor`, `interactionColor` (named color asset, light+dark), `onInteractionColor`.
- Fonts: `speedFont` (92pt system thin), others use Dynamic Type text styles.
- Theme selection also sets the matching alternate app icon via `setAlternateIconName`.

### `AppDelegate` (AppDelegate.swift)
Global state holder accessed via `AppDelegate.shared`:
- `theme: Theme` – persisted to UserDefaults.
- `isSupporter: Bool` – fetched from RevenueCat entitlement `"supporter"`.
- `updateUserStatus()` – calls `Purchases.shared.getCustomerInfo` to refresh supporter status.

### `RootViewController` (RootViewController.swift)
Owns the single `CLLocationManager` instance. Handles authorization changes and routes to the correct child VC with a crossfade transition.

---

## Dependencies

Managed via **Swift Package Manager** (no CocoaPods, no Carthage).

| Package | Version | Purpose |
|---------|---------|---------|
| `purchases-ios` (RevenueCat) | 5.60.0 (min: 5.3.3) | In-app purchases, entitlement management |

RevenueCat is configured with `upToNextMajorVersion` from 5.3.3. The SDK uses **StoreKit 2** by default in v5 (iOS 15+); since the deployment target is 17.6, SK2 is always used.

---

## In-App Purchases

Implemented in `InAppStoreViewController`. Uses RevenueCat exclusively – there is no direct StoreKit code for purchases.

**Flow:**
1. `getOfferings` fetches available packages; each gets a price button.
2. Tapping a button calls `tipSelectionViewControllerWillPurchaseProduct` (shows blocking overlay), then `Purchases.shared.purchase(package:)`.
3. On success: `updateUserStatus()` refreshes entitlements → `tipSelectionViewControllerDidPurchaseProduct` → overlay dismissed after 0.5s, confirmation alert shown.
4. On cancel or error: `tipSelectionViewControllerCouldNotPurchaseProduct` → overlay dismissed immediately.
5. Restore: `Purchases.shared.restorePurchases` re-checks `allPurchasedProductIdentifiers`.

**Entitlement identifier:** `"supporter"`

**Gate:** `SettingsViewController` checks `AppDelegate.shared.isSupporter` at view construction time to show either the IAP section or theme selection. Settings must be reopened after purchase for the theme UI to appear (the confirmation dismiss achieves this automatically).

---

## Localization

Uses Xcode String Catalogs (`.xcstrings`). Languages: `en` (development), `de`.

Key convention: dot-separated namespace, e.g. `"Message.Onboarding.Heading"`, `"Theme.Blueberry.Name"`, `"InAppStoreViewController.Description"`.

Usage in code: `"SomeKey".localized` (via `String+Localization.swift` which wraps `NSLocalizedString`).

App name: "Speedometer" (en) / "Tacho" (de).

---

## Coding Conventions

- All UI built programmatically; `translatesAutoresizingMaskIntoConstraints = false` on every view.
- `lazy var` properties with inline configuration closures for all UI components.
- `NSLayoutConstraint.activate([...])` exclusively for constraints.
- `private extension MyClass { }` to group private methods.
- `// MARK: -` comments to separate file sections.
- `@available(*, unavailable)` on `init?(coder:)` in all programmatic view controllers.
- No force-unwrapping except `fatalError()` for truly unreachable states.
- **SwiftFormat** is configured (`.swiftformat`): `--self init-only` (no redundant `self.` outside `init`), `--swiftversion 5`. Run SwiftFormat before committing.
- Commit messages: short, imperative, present tense (e.g. `Fix warnings`, `Update RevenueCat SDK to v5.60.0`).

---

## Testing

Framework: XCTest (`@testable import Speedometer`).

Only model-layer logic is tested. Tests mirror the app's `Model/` group structure under `SpeedometerTests/Model/`.

- `LocationTests`: DMS coordinate formatting.
- `UnitTests`: Speed conversion, minimum threshold (0.5 m/s), unit cycling order.

No UI tests. No snapshot tests.

Run tests via Xcode (`Cmd+U`) or:
```
xcodebuild test -scheme Speedometer -destination 'platform=iOS Simulator,name=iPhone 16'
```

---

## Git Workflow

- **`main`** – stable releases only.
- **`develop`** – active development; not considered stable.
- PRs should be based on `main`.
- No CI/CD configuration is present.
