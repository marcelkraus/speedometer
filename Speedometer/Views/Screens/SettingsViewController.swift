import UIKit

class SettingsViewController: UIViewController {
    private lazy var separatorView: UIView = {
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = .branding
        separatorView.layer.cornerRadius = 10.0
        separatorView.layer.masksToBounds = true

        return separatorView
    }()

    private lazy var stackView: UIStackView = {
        addChild(imprintViewController)
        imprintViewController.view.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(arrangedSubviews: [imprintViewController.view, tipJarStackView, swipeInfoLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 40.0

        imprintViewController.didMove(toParent: self)

        return stackView
    }()

    private lazy var tipJarIntroductionViewController: UIViewController = {
        return ParagraphViewController(heading: "SettingsViewController.TipJar.Heading".localized, text: "SettingsViewController.TipJar.Text".localized)
    }()

    private lazy var tipJarButtonStackViewController: UIViewController = {
        return TipSelectionViewController()
    }()

    private lazy var tipJarStackView: UIStackView = {
        addChild(tipJarIntroductionViewController)
        tipJarIntroductionViewController.view.translatesAutoresizingMaskIntoConstraints = false

        addChild(tipJarButtonStackViewController)
        tipJarButtonStackViewController.view.translatesAutoresizingMaskIntoConstraints = false

        let tipJarStackView = UIStackView(arrangedSubviews: [tipJarIntroductionViewController.view, tipJarButtonStackViewController.view])
        tipJarStackView.translatesAutoresizingMaskIntoConstraints = false
        tipJarStackView.axis = .vertical
        tipJarStackView.spacing = 20.0

        tipJarIntroductionViewController.didMove(toParent: self)
        tipJarButtonStackViewController.didMove(toParent: self)

        return tipJarStackView
    }()

    private lazy var imprintViewController: UIViewController = {
        return ParagraphViewController(heading: "SettingsViewController.Imprint.Heading".localized, text: String(format: "SettingsViewController.Imprint.Text".localized, versionNumber, buildNumber))
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

    private lazy var impactGenerator: UIImpactFeedbackGenerator = {
        return UIImpactFeedbackGenerator(style: .medium)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presentationController?.delegate = self

        view.backgroundColor = .white
        view.addSubview(separatorView)
        view.addSubview(stackView)

        separatorView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separatorView.heightAnchor.constraint(equalToConstant: 20.0),
            separatorView.widthAnchor.constraint(equalToConstant: 170.0),
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -30.0),
            separatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40.0),
            stackView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 40.0),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40.0),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40.0),
        ])
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
