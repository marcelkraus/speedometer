import UIKit

class OnboardingViewController: UIViewController {
    private var primarySeparatorView: UIView!
    private var informationView: UIView!
    private var secondarySeparatorView: UIView!
    private var authorizationButtonView: UIView!

    init() {
        super.init(nibName: nil, bundle: nil)

        view.backgroundColor = .white

        setupPrimarySeparatorView()
        setupInformationView()
        setupSecondarySeparatorView()
        setupAuthorizationButton()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension OnboardingViewController {
    func setupPrimarySeparatorView() {
        let separatorViewController = SeparatorViewController()
        addChild(separatorViewController)

        primarySeparatorView = separatorViewController.view!
        view.addSubview(primarySeparatorView)

        primarySeparatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            primarySeparatorView.heightAnchor.constraint(equalToConstant: 10.0),
            primarySeparatorView.widthAnchor.constraint(equalToConstant: 180.0),
            primarySeparatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -40.0),
            primarySeparatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40.0)
            ])
    }

    func setupInformationView() {
        let informationViewController = InformationViewController(informationType: .onboardingInformation)
        addChild(informationViewController)

        informationView = informationViewController.view!
        view.addSubview(informationView)

        informationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            informationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40.0),
            informationView.topAnchor.constraint(equalTo: primarySeparatorView.bottomAnchor, constant: 40.0),
            informationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40.0),
            ])
        informationViewController.didMove(toParent: self)
    }

    func setupSecondarySeparatorView() {
        let separatorViewController = SeparatorViewController()
        addChild(separatorViewController)

        secondarySeparatorView = separatorViewController.view!
        view.addSubview(secondarySeparatorView)

        secondarySeparatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondarySeparatorView.heightAnchor.constraint(equalToConstant: 5.0),
            secondarySeparatorView.widthAnchor.constraint(equalToConstant: 90.0),
            secondarySeparatorView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            secondarySeparatorView.topAnchor.constraint(equalTo: informationView.bottomAnchor, constant: 40.0)
            ])
    }

    func setupAuthorizationButton() {
        let authorizationButtonViewController = AuthorizationButtonViewController()
        addChild(authorizationButtonViewController)

        authorizationButtonView = authorizationButtonViewController.view!
        view.addSubview(authorizationButtonView)

        authorizationButtonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorizationButtonView.topAnchor.constraint(equalTo: secondarySeparatorView.bottomAnchor, constant: 40.0),
            authorizationButtonView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            ])
    }
}
