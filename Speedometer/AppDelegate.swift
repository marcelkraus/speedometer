import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        UIView.appearance().backgroundColor = .white
        SeparatorView.appearance().backgroundColor = .brand

        UserDefaults.standard.register(defaults: [
            AppConfig.UserDefaultsKey.appStartCounter: 0,
            AppConfig.UserDefaultsKey.unit: AppConfig.Default.unit,
            ])

        application.isIdleTimerDisabled = true
        StoreReviewHelper.incrementAppStartCounter()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()
    }
}
