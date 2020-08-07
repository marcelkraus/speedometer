import Purchases
import UIKit

protocol TipJarViewControllerDelegate: class {
    func tipSelectionViewControllerWillPurchaseProduct(_ tipSelectionViewController: TipJarViewController)
    func tipSelectionViewControllerDidPurchaseProduct(_ tipSelectionViewController: TipJarViewController)
    func tipSelectionViewControllerCouldNotPurchaseProduct(_ tipSelectionViewController: TipJarViewController)
}

class TipJarViewController: UIViewController {
    weak var delegate: TipJarViewControllerDelegate?

    private lazy var priceFormatter: NumberFormatter = {
        let priceFormatter = NumberFormatter()
        priceFormatter.numberStyle = .currency

        return priceFormatter
    }()

    private lazy var loadingProductsView: UIView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.color = .activityIndicator
        activityIndicatorView.startAnimating()

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .text
        label.textColor = .activityIndicator
        label.text = "TipJarViewController.LoadingMessage".localized

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
        noProductsLabel.text = "TipJarViewController.FallbackMessage".localized

        return noProductsLabel
    }()

    private lazy var introductionViewController: UIViewController = {
        return ParagraphViewController(heading: "TipJarViewController.Heading".localized, text: "TipJarViewController.Description".localized)
    }()

    private lazy var buttonsStackView: UIStackView = {
        let buttonsStackView = UIStackView(arrangedSubviews: [loadingProductsView])
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.spacing = 20.0
        buttonsStackView.distribution = .fillEqually

        return buttonsStackView
    }()

    private lazy var disclaimerLabel: UILabel = {
        let tipJarDisclaimerLabel = UILabel()
        tipJarDisclaimerLabel.translatesAutoresizingMaskIntoConstraints = false
        tipJarDisclaimerLabel.font = .disclaimer
        tipJarDisclaimerLabel.text = "TipJarViewController.Disclaimer".localized
        tipJarDisclaimerLabel.numberOfLines = 0

        return tipJarDisclaimerLabel
    }()

    private lazy var stackView: UIStackView = {
        addChild(introductionViewController)
        introductionViewController.view.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(arrangedSubviews: [introductionViewController.view, buttonsStackView, disclaimerLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20.0

        introductionViewController.didMove(toParent: self)

        return stackView
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

        Purchases.shared.offerings { offerings, error in
            guard error == nil else {
                self.replaceLoadingProductsView(with: [self.noProductsLabel])

                return
            }

            guard let offering = offerings?.current, offering.availablePackages.count > 0 else {
                return
            }

            let productButtons = offering.availablePackages.map {
                self.button(for: $0.product)
            }

            DispatchQueue.main.async {
                self.replaceLoadingProductsView(with: productButtons)
            }
        }
    }
}

private extension TipJarViewController {
    func replaceLoadingProductsView(with views: [UIView]) {
        guard buttonsStackView.arrangedSubviews.count == 1, let loadingProductsView = buttonsStackView.arrangedSubviews.first else {
            return
        }

        buttonsStackView.removeArrangedSubview(loadingProductsView)
        loadingProductsView.removeFromSuperview()

        views.forEach {
            buttonsStackView.addArrangedSubview($0)
        }

        view.setNeedsDisplay()
    }

    @objc func didTapButton(_ sender: UIButton) {
        // TODO
    }

    func button(for product: SKProduct) -> UIButton {
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

// - MARK: PaymentTransactionObserverDelegate

extension TipJarViewController: PaymentTransactionObserverDelegate {
    func showTransactionAsInProgress(_ transaction: SKPaymentTransaction, deferred: Bool) {
        delegate?.tipSelectionViewControllerWillPurchaseProduct(self)
    }

    func completeTransaction(_ transaction: SKPaymentTransaction) {
        SKPaymentQueue.default().finishTransaction(transaction)

        delegate?.tipSelectionViewControllerDidPurchaseProduct(self)
    }

    func failedTransaction(_ transaction: SKPaymentTransaction) {
        SKPaymentQueue.default().finishTransaction(transaction)

        delegate?.tipSelectionViewControllerCouldNotPurchaseProduct(self)
    }
}
