# Speedometer

## Project Overview

Speedometer (“How Fast Am I?”) is a focused, single-purpose iOS app that displays the device's GPS-derived speed in multiple units alongside geographic coordinates. It is available free of charge on the App Store (ID: 1361655713). A one-time in-app purchase unlocks additional themes via a “tip jar” model.

- **Platform:** iOS (iPhone only)
- **Minimum deployment target:** iOS 17.6
- **Swift version:** 5.0
- **Localization:** English (development language) and German
- **Bundle ID:** `de.marcelkraus.speedometer`

## Status

- The app stays on sale and gets bug fixes and maintenance only, no new features.

## Architecture

The app follows a “Better MVC” pattern (per Dave DeLong's approach). Key principles:

- **No Storyboards for app screens**—all UI is built programmatically with Auto Layout. Only `LaunchScreen.storyboard` exists.
- **Container-based view controllers**—`RootViewController` manages child view controllers and transitions between them based on location authorization state.
- **Protocol-based delegation**—all cross-VC communication uses `weak var delegate` with custom protocols.
- **Global state via `AppDelegate.shared`**—theme and supporter status are stored here and accessed app-wide.

### VC hierarchy

```
SceneDelegate → RootViewController
    ├── LoadingViewController       (brief, shown during auth check)
    ├── OnboardingViewController    (CLAuthorizationStatus.notDetermined)
    ├── MessageViewController       (.restricted or .denied)
    └── ContentViewController       (.authorizedWhenInUse / .authorizedAlways)
            ├── SpeedViewController     (large speed readout + unit badge)
            └── LocationViewController  (DMS coordinates)
```

`ContentViewController` also embeds a `CircularView` (quarter-arc gauge) and opens `SettingsViewController` modally via the Info button.

## Project Structure

```
Speedometer/
├── AppDelegate.swift                   # Entry point, purchase manager, global state
├── SceneDelegate.swift                 # Creates the window with RootViewController
├── RootViewController.swift            # CLLocationManager, authorization, VC transitions
├── Helpers/
│   ├── ActionHandlerSleeve+Extension.swift   # UIButton.addAction { } closure helper
│   ├── PurchaseManager.swift                 # StoreKit 2 tips and supporter status
│   ├── StoreKitReviewHelper.swift            # Review request once the window exists (start 5, then every 10)
│   ├── String+Localization.swift             # String.localized computed property
│   └── UIViewController+Transition.swift    # Crossfade transition helper
├── Model/
│   ├── Location.swift                  # Struct with lat/lon, DMS formatting
│   ├── Message.swift                   # Enum for onboarding/denied/restricted screens
│   └── Unit.swift                      # Enum for speed units, conversion, formatting
├── Supporting Files/
│   ├── Alternate App Icons/            # Blueberry, Orange, Raspberry PNGs
│   ├── Assets.xcassets/                # App icon, named color sets per theme
│   ├── Fonts/                          # SourceCodePro-Medium.ttf, SourceCodePro-Regular.ttf
│   ├── Info.plist                      # App Info.plist, not bundled as a resource
│   ├── InfoPlist.xcstrings             # App display name + location usage description
│   ├── Key.swift                       # UserDefaults key constants
│   ├── LaunchScreen.storyboard
│   ├── Localizable.xcstrings           # All UI strings (en + de)
│   ├── PrivacyInfo.xcprivacy           # Privacy manifest (UserDefaults, reason CA92.1)
│   ├── StoreKit Configuration.storekit # Local tip products, set in the scheme, not bundled
│   └── Theme.swift                     # Theme enum with colors and fonts
└── Views/
    ├── Components/
    │   ├── BlockingOverlayViewController.swift   # Full-screen overlay during IAP
    │   ├── CircularView.swift                    # Quarter-arc speed gauge (CAShapeLayer)
    │   ├── FillableCircleView.swift              # Theme selector dot (filled/outlined)
    │   ├── InAppStoreViewController.swift        # Tip jar UI
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
├── Helpers/
│   └── PurchaseManagerTests.swift      # Tip purchases against the StoreKit configuration
├── Info.plist                          # Test bundle Info.plist, not bundled as a resource
└── Model/
    ├── LocationTests.swift             # DMS formatting tests
    └── UnitTests.swift                 # Speed conversion and unit cycling tests
```

`Speedometer/` and `SpeedometerTests/` are synchronized folders (`PBXFileSystemSynchronizedRootGroup`, project format `objectVersion = 100`). Membership follows the file system: a new file inside them belongs to its target the moment it exists, and no entry has to be added to `project.pbxproj`. `Supporting Files/Info.plist`, `Supporting Files/StoreKit Configuration.storekit` and `SpeedometerTests/Info.plist` are the declared exceptions, so they are not copied into a bundle as resources.

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
- `theme: Theme`—persisted to UserDefaults.
- `purchaseManager: PurchaseManager`—started in `applicationDidFinishLaunching`.
- `isSupporter: Bool`—read from `purchaseManager`.

### `RootViewController` (RootViewController.swift)
Owns the single `CLLocationManager` instance. Handles authorization changes and routes to the correct child VC with a crossfade transition.

## Dependencies

None. The app uses Apple frameworks only and talks to no third party.

## In-App Purchases

StoreKit 2 in `PurchaseManager`, shown by `InAppStoreViewController`. The three tips (`de.marcelkraus.speedometer.tip.incentive.small`, `.medium`, `.large`) are **non-consumable**, so `Transaction.currentEntitlements` returns them without a server—tips from earlier versions included.

**Supporter:** any verified, unrevoked entry in `Transaction.currentEntitlements`. `PurchaseManager.start()` derives it at launch and listens to `Transaction.updates`, finishing every verified transaction.

**Flow:**
1. `products()` loads the tips by ID, sorted by price; each gets a button titled with `displayPrice`. A failed or empty load shows the fallback message.
2. Tapping a button calls `tipSelectionViewControllerWillPurchaseProduct` (shows blocking overlay), then `purchase(_:in:)`, which confirms the purchase in the window scene.
3. On a verified purchase: the transaction is finished, the supporter status refreshed → `tipSelectionViewControllerDidPurchaseProduct` → overlay dismissed after 0.5s, confirmation alert shown.
4. On cancel, pending (Ask to Buy) or error: `tipSelectionViewControllerCouldNotPurchaseProduct` → overlay dismissed immediately. A pending purchase arrives later through `Transaction.updates`.
5. Restore: `restore()` runs `AppStore.sync()` and shows the confirmation alert when the user is a supporter afterwards.

**Local testing:** the scheme's run action uses `Supporting Files/StoreKit Configuration.storekit` with the App Store prices in euros (1.99, 3.99, 7.99).

**Gate:** `SettingsViewController` checks `AppDelegate.shared.isSupporter` at view construction time to show either the IAP section or theme selection. Settings must be reopened after purchase for the theme UI to appear (the confirmation dismiss achieves this automatically).

## Localization

Uses Xcode String Catalogs (`.xcstrings`). Languages: `en` (development), `de`.

Key convention: dot-separated namespace, e.g. `"Message.Onboarding.Heading"`, `"Theme.Blueberry.Name"`, `"InAppStoreViewController.Description"`.

Usage in code: `"SomeKey".localized` (via `String+Localization.swift` which wraps `NSLocalizedString`).

App name: “Speedometer” (en) / “Tacho” (de).

## Coding Conventions

- All UI built programmatically; `translatesAutoresizingMaskIntoConstraints = false` on every view.
- `lazy var` properties with inline configuration closures for all UI components.
- `NSLayoutConstraint.activate([...])` exclusively for constraints.
- `private extension MyClass { }` to group private methods.
- `@available(*, unavailable)` on `init?(coder:)` in all programmatic view controllers.
- No force-unwrapping except `fatalError()` for truly unreachable states.
- **SwiftFormat** is configured (`.swiftformat`): `--self init-only` (no redundant `self.` outside `init`), `--swiftversion 5`. Run SwiftFormat before committing.

## Testing

Framework: XCTest (`@testable import Speedometer`).

Model logic and the purchase manager are tested. Tests mirror the app's folder structure under `SpeedometerTests/`.

- `LocationTests`: DMS coordinate formatting.
- `PurchaseManagerTests`: the three tips, purchase, failed and pending purchase, restore with and without an earlier tip, supporter status at start, refund. They run against `Supporting Files/StoreKit Configuration.storekit` through `StoreKitTest` and need the host app for its window scene; a user canceling a purchase cannot be simulated there.
- `UnitTests`: Speed conversion, minimum threshold (0.5 m/s), unit cycling order.

No UI tests. No snapshot tests.

Run tests via Xcode (`Cmd+U`) or:
```
xcodebuild test -scheme Speedometer -destination 'platform=iOS Simulator,name=iPhone 16'
```

## Releases

- Git flow: `release/vX.Y.Z` branches off `develop`, is merged into `main` with an annotated tag and back into `develop`.
- No CI/CD configuration is present.
- `CHANGELOG.md` is written in English and follows Keep a Changelog.
- Change `MARKETING_VERSION` directly in `project.pbxproj`. Editing it in the Xcode target editor moves keys from `Info.plist` into build settings.
