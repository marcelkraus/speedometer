import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        UserDefaults.standard.register(defaults: [
            AppConfiguration.appStartCounterKey: 0,
            AppConfiguration.currentUnitDefaultsKey: AppConfiguration.defaultUnit,
            AppConfiguration.currentSpeedLimitDefaultsKey: "0"
            ])

        application.isIdleTimerDisabled = true
        StoreReviewHelper.incrementAppStartCounter()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = FlowViewController()
        window?.makeKeyAndVisible()
    }
}
