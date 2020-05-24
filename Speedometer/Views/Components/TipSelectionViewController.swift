import StoreKit
import UIKit

class TipSelectionViewController: UIViewController {
    private let priceFormatter = NumberFormatter()

    private var productRequest: SKProductsRequest!

    private var products: [SKProduct] = []

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [placeholderView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20.0
        stackView.distribution = .fillEqually
        stackView.alignment = .center

        return stackView
    }()

    private lazy var placeholderView: UIActivityIndicatorView = {
        let placeholderView = UIActivityIndicatorView()
        placeholderView.translatesAutoresizingMaskIntoConstraints = false
        placeholderView.startAnimating()

        return placeholderView
    }()

    private lazy var noProductsLabel: UILabel = {
        let noProductsLabel = UILabel()
        noProductsLabel.translatesAutoresizingMaskIntoConstraints = false
        noProductsLabel.font = .text
        noProductsLabel.textColor = .branding
        noProductsLabel.numberOfLines = 0
        noProductsLabel.text = "TipSelectionViewController.FallbackMessage".localized

        return noProductsLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        PaymentTransactionObserver.sharedInstance.delegate = self

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
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

    private func replacePlaceholderView(with views: [UIView]) {
        guard let placeholderView = stackView.arrangedSubviews.first, placeholderView is UIActivityIndicatorView else {
            return
        }

        stackView.removeArrangedSubview(placeholderView)
        placeholderView.removeFromSuperview()

        for view in views {
            stackView.addArrangedSubview(view)
        }

        view.setNeedsDisplay()
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
        DispatchQueue.main.asyncAfter(deadline: .now()) { [unowned self] in
            guard response.products.count > 0 else {
                self.replacePlaceholderView(with: [self.noProductsLabel])
                return
            }

            var purchaseButtons: [UIView] = []
            self.products = response.products.sorted(by: { $0.productIdentifier > $1.productIdentifier })
            self.priceFormatter.numberStyle = .currency

            for product in self.products {
                self.priceFormatter.locale = product.priceLocale

                let purchaseButton = UIButton()
                purchaseButton.layer.cornerRadius = 20.0
                purchaseButton.backgroundColor = .branding
                purchaseButton.titleLabel?.textAlignment = .center
                purchaseButton.titleLabel?.textColor = .white
                purchaseButton.titleLabel?.font = .preferredFont(forTextStyle: .callout)
                purchaseButton.setTitle(self.priceFormatter.string(from: product.price), for: .normal)
                purchaseButton.addTarget(self, action: #selector(self.didTapPurchaseButton(_:)), for: .touchUpInside)
                purchaseButton.tag = self.products.firstIndex(of: product)!

                NSLayoutConstraint.activate([
                    purchaseButton.heightAnchor.constraint(equalToConstant: 40),
                ])

                purchaseButtons.append(purchaseButton)
            }

            self.replacePlaceholderView(with: purchaseButtons)
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
