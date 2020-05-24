import StoreKit
import UIKit

class TipSelectionViewController: UIViewController {
    private var productRequest: SKProductsRequest!

    private var products: [SKProduct] = []

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [activityIndicatorView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20.0
        stackView.distribution = .fillEqually
        stackView.alignment = .center

        return stackView
    }()

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.startAnimating()

        return activityIndicatorView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        PaymentTransactionObserver.sharedInstance.delegate = self

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        requestProductInformation()
    }

    private func requestProductInformation() {
        let productIdentifiers = Set([
            "de.marcelkraus.speedometer.tip.small",
            "de.marcelkraus.speedometer.tip.medium",
            "de.marcelkraus.speedometer.tip.large"
        ])

        productRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        productRequest.delegate = self
        productRequest.start()
    }

    private func removePlaceholderView(_ placeholderView: UIView) {
        stackView.removeArrangedSubview(placeholderView)
        placeholderView.removeFromSuperview()
    }

    @objc private func didTapPurchaseButton(_ sender: UIButton) {
        let product = products[sender.tag]
        let payment = SKPayment(product: product)

        SKPaymentQueue.default().add(payment)
    }
}

// MARK: - SKProductsRequestDelegate

extension TipSelectionViewController: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            guard response.products.count > 0, let placeholderView = self.stackView.arrangedSubviews.first else {
                return
            }

            self.removePlaceholderView(placeholderView)

            let priceFormatter = NumberFormatter()
            priceFormatter.numberStyle = .currency

            self.products = response.products.sorted(by: { $0.productIdentifier > $1.productIdentifier })
            for product in self.products {
                priceFormatter.locale = product.priceLocale

                let purchaseButton = UIButton()
                purchaseButton.layer.cornerRadius = 20.0
                purchaseButton.backgroundColor = .branding
                purchaseButton.titleLabel?.textAlignment = .center
                purchaseButton.titleLabel?.textColor = .white
                purchaseButton.titleLabel?.font = .preferredFont(forTextStyle: .callout)
                purchaseButton.setTitle(priceFormatter.string(from: product.price), for: .normal)
                purchaseButton.addTarget(self, action: #selector(self.didTapPurchaseButton(_:)), for: .touchUpInside)
                purchaseButton.tag = self.products.firstIndex(of: product)!

                NSLayoutConstraint.activate([
                    purchaseButton.heightAnchor.constraint(equalToConstant: 40),
                ])

                self.stackView.addArrangedSubview(purchaseButton)
            }

            NSLayoutConstraint.activate([
                self.stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                self.stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                self.stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                self.stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            ])
        }
    }
}

extension TipSelectionViewController: PaymentTransactionObserverDelegate {
    func showTransactionAsInProgress(_ transaction: SKPaymentTransaction, deferred: Bool) {
        print("[TODO] Show transaction as in progress")
    }

    func completeTransaction(_ transaction: SKPaymentTransaction) {
        print("[TODO] Handle completion of transaction")

        SKPaymentQueue.default().finishTransaction(transaction)
    }

    func failedTransaction(_ transaction: SKPaymentTransaction) {
        print("[TODO] Handle failed transaction")

        SKPaymentQueue.default().finishTransaction(transaction)
    }
}
