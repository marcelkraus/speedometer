import StoreKit
import UIKit

class TipSelectionViewController: UIViewController {
    private var productRequest: SKProductsRequest!

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

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        requestProductInformation()
    }

    private func requestProductInformation() {
        let identifiers = Set([
            "de.marcelkraus.speedometer.tip.small",
            "de.marcelkraus.speedometer.tip.medium",
            "de.marcelkraus.speedometer.tip.large"
        ])

        productRequest = SKProductsRequest(productIdentifiers: identifiers)
        productRequest.delegate = self
        productRequest.start()
    }

    private func removePlaceholderView(_ placeholderView: UIView) {
        stackView.removeArrangedSubview(placeholderView)
        placeholderView.removeFromSuperview()
    }

    @objc private func purchaseProduct() {
        print("TODO: Purchase Product")
    }
}

// MARK: - SKProductsRequestDelegate

extension TipSelectionViewController: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            guard response.products.count > 0, let placeholderView = self.stackView.arrangedSubviews.first else {
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
