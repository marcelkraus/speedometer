import StoreKit
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        PaymentTransactionObserver.sharedInstance.register()

        setDefaultSettings()

        StoreReviewHelper.incrementAppStartCounter()
        application.isIdleTimerDisabled = true

        migrateTo12()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .background
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        PaymentTransactionObserver.sharedInstance.deregister()
    }
}

private extension AppDelegate {
    func setDefaultSettings() {
        let defaultUnit = Locale.current.usesMetricSystem ? Unit.kilometersPerHour : Unit.milesPerHour

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
