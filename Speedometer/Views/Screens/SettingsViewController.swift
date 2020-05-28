import UIKit

class SettingsViewController: UIViewController {
    private lazy var blockingOverlayViewController: UIViewController = {
        return BlockingOverlayViewController()
    }()

    private lazy var impactGenerator: UIImpactFeedbackGenerator = {
        return UIImpactFeedbackGenerator(style: .medium)
    }()

    private lazy var separatorView: UIView = {
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = .branding
        separatorView.layer.cornerRadius = 10.0
        separatorView.layer.masksToBounds = true

        return separatorView
    }()

    private lazy var imprintViewController: UIViewController = {
        return ParagraphViewController(heading: "SettingsViewController.Imprint.Heading".localized, text: String(format: "SettingsViewController.Imprint.Text".localized, versionNumber, buildNumber))
    }()

    private lazy var tipJarViewController: UIViewController = {
        let tipJarViewController = TipJarViewController()
        tipJarViewController.delegate = self

        return tipJarViewController
    }()

    private lazy var swipeInfoLabel: UILabel = {
        let swipeInfoLabel = UILabel()
        swipeInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        swipeInfoLabel.font = .swipeInfo
        swipeInfoLabel.textColor = .swipeInfo
        swipeInfoLabel.textAlignment = .center
        swipeInfoLabel.text = "↓ " + "SettingsViewController.Imprint.SwipeInfo".localized + " ↓"

        return swipeInfoLabel
    }()

    private lazy var stackView: UIStackView = {
        addChild(imprintViewController)
        imprintViewController.view.translatesAutoresizingMaskIntoConstraints = false

        addChild(tipJarViewController)
        tipJarViewController.view.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(arrangedSubviews: [imprintViewController.view, tipJarViewController.view, swipeInfoLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 40.0

        imprintViewController.didMove(toParent: self)
        tipJarViewController.didMove(toParent: self)

        return stackView
    }()

     private lazy var contentView: UIView = {
         let contentView = UIView()
         contentView.translatesAutoresizingMaskIntoConstraints = false

         contentView.addSubview(separatorView)
         contentView.addSubview(stackView)

         NSLayoutConstraint.activate([
             separatorView.heightAnchor.constraint(equalToConstant: 20.0),
             separatorView.widthAnchor.constraint(equalToConstant: 170.0),
             separatorView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40.0),
             separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -30.0),
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

        view.backgroundColor = .white
        presentationController?.delegate = self

        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.frameLayoutGuide.widthAnchor.constraint(equalTo: scrollView.contentLayoutGuide.widthAnchor),
        ])
    }
}

extension SettingsViewController: TipJarViewControllerDelegate {
    func tipSelectionViewControllerWillPurchaseProduct(_ tipSelectionViewController: TipJarViewController) {
        blockUi()
    }

    func tipSelectionViewControllerDidPurchaseProduct(_ tipSelectionViewController: TipJarViewController) {
        unblockUi()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.showConfirmationMessage()
        }
    }

    func tipSelectionViewControllerCouldNotPurchaseProduct(_ tipSelectionViewController: TipJarViewController) {
        unblockUi()
    }

    private func showConfirmationMessage() {
        let okAction = UIAlertAction(title: "SettingsViewController.TipConfirmationButton".localized, style: .default, handler: nil)
        let alertViewController = UIAlertController(title: "SettingsViewController.TipConfirmationTitle".localized, message: "SettingsViewController.TipConfirmationMessage".localized, preferredStyle: .alert)
        alertViewController.addAction(okAction)
        alertViewController.view.tintColor = .branding

        present(alertViewController, animated: true, completion: nil)
    }

    private func blockUi() {
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
    }

    private func unblockUi() {
        blockingOverlayViewController.willMove(toParent: self)
        blockingOverlayViewController.view.removeFromSuperview()
        blockingOverlayViewController.removeFromParent()
    }
}

extension SettingsViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        impactGenerator.prepare()
    }

    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        impactGenerator.impactOccurred()
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
