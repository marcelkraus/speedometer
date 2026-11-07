import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }

        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = AppDelegate.shared.theme.backgroundColor
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()
    }
}
