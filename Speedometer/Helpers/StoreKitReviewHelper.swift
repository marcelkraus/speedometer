import StoreKit

enum StoreReviewHelper {
    static func incrementAppStartCounter() {
        let appStartCounter = UserDefaults.standard.integer(forKey: Key.appStartCounter) + 1
        UserDefaults.standard.set(appStartCounter, forKey: Key.appStartCounter)
    }

    static func askForReview(in windowScene: UIWindowScene?) {
        let appStartCounter = UserDefaults.standard.integer(forKey: Key.appStartCounter)
        guard appStartCounter == 5 || (appStartCounter % 10 == 0 && appStartCounter != 10) else {
            return
        }

        if let windowScene {
            SKStoreReviewController.requestReview(in: windowScene)
        }
    }
}
