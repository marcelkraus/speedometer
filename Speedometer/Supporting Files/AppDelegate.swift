import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = FlowViewController()
        window?.makeKeyAndVisible()

        UserDefaults.standard.register(defaults: [
            Configuration.appStartCounterKey: 0,
            Configuration.currentUnitDefaultsKey: Locale.current.usesMetricSystem ? Unit.kilometersPerHour.rawValue : Unit.milesPerHour.rawValue,
            Configuration.currentSpeedLimitDefaultsKey: "0"
            ])

        application.isIdleTimerDisabled = true
        StoreReviewHelper.incrementAppStartCounter()
    }
}
