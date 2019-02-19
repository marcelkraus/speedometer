import StoreKit

struct StoreReviewHelper {
    private enum Keys {
        static let appStartCounter = "app_start_counter"
    }

    static func incrementAppStartCounter() {
        let appStartCounter = UserDefaults.standard.integer(forKey: Keys.appStartCounter) + 1
        UserDefaults.standard.set(appStartCounter, forKey: Keys.appStartCounter)
    }

    static func askForReview() {
        let appStartCounter = UserDefaults.standard.integer(forKey: Keys.appStartCounter)
        guard appStartCounter == 5 || (appStartCounter % 10 == 0 && appStartCounter != 10) else {
            return
        }

        SKStoreReviewController.requestReview()
    }
}
