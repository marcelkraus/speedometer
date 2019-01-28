import UIKit

class OnboardingViewController: UIViewController {
    private var separatorView: UIView!
    private var informationView: UIView!
    private var authorizationButtonView: UIView!

    init() {
        super.init(nibName: nil, bundle: nil)

        view.backgroundColor = .white
        setupSeparatorView()
        setupInformationView()
        setupAuthorizationButton()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension OnboardingViewController {
    func setupSeparatorView() {
        let separatorViewController = SeparatorViewController()
        addChild(separatorViewController)

        separatorView = separatorViewController.view!
        view.addSubview(separatorView)

        separatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separatorView.heightAnchor.constraint(equalToConstant: 10.0),
            separatorView.widthAnchor.constraint(equalToConstant: 180.0),
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -40.0),
            separatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40.0)
            ])
        separatorViewController.didMove(toParent: self)
    }

    func setupInformationView() {
        let informationViewController = InformationViewController(informationType: .onboardingInformation)
        addChild(informationViewController)

        informationView = informationViewController.view!
        view.addSubview(informationView)

        informationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            informationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40.0),
            informationView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 40.0),
            informationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40.0),
            ])
        informationViewController.didMove(toParent: self)
    }

    func setupAuthorizationButton() {
        let authorizationButtonViewController = AuthorizationButtonViewController()
        addChild(authorizationButtonViewController)

        authorizationButtonView = authorizationButtonViewController.view!
        view.addSubview(authorizationButtonView)

        authorizationButtonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorizationButtonView.topAnchor.constraint(equalTo: informationView.bottomAnchor, constant: 40.0),
            authorizationButtonView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            ])
        authorizationButtonViewController.didMove(toParent: self)
    }
}
