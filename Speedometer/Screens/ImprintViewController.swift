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
    private var closeButtonView: UIView!

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

        view.backgroundColor = UIColor.clear.withAlphaComponent(0.75)
        setupBackgroundView()
        setupSeparatorView()
        setupImprintView()
        setupCloseButtonView()
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
            separatorView.heightAnchor.constraint(equalToConstant: 10.0),
            separatorView.widthAnchor.constraint(equalToConstant: 180.0),
            separatorView.leadingAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.leadingAnchor, constant: -40.0),
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

    func setupCloseButtonView() {
        let closeViewController = CloseButtonViewController()
        addChild(closeViewController)

        closeButtonView = closeViewController.view!
        view.addSubview(closeButtonView)

        closeButtonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButtonView.topAnchor.constraint(equalTo: imprintView.bottomAnchor, constant: 40.0),
            closeButtonView.centerXAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.centerXAnchor)
            ])
        closeViewController.didMove(toParent: self)
    }
}
