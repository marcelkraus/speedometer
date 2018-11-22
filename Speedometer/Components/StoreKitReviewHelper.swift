import StoreKit

struct StoreReviewHelper {
    static func incrementAppStartCounter() {
        let appStartCounter = UserDefaults.standard.integer(forKey: AppConfiguration.appStartCounterKey) + 1
        UserDefaults.standard.set(appStartCounter, forKey: AppConfiguration.appStartCounterKey)
    }

    static func askForReview() {
        let appStartCounter = UserDefaults.standard.integer(forKey: AppConfiguration.appStartCounterKey)
        guard appStartCounter == 5 || (appStartCounter % 10 == 0 && appStartCounter != 10) else {
            return
        }

        SKStoreReviewController.requestReview()
    }
}
