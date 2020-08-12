import Purchases
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private static let revenueCatApiKey = "qzefGtCYnlDdBkhjXZpKYVEHvFgSnatV"

    static var shared = AppDelegate()

    var window: UIWindow?

    private(set) var theme = Theme.default

    func applicationDidFinishLaunching(_ application: UIApplication) {
        AppDelegate.shared = self

        PaymentTransactionObserver.sharedInstance.register()

        setupTheme()
        setupRevenueCat()
        setDefaultSettings()

        StoreReviewHelper.incrementAppStartCounter()
        application.isIdleTimerDisabled = true

        migrateTo12()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = theme.backgroundColor
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        PaymentTransactionObserver.sharedInstance.deregister()
    }
}

private extension AppDelegate {
    func setupTheme() {
        // TODO
    }

    func setupRevenueCat() {
        Purchases.debugLogsEnabled = true
        Purchases.configure(withAPIKey: Self.revenueCatApiKey, appUserID: nil, observerMode: true)
    }

    func setDefaultSettings() {
        let defaultUnit = Unit.default

        UserDefaults.standard.register(defaults: [
            Key.appStartCounter: 0,
            Key.selectedUnit: defaultUnit.rawValue,
        ])
    }

    func migrateTo12() {
        // Old Raw Value (Int): New Raw Value (String)
        let migrationTable: [Int: String] = [
            1: "km/h",
            2: "mph",
            3: "m/s",
            4: "kn"
        ]

        let currentUnit = UserDefaults.standard.integer(forKey: Key.selectedUnit)
        guard 1...4 ~= currentUnit else {
            return
        }

        UserDefaults.standard.set(migrationTable[currentUnit]!, forKey: Key.selectedUnit)
    }
}
