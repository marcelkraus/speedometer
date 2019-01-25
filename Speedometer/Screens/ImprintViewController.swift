import UIKit

class ImprintViewController: UIViewController {
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20.0

        return view
    }()

    private let informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20.0

        return stackView
    }()

    private var closeButtonView: UIView!

    private var versionNumberString: String {
        guard let versionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String, let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String else {
            return "-"
        }

        return "\("ImprintViewController.Version.Version".localized) \(versionNumber) (\("ImprintViewController.Version.Build".localized) \(buildNumber))"
    }

    init() {
        super.init(nibName: nil, bundle: nil)

        view.backgroundColor = UIColor.clear.withAlphaComponent(0.75)
        setupBackgroundView()
        setupCloseButtonView()
        setupInformationStackView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ImprintViewController {
    func setupBackgroundView() {
        view.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            backgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            backgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20.0),
            ])
    }

    func setupCloseButtonView() {
        let closeViewController = CloseButtonViewController()
        addChild(closeViewController)

        closeButtonView = closeViewController.view!
        view.addSubview(closeButtonView)

        closeButtonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButtonView.topAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            closeButtonView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20.0),
            ])
        closeViewController.didMove(toParent: self)
    }

    func setupInformationStackView() {
        backgroundView.addSubview(informationStackView)
        informationStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            informationStackView.leadingAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            informationStackView.topAnchor.constraint(equalTo: closeButtonView.bottomAnchor, constant: 20.0),
            informationStackView.trailingAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.trailingAnchor, constant: -20.0)
            ])

        let imprintViewController = InformationViewController(heading: "ImprintViewController.Imprint.Heading".localized, text: "ImprintViewController.Imprint.Text".localized)
        addChild(imprintViewController)
        let imprintView = imprintViewController.view!
        informationStackView.addArrangedSubview(imprintView)
        imprintViewController.didMove(toParent: self)

        let versionViewController = InformationViewController(heading: "ImprintViewController.Version.Heading".localized, text: versionNumberString)
        addChild(versionViewController)
        let versionView = versionViewController.view!
        informationStackView.addArrangedSubview(versionView)
        versionViewController.didMove(toParent: self)
    }
}
