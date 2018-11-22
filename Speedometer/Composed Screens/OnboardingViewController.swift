import UIKit

class OnboardingViewController: UIViewController {

    // MARK: - Properties

    private var paragraphView: UIView!

    // MARK: - View Controller Lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)

        view.backgroundColor = .white

        setupUnitSelectionView()
        setupParagraphView()
        setupAuthorizationButton()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension OnboardingViewController {

    // MARK: - Private Methods

    func setupParagraphView() {
        let paragraphViewController = InformationViewController(informationType: .onboardingInformation)
        addChild(paragraphViewController)

        paragraphView = paragraphViewController.view!
        view.addSubview(paragraphView)

        paragraphView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            paragraphView.leadingAnchor.constraint(equalTo: paragraphView.leadingAnchor),
            paragraphView.topAnchor.constraint(equalTo: paragraphView.topAnchor),
            paragraphView.bottomAnchor.constraint(equalTo: paragraphView.bottomAnchor),
            paragraphView.trailingAnchor.constraint(equalTo: paragraphView.trailingAnchor),
            paragraphView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            paragraphView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            paragraphView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            ])
        paragraphViewController.didMove(toParent: self)
    }

    func setupAuthorizationButton() {
        let authorizationButtonViewController = AuthorizationButtonViewController()
        addChild(authorizationButtonViewController)

        let authorizationButtonView = authorizationButtonViewController.view!
        view.addSubview(authorizationButtonView)

        authorizationButtonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorizationButtonView.heightAnchor.constraint(equalToConstant: 40.0),
            authorizationButtonView.leadingAnchor.constraint(equalTo: paragraphView.leadingAnchor),
            authorizationButtonView.topAnchor.constraint(equalTo: paragraphView.bottomAnchor, constant: 20.0),
            authorizationButtonView.trailingAnchor.constraint(equalTo: paragraphView.trailingAnchor),
            ])
    }

    func setupUnitSelectionView() {
        let unitSelectionViewController = UnitSelectionViewController()
        unitSelectionViewController.hideStackView = true
        addChild(unitSelectionViewController)

        let unitSelectionView = unitSelectionViewController.view!
        view.addSubview(unitSelectionView)

        unitSelectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            unitSelectionView.leadingAnchor.constraint(equalTo: unitSelectionView.leadingAnchor),
            unitSelectionView.topAnchor.constraint(equalTo: unitSelectionView.topAnchor),
            unitSelectionView.bottomAnchor.constraint(equalTo: unitSelectionView.bottomAnchor),
            unitSelectionView.trailingAnchor.constraint(equalTo: unitSelectionView.trailingAnchor),
            unitSelectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            unitSelectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            unitSelectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        unitSelectionViewController.didMove(toParent: self)
    }
}
