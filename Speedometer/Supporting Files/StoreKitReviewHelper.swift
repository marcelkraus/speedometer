import StoreKit

struct StoreReviewHelper {
    static func incrementAppStartCounter() {
        let appStartCounter = UserDefaults.standard.integer(forKey: Configuration.appStartCounterKey) + 1
        UserDefaults.standard.set(appStartCounter, forKey: Configuration.appStartCounterKey)
    }

    static func askForReview() {
        let appStartCounter = UserDefaults.standard.integer(forKey: Configuration.appStartCounterKey)
        guard appStartCounter % 10 == 0 else {
            return
        }

        SKStoreReviewController.requestReview()
    }
}
