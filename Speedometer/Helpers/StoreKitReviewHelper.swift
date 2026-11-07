import StoreKit

@MainActor
enum StoreReviewHelper {
    private static var hasAskedForReview = false

    static func incrementAppStartCounter() {
        let appStartCounter = UserDefaults.standard.integer(forKey: Key.appStartCounter) + 1
        UserDefaults.standard.set(appStartCounter, forKey: Key.appStartCounter)
    }

    static func askForReview(in windowScene: UIWindowScene?) {
        guard hasAskedForReview == false, let windowScene else {
            return
        }

        hasAskedForReview = true

        let appStartCounter = UserDefaults.standard.integer(forKey: Key.appStartCounter)
        guard appStartCounter == 5 || (appStartCounter % 10 == 0 && appStartCounter != 10) else {
            return
        }

        AppStore.requestReview(in: windowScene)
    }
}
