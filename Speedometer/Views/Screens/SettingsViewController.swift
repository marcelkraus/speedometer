import UIKit

protocol SettingsViewControllerDelegate: class {
    func settingsViewControllerDidTapCloseButton(_ settingsViewController: SettingsViewController)
}

class SettingsViewController: UIViewController {
    weak var delegate: SettingsViewControllerDelegate?

    private var isBlocked = false {
        didSet {
            switch isBlocked {
            case true:
                addChild(blockingOverlayViewController)

                blockingOverlayViewController.view.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(blockingOverlayViewController.view)
                NSLayoutConstraint.activate([
                    blockingOverlayViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
                    blockingOverlayViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    blockingOverlayViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                    blockingOverlayViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                ])

                blockingOverlayViewController.didMove(toParent: self)
            case false:
                blockingOverlayViewController.willMove(toParent: self)
                blockingOverlayViewController.view.removeFromSuperview()
                blockingOverlayViewController.removeFromParent()
            }
        }
    }

    private lazy var blockingOverlayViewController: UIViewController = {
        return BlockingOverlayViewController()
    }()

    private lazy var separatorView: UIView = {
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = AppDelegate.shared.theme.interactionColor
        separatorView.layer.cornerRadius = 10.0
        separatorView.layer.masksToBounds = true

        return separatorView
    }()

    private lazy var closeButton: UIButton = {
        let closeButton = UIButton(type: .custom)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.tintColor = AppDelegate.shared.theme.interactionColor
        closeButton.setImage(UIImage(named: "Close")?.withRenderingMode(.alwaysTemplate), for: .normal)
        closeButton.contentEdgeInsets = UIEdgeInsets(top: 12.0, left: 12.0, bottom: 12.0, right: 12.0)

        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)

        return closeButton
    }()

    private lazy var imprintViewController: UIViewController = {
        return ParagraphViewController(heading: "SettingsViewController.Imprint.Heading".localized, text: String(format: "SettingsViewController.Imprint.Text".localized, versionNumber, buildNumber))
    }()

    private lazy var inAppStoreViewController: UIViewController = {
        let inAppStoreViewController = InAppStoreViewController()
        inAppStoreViewController.delegate = self

        return inAppStoreViewController
    }()

    private lazy var themeSelectionStackView: UIStackView = {
        let headingLabel = UILabel()
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        headingLabel.font = AppDelegate.shared.theme.headingFont
        headingLabel.textColor = AppDelegate.shared.theme.primaryContentColor
        headingLabel.numberOfLines = 2
        headingLabel.text = "SettingsViewController.ThemeSelection.Heading".localized

        let themeSelectionStackView = UIStackView()
        themeSelectionStackView.translatesAutoresizingMaskIntoConstraints = false
        themeSelectionStackView.distribution = .equalCentering

        Theme.allCases.forEach { theme in
            let fillableCircleView = FillableCircleView(color: theme.interactionColor, isFilled: theme == AppDelegate.shared.theme)
            fillableCircleView.translatesAutoresizingMaskIntoConstraints = false
            fillableCircleView.backgroundColor = AppDelegate.shared.theme.backgroundColor
            fillableCircleView.addAction { [weak self] in
                AppDelegate.shared.setTheme(theme)
                self?.dismiss(animated: true, completion: nil)
            }
            NSLayoutConstraint.activate([
                fillableCircleView.heightAnchor.constraint(equalToConstant: 60.0),
                fillableCircleView.widthAnchor.constraint(equalTo: fillableCircleView.heightAnchor),
            ])

            themeSelectionStackView.addArrangedSubview(fillableCircleView)
        }

        let stackView = UIStackView(arrangedSubviews: [headingLabel, themeSelectionStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20.0

        return stackView
    }()

    private lazy var stackView: UIStackView = {
        addChild(imprintViewController)
        imprintViewController.view.translatesAutoresizingMaskIntoConstraints = false

        addChild(inAppStoreViewController)
        inAppStoreViewController.view.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(arrangedSubviews: [themeSelectionStackView, inAppStoreViewController.view, imprintViewController.view])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 40.0

        imprintViewController.didMove(toParent: self)
        inAppStoreViewController.didMove(toParent: self)

        return stackView
    }()

     private lazy var contentView: UIView = {
         let contentView = UIView()
         contentView.translatesAutoresizingMaskIntoConstraints = false

         contentView.addSubview(separatorView)
         contentView.addSubview(closeButton)
         contentView.addSubview(stackView)

         NSLayoutConstraint.activate([
             separatorView.heightAnchor.constraint(equalToConstant: 20.0),
             separatorView.widthAnchor.constraint(equalToConstant: 170.0),
             separatorView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40.0),
             separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -30.0),
             closeButton.heightAnchor.constraint(equalToConstant: 44.0),
             closeButton.widthAnchor.constraint(equalToConstant: 44.0),
             closeButton.centerYAnchor.constraint(equalTo: separatorView.centerYAnchor),
             closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0),
             stackView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 40.0),
             stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
             stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20.0),
             stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
         ])

         return contentView
     }()

    private lazy var scrollView: UIScrollView = {
         let scrollView = UIScrollView()
         scrollView.translatesAutoresizingMaskIntoConstraints = false

         scrollView.addSubview(contentView)
         NSLayoutConstraint.activate([
             scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: contentView.topAnchor),
             scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
             scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
             scrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         ])

         return scrollView
     }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppDelegate.shared.theme.backgroundColor

        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.frameLayoutGuide.widthAnchor.constraint(equalTo: scrollView.contentLayoutGuide.widthAnchor),
        ])
    }

    @objc func didTapCloseButton() {
        delegate?.settingsViewControllerDidTapCloseButton(self)
    }
}

extension SettingsViewController: InAppStoreViewControllerDelegate {
    func tipSelectionViewControllerWillPurchaseProduct(_ tipSelectionViewController: InAppStoreViewController) {
        isBlocked = true
    }

    func tipSelectionViewControllerDidPurchaseProduct(_ tipSelectionViewController: InAppStoreViewController) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.isBlocked = false
            self.showConfirmationMessage()
        }
    }

    func tipSelectionViewControllerCouldNotPurchaseProduct(_ tipSelectionViewController: InAppStoreViewController) {
        isBlocked = false
    }

    private func showConfirmationMessage() {
        let okAction = UIAlertAction(title: "SettingsViewController.TipConfirmationButton".localized, style: .default, handler: nil)
        let alertViewController = UIAlertController(title: "SettingsViewController.TipConfirmationTitle".localized, message: "SettingsViewController.TipConfirmationMessage".localized, preferredStyle: .alert)
        alertViewController.addAction(okAction)
        alertViewController.view.tintColor = AppDelegate.shared.theme.interactionColor

        present(alertViewController, animated: true, completion: nil)
    }
}

private extension SettingsViewController {
    var versionNumber: String {
        guard let versionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
            return "–"
        }

        return versionNumber
    }

    var buildNumber: String {
        guard let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String else {
            return "–"
        }

        return buildNumber
    }
}
