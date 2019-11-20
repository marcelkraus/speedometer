import UIKit

class SettingsViewController: UIViewController {
    var imprintViewController: ParagraphViewController!
    var separatorViewController: SeparatorViewController!

    private lazy var swipeInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "↓ " + "SettingsViewController.Imprint.SwipeInfo".localized + " ↓"
        label.font = .swipeInfo
        label.textColor = .swipeInfo

        return label
    }()

    private var versionNumber: String {
        guard let versionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
            return "–"
        }

        return versionNumber
    }

    private var buildNumber: String {
        guard let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String else {
            return "–"
        }

        return buildNumber
    }

    init() {
        super.init(nibName: nil, bundle: nil)

        setupSeparatorView()
        setupImprintView()
        setupSwipeInfoLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(dismissSettings))
        gestureRecognizer.direction = .down

        view = UIView()
        view.backgroundColor = .white
        view.addGestureRecognizer(gestureRecognizer)
    }
}

// MARK: - Obj-C Selectors

private extension SettingsViewController {
    @objc func dismissSettings() {
        let impactGenerator = UIImpactFeedbackGenerator(style: .medium)
        impactGenerator.prepare()
        impactGenerator.impactOccurred()

        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UI Setup

private extension SettingsViewController {
    func setupImprintView() {
        imprintViewController = ParagraphViewController(heading: "SettingsViewController.Imprint.Heading".localized, text: String(format: "SettingsViewController.Imprint.Text".localized, versionNumber, buildNumber))
        addChild(imprintViewController)

        let imprintView = imprintViewController.view!
        view.addSubview(imprintView)

        imprintView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imprintView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40.0),
            imprintView.topAnchor.constraint(equalTo: separatorViewController.view.bottomAnchor, constant: 40.0),
            imprintView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40.0)
            ])
        imprintViewController.didMove(toParent: self)
    }

    func setupSeparatorView() {
        separatorViewController = SeparatorViewController()
        addChild(separatorViewController)

        let separatorView = separatorViewController.view!
        view.addSubview(separatorView)

        separatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separatorView.heightAnchor.constraint(equalToConstant: 20.0),
            separatorView.widthAnchor.constraint(equalToConstant: 170.0),
            separatorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: -30.0),
            separatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40.0)
            ])
        separatorViewController.didMove(toParent: self)
    }

    func setupSwipeInfoLabel() {
        view.addSubview(swipeInfoLabel)

        swipeInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            swipeInfoLabel.topAnchor.constraint(equalTo: imprintViewController.view.bottomAnchor, constant: 40.0),
            swipeInfoLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
            ])
    }
}
