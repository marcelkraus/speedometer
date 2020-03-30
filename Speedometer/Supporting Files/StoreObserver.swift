import StoreKit

class StoreObserver: NSObject, SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
         for transaction in transactions {
            switch transaction.transactionState {
                case .purchasing:
                    print("purchasing")
                case .deferred:
                    print("deferred")
                case .failed:
                    print("failed: \(transaction.error)")
                case .purchased:
                    print("purchased")
                case .restored:
                    print("restored")

         @unknown default: print("Unexpected transaction state \(transaction.transactionState)")
        }
         }
    }
}
