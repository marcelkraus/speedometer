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
        activityIndicatorView.color = AppDelegate.shared.theme.activityIndicatorColor
        activityIndicatorView.startAnimating()

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppDelegate.shared.theme.textFont
        label.textColor = AppDelegate.shared.theme.activityIndicatorColor
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

    private lazy var fallbackLabel: UILabel = {
        let fallbackLabel = UILabel()
        fallbackLabel.translatesAutoresizingMaskIntoConstraints = false
        fallbackLabel.font = AppDelegate.shared.theme.textFont
        fallbackLabel.textColor = AppDelegate.shared.theme.corporateColor
        fallbackLabel.numberOfLines = 0
        fallbackLabel.text = "TipJarViewController.FallbackMessage".localized

        return fallbackLabel
    }()

    private lazy var introductionViewController: UIViewController = {
        return ParagraphViewController(heading: "TipJarViewController.Heading".localized, text: "TipJarViewController.Description".localized)
    }()

    private lazy var purchaseButtonsStackView: UIStackView = {
        let purchaseButtonsStackView = UIStackView(arrangedSubviews: [loadingProductsView])
        purchaseButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        purchaseButtonsStackView.spacing = 20.0
        purchaseButtonsStackView.distribution = .fillEqually

        return purchaseButtonsStackView
    }()

    private lazy var inAppStoreStackView: UIStackView = {
        let inAppStoreStackView = UIStackView(arrangedSubviews: [purchaseButtonsStackView])
        inAppStoreStackView.translatesAutoresizingMaskIntoConstraints = false
        inAppStoreStackView.axis = .vertical
        inAppStoreStackView.spacing = 10.0

        return inAppStoreStackView
    }()

    private lazy var restoreButton: UIButton = {
        let restoreButton = UIButton(type: .system)
        restoreButton.translatesAutoresizingMaskIntoConstraints = false
        restoreButton.setTitle("TipJarViewController.RestoreButton".localized, for: .normal)
        restoreButton.titleLabel?.font = AppDelegate.shared.theme.buttonFont
        restoreButton.tintColor = AppDelegate.shared.theme.corporateColor
        restoreButton.addAction {
            Purchases.shared.restoreTransactions { [weak self] purchaserInfo, error in
                guard error == nil else {
                    print("[RevenueCat] An error occured, purchases could not be restored")
                    return
                }

                guard purchaserInfo?.allPurchasedProductIdentifiers.count ?? 0 > 0 else {
                    print("[RevenueCat] No purchases available which could be restored")
                    return
                }

                print("[RevenueCat] Purchases were restored successfully")
            }
        }

        return restoreButton
    }()


    private lazy var disclaimerLabel: UILabel = {
        let tipJarDisclaimerLabel = UILabel()
        tipJarDisclaimerLabel.translatesAutoresizingMaskIntoConstraints = false
        tipJarDisclaimerLabel.font = AppDelegate.shared.theme.disclaimerFont
        tipJarDisclaimerLabel.text = "TipJarViewController.Disclaimer".localized
        tipJarDisclaimerLabel.numberOfLines = 0

        return tipJarDisclaimerLabel
    }()

    private lazy var stackView: UIStackView = {
        addChild(introductionViewController)
        introductionViewController.view.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(arrangedSubviews: [introductionViewController.view, inAppStoreStackView, disclaimerLabel])
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
                self.replaceLoadingProductsView(with: [self.fallbackLabel])

                return
            }

            guard let offering = offerings?.current, offering.availablePackages.count > 0 else {
                return
            }

            let productButtons = offering.availablePackages.map {
                self.purchaseButton(for: $0)
            }

            DispatchQueue.main.async {
                self.replaceLoadingProductsView(with: productButtons)
            }
        }

        Purchases.shared.purchaserInfo { purchaserInfo, error in
            guard error == nil else {
                return
            }

            print("[RevenueCat] Available entitlements: \(purchaserInfo?.entitlements.all.keys.joined(separator: ",") ?? "")")
        }
    }
}

private extension TipJarViewController {
    func replaceLoadingProductsView(with views: [UIView]) {
        guard purchaseButtonsStackView.arrangedSubviews.count == 1, let loadingProductsView = purchaseButtonsStackView.arrangedSubviews.first else {
            return
        }

        purchaseButtonsStackView.removeArrangedSubview(loadingProductsView)
        loadingProductsView.removeFromSuperview()

        views.forEach {
            purchaseButtonsStackView.addArrangedSubview($0)
        }

        inAppStoreStackView.addArrangedSubview(restoreButton)

        view.setNeedsDisplay()
    }

    func purchaseButton(for package: Purchases.Package) -> UIButton {
        priceFormatter.locale = package.product.priceLocale

        let purchaseButton = UIButton(type: .custom)
        purchaseButton.translatesAutoresizingMaskIntoConstraints = false
        purchaseButton.layer.cornerRadius = 20.0
        purchaseButton.backgroundColor = AppDelegate.shared.theme.corporateColor
        purchaseButton.setTitleColor(UIColor(red: 192.0, green: 192.0, blue: 192.0, alpha: 1.0), for: .highlighted)
        purchaseButton.titleLabel?.textAlignment = .center
        purchaseButton.titleLabel?.textColor = AppDelegate.shared.theme.textOnCorporateColor
        purchaseButton.titleLabel?.font = AppDelegate.shared.theme.buttonFont
        purchaseButton.setTitle(priceFormatter.string(from: package.product.price), for: .normal)
        purchaseButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        purchaseButton.addAction {
            Purchases.shared.purchasePackage(package) { (_, _, error, _) in
                guard error == nil else {
                    return
                }

                print("[RevenueCat] Purchasing product `\(package.identifier)`")
            }
        }

        return purchaseButton
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
