import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UserDefaults.standard.register(defaults: [
            Unit.currentUnitKey: Unit.kilometersPerHour.rawValue,
            Speed.currentSpeedLimitKey: "0"
        ])

        setupRootViewController()

        return true
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        setupRootViewController()
    }

    private func setupRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()
    }
}
