import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setInitialViewController()

        UserDefaults.standard.register(defaults: [
            Configuration.appStartCounterKey: 0,
            Configuration.currentUnitDefaultsKey: Unit.kilometersPerHour.rawValue,
            Configuration.currentSpeedLimitDefaultsKey: "0"
        ])

        application.isIdleTimerDisabled = true
        StoreReviewHelper.incrementAppStartCounter()

        return true
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        setInitialViewController()
    }
}

private extension AppDelegate {
    func setInitialViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIStoryboard(name: "Speedometer", bundle: nil).instantiateInitialViewController()
        window?.makeKeyAndVisible()
    }
}
