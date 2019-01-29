import UIKit

class ImprintViewController: UIViewController {
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10.0

        return view
    }()

    private var separatorView: UIView!

    private var imprintView: UIView!

    private lazy var swipeInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "↓ " + "ImprintViewController.SwipeInfo".localized + " ↓"
        label.font = .preferredFont(forTextStyle: .caption2)
        label.textColor = .darkGray

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

        setupView()
        setupBackgroundView()
        setupSeparatorView()
        setupImprintView()
        setupSwipeInfoLabel()
        setupGestureRecognizer()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Setup

private extension ImprintViewController {
    func setupView() {
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
        view.backgroundColor = UIColor.clear.withAlphaComponent(0.75)
    }

    func setupBackgroundView() {
        view.addSubview(backgroundView)

        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            backgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            backgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20.0)
            ])
    }

    func setupSeparatorView() {
        let separatorViewController = SeparatorViewController()
        addChild(separatorViewController)

        separatorView = separatorViewController.view!
        view.addSubview(separatorView)

        separatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separatorView.heightAnchor.constraint(equalToConstant: 20.0),
            separatorView.widthAnchor.constraint(equalToConstant: 170.0),
            separatorView.leadingAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.leadingAnchor, constant: -30.0),
            separatorView.topAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.topAnchor, constant: 40.0)
            ])
        separatorViewController.didMove(toParent: self)
    }

    func setupImprintView() {
        let imprintViewController = InformationViewController(heading: "ImprintViewController.Heading".localized, text: String(format: "ImprintViewController.Text".localized, versionNumber, buildNumber))
        addChild(imprintViewController)

        imprintView = imprintViewController.view!
        view.addSubview(imprintView)

        imprintView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imprintView.leadingAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.leadingAnchor, constant: 40.0),
            imprintView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 40.0),
            imprintView.trailingAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.trailingAnchor, constant: -40.0)
            ])
        imprintViewController.didMove(toParent: self)
    }

    func setupSwipeInfoLabel() {
        view.addSubview(swipeInfoLabel)

        swipeInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            swipeInfoLabel.topAnchor.constraint(equalTo: imprintView.bottomAnchor, constant: 40.0),
            swipeInfoLabel.centerXAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.centerXAnchor)
            ])
    }

    func setupGestureRecognizer() {
        let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(dismissImprint))
        gestureRecognizer.direction = .down
        view.addGestureRecognizer(gestureRecognizer)
    }
}

// MARK: - Obj-C Selectors

private extension ImprintViewController {
    @objc func dismissImprint() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
