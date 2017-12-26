import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupRootViewController()

        return true
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        setupRootViewController()
    }

}

private extension AppDelegate {

    func setupRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = FlowViewController()
        window?.makeKeyAndVisible()
    }

}
