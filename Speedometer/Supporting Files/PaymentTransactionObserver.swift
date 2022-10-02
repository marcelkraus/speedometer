import StoreKit

protocol PaymentTransactionObserverDelegate: AnyObject {
    func showTransactionAsInProgress(_ transaction: SKPaymentTransaction, deferred: Bool)
    func completeTransaction(_ transaction: SKPaymentTransaction)
    func failedTransaction(_ transaction: SKPaymentTransaction)
}

class PaymentTransactionObserver: NSObject {
    static let sharedInstance = PaymentTransactionObserver()

    weak var delegate: PaymentTransactionObserverDelegate?

    private override init() {
        super.init()
    }

    func register() {
        SKPaymentQueue.default().add(self)
    }

    func deregister() {
        SKPaymentQueue.default().remove(self)
    }
}

extension PaymentTransactionObserver: SKPaymentTransactionObserver {
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                delegate?.showTransactionAsInProgress(transaction, deferred: false)
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                delegate?.completeTransaction(transaction)
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                delegate?.failedTransaction(transaction)
            case .restored:
                SKPaymentQueue.default().finishTransaction(transaction)
            case .deferred:
                delegate?.showTransactionAsInProgress(transaction, deferred: true)
            @unknown default:
                fatalError("[Error] Unhandled enum `-[SKPaymentTransaction transactionState]`")
            }
        }
    }

    func paymentQueue(_ queue: SKPaymentQueue, shouldAddStorePayment payment: SKPayment, for product: SKProduct) -> Bool {
        return true
    }
}
