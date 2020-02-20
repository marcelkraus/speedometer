import StoreKit
import UIKit

class TipSelectionViewController: UIViewController {
    private var productRequest: SKProductsRequest!

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.startAnimating()

        return activityIndicatorView
    }()

    private lazy var contentStackView: UIStackView = {
        let contentStackView = UIStackView()
        contentStackView.spacing = 20.0
        contentStackView.distribution = .fillEqually
        contentStackView.alignment = .center
        contentStackView.addArrangedSubview(activityIndicatorView)

        return contentStackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        retrieveProductInformation()
    }
}

// MARK: - Private Methods

private extension TipSelectionViewController {
    func retrieveProductInformation() {
        let identifiers = Set(["de.marcelkraus.speedometer.tip.small", "de.marcelkraus.speedometer.tip.medium", "de.marcelkraus.speedometer.tip.large"])

        productRequest = SKProductsRequest(productIdentifiers: identifiers)
        productRequest.delegate = self
        productRequest.start()
    }

    func removePlaceholderView(_ placeholderView: UIView) {
        contentStackView.removeArrangedSubview(placeholderView)
        placeholderView.removeFromSuperview()
    }
}

// MARK: - Selectors

@objc extension TipSelectionViewController {
    func purchaseProduct() {
        print("TODO: Purchase Product")
    }
}

// MARK: - SKProductsRequestDelegate

extension TipSelectionViewController: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            guard response.products.count > 0, let placeholderView = self.contentStackView.arrangedSubviews.first else {
                return
            }

            let priceFormatter = NumberFormatter()
            priceFormatter.numberStyle = .currency

            self.removePlaceholderView(placeholderView)

            let products = response.products.sorted(by: { $0.productIdentifier > $1.productIdentifier })
            for product in products {
                priceFormatter.locale = product.priceLocale

                let purchaseButton = UIButton()
                purchaseButton.layer.cornerRadius = 20.0
                purchaseButton.backgroundColor = .branding
                purchaseButton.titleLabel?.textAlignment = .center
                purchaseButton.titleLabel?.textColor = .white
                purchaseButton.titleLabel?.font = .preferredFont(forTextStyle: .callout)
                purchaseButton.setTitle(priceFormatter.string(from: product.price), for: .normal)
                purchaseButton.addTarget(self, action: #selector(self.purchaseProduct), for: .touchUpInside)

                NSLayoutConstraint.activate([
                    purchaseButton.heightAnchor.constraint(equalToConstant: 40),
                ])

                self.contentStackView.addArrangedSubview(purchaseButton)
            }

            NSLayoutConstraint.activate([
                self.contentStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                self.contentStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
                self.contentStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
                self.contentStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            ])
        }
    }
}
