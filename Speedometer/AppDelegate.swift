import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    static var shared = AppDelegate()

    private(set) var theme: Theme = .selected {
        didSet {
            UserDefaults.standard.set(theme.rawValue, forKey: Key.selectedTheme)
        }
    }

    let purchaseManager = PurchaseManager()

    var isSupporter: Bool {
        purchaseManager.isSupporter
    }

    func applicationDidFinishLaunching(_ application: UIApplication) {
        AppDelegate.shared = self

        purchaseManager.start()
        setDefaultSettings()

        StoreReviewHelper.incrementAppStartCounter()
        application.isIdleTimerDisabled = true

        migrateTo12()
    }

    func setTheme(_ theme: Theme) {
        self.theme = theme
    }
}

private extension AppDelegate {
    func setDefaultSettings() {
        let defaultUnit = Unit.selected
        let defaultTheme = Theme.selected

        UserDefaults.standard.register(defaults: [
            Key.appStartCounter: 0,
            Key.selectedUnit: defaultUnit.rawValue,
            Key.selectedTheme: defaultTheme.rawValue,
        ])
    }

    func migrateTo12() {
        // Old Raw Value (Int): New Raw Value (String)
        let migrationTable: [Int: String] = [
            1: "km/h",
            2: "mph",
            3: "m/s",
            4: "kn",
        ]

        let currentUnit = UserDefaults.standard.integer(forKey: Key.selectedUnit)
        guard 1 ... 4 ~= currentUnit else {
            return
        }

        UserDefaults.standard.set(migrationTable[currentUnit]!, forKey: Key.selectedUnit)
    }
}
