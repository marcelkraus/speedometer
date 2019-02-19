import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        StoreReviewHelper.incrementAppStartCounter()
        application.isIdleTimerDisabled = true

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .background
        window?.tintColor = .branding
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()
    }
}
