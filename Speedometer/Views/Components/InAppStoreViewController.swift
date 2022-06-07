import Purchases
import UIKit

protocol InAppStoreViewControllerDelegate: AnyObject {
    func tipSelectionViewControllerWillPurchaseProduct(_ tipSelectionViewController: InAppStoreViewController)
    func tipSelectionViewControllerDidPurchaseProduct(_ tipSelectionViewController: InAppStoreViewController)
    func tipSelectionViewControllerCouldNotPurchaseProduct(_ tipSelectionViewController: InAppStoreViewController)
}

class InAppStoreViewController: UIViewController {
    weak var delegate: InAppStoreViewControllerDelegate?

    private lazy var priceFormatter: NumberFormatter = {
        let priceFormatter = NumberFormatter()
        priceFormatter.numberStyle = .currency

        return priceFormatter
    }()

    private lazy var loadingProductsView: UIView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.color = AppDelegate.shared.theme.primaryContentColor
        activityIndicatorView.startAnimating()

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppDelegate.shared.theme.textFont
        label.textColor = AppDelegate.shared.theme.primaryContentColor
        label.text = "InAppStoreViewController.LoadingMessage".localized

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
        fallbackLabel.textColor = AppDelegate.shared.theme.interactionColor
        fallbackLabel.numberOfLines = 0
        fallbackLabel.text = "InAppStoreViewController.FallbackMessage".localized

        return fallbackLabel
    }()

    private lazy var introductionViewController: UIViewController = {
        return ParagraphViewController(heading: "InAppStoreViewController.Heading".localized, text: "InAppStoreViewController.Description".localized)
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
        restoreButton.setTitle("InAppStoreViewController.RestoreButton".localized, for: .normal)
        restoreButton.titleLabel?.font = AppDelegate.shared.theme.buttonFont
        restoreButton.tintColor = AppDelegate.shared.theme.interactionColor
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
                self?.showConfirmationMessage()
                AppDelegate.shared.updateUserStatus()
            }
        }

        return restoreButton
    }()

    private lazy var disclaimerLabel: UILabel = {
        let disclaimerLabel = UILabel()
        disclaimerLabel.translatesAutoresizingMaskIntoConstraints = false
        disclaimerLabel.font = AppDelegate.shared.theme.disclaimerFont
        disclaimerLabel.textColor = AppDelegate.shared.theme.secondaryContentColor
        disclaimerLabel.text = "InAppStoreViewController.Disclaimer".localized
        disclaimerLabel.numberOfLines = 0

        return disclaimerLabel
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

    func showConfirmationMessage() {
        let okAction = UIAlertAction(title: "SettingsViewController.TipConfirmationButton".localized, style: .default) { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }
        let alertViewController = UIAlertController(title: "SettingsViewController.TipConfirmationTitle".localized, message: "SettingsViewController.TipConfirmationMessage".localized, preferredStyle: .alert)
        alertViewController.addAction(okAction)
        alertViewController.view.tintColor = AppDelegate.shared.theme.interactionColor

        present(alertViewController, animated: true, completion: nil)
    }
}

private extension InAppStoreViewController {
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
        purchaseButton.backgroundColor = AppDelegate.shared.theme.interactionColor
        purchaseButton.setTitleColor(AppDelegate.shared.theme.onInteractionColor, for: .normal)
        purchaseButton.titleLabel?.textAlignment = .center
        purchaseButton.titleLabel?.font = AppDelegate.shared.theme.buttonFont
        purchaseButton.setTitle(priceFormatter.string(from: package.product.price), for: .normal)
        purchaseButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        purchaseButton.addAction {
            Purchases.shared.purchasePackage(package) { (_, _, error, _) in
                guard error == nil else {
                    return
                }

                AppDelegate.shared.updateUserStatus()
                print("[RevenueCat] Purchasing product `\(package.identifier)`")
            }
        }

        return purchaseButton
    }
}

// - MARK: PaymentTransactionObserverDelegate

extension InAppStoreViewController: PaymentTransactionObserverDelegate {
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
