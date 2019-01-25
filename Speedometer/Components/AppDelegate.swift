import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        UserDefaults.standard.register(defaults: [
            AppConfig.UserDefaultsKey.appStartCounter: 0,
            AppConfig.UserDefaultsKey.unit: AppConfig.Default.unit,
            AppConfig.UserDefaultsKey.speedLimit: "0"
            ])

        application.isIdleTimerDisabled = true
        StoreReviewHelper.incrementAppStartCounter()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = FlowViewController()
        window?.makeKeyAndVisible()
    }
}
