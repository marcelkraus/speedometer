import RevenueCat
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private static let revenueCatApiKey = "qzefGtCYnlDdBkhjXZpKYVEHvFgSnatV"

    static var shared = AppDelegate()

    var window: UIWindow?

    private(set) var theme: Theme = .selected {
        didSet {
            UserDefaults.standard.set(theme.rawValue, forKey: Key.selectedTheme)
        }
    }

    private(set) var isSupporter = false

    func applicationDidFinishLaunching(_ application: UIApplication) {
        AppDelegate.shared = self

        PaymentTransactionObserver.sharedInstance.register()

        setupRevenueCat()
        updateUserStatus()
        setDefaultSettings()

        StoreReviewHelper.incrementAppStartCounter()
        application.isIdleTimerDisabled = true

        migrateTo12()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = theme.backgroundColor
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()
    }

    func applicationWillTerminate(_: UIApplication) {
        PaymentTransactionObserver.sharedInstance.deregister()
    }

    func setTheme(_ theme: Theme) {
        self.theme = theme
    }

    func updateUserStatus() {
        return Purchases.shared.getCustomerInfo { [weak self] customerInfo, error in
            guard error == nil else {
                return
            }

            self?.isSupporter = customerInfo?.entitlements.active.keys.contains("supporter") ?? false
        }
    }
}

private extension AppDelegate {
    func setupRevenueCat() {
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: Self.revenueCatApiKey)
    }

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
