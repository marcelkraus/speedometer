import StoreKit
import UIKit

class TipSelectionViewController: UIViewController {
    private lazy var priceFormatter: NumberFormatter = {
        let priceFormatter = NumberFormatter()
        priceFormatter.numberStyle = .currency

        return priceFormatter
    }()

    private var productRequest: SKProductsRequest!

    private var products: [SKProduct] = []

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [placeholderView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20.0
        stackView.distribution = .fillEqually

        return stackView
    }()

    private lazy var placeholderView: UIView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.color = .activityIndicator
        activityIndicatorView.startAnimating()

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .text
        label.textColor = .activityIndicator
        label.text = "TipSelectionViewController.LoadingMessage".localized

        let placeholderView = UIView()
        placeholderView.addSubview(activityIndicatorView)
        placeholderView.addSubview(label)
        NSLayoutConstraint.activate([
            activityIndicatorView.topAnchor.constraint(equalTo: placeholderView.topAnchor),
            activityIndicatorView.leadingAnchor.constraint(equalTo: placeholderView.leadingAnchor),
            label.leadingAnchor.constraint(equalTo: activityIndicatorView.trailingAnchor, constant: 5.0),
            label.trailingAnchor.constraint(equalTo: placeholderView.trailingAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: placeholderView.bottomAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: label.centerYAnchor),
        ])

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
        guard stackView.arrangedSubviews.count == 1, let placeholderView = stackView.arrangedSubviews.first else {
            return
        }

        stackView.removeArrangedSubview(placeholderView)
        placeholderView.removeFromSuperview()

        views.forEach {
            stackView.addArrangedSubview($0)
        }

        view.setNeedsDisplay()
    }

    @objc private func didTapButton(_ sender: UIButton) {
        let product = products[sender.tag]
        let payment = SKPayment(product: product)

        SKPaymentQueue.default().add(payment)
    }

    private func button(for product: SKProduct) -> UIButton {
        priceFormatter.locale = product.priceLocale

        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 20.0
        button.backgroundColor = .branding
        button.setTitleColor(UIColor(red: 192.0, green: 192.0, blue: 192.0, alpha: 1.0), for: .highlighted)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .preferredFont(forTextStyle: .callout)
        button.setTitle(priceFormatter.string(from: product.price), for: .normal)
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: 40.0).isActive = true

        return button
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

            self.products = response.products.sorted(by: { $0.productIdentifier > $1.productIdentifier })

            var buttons: [UIView] = []
            for product in self.products {
                let button = self.button(for: product)
                button.tag = self.products.firstIndex(of: product)!
                buttons.append(button)
            }

            self.replacePlaceholderView(with: buttons)
        }
    }
}
