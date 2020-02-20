import CoreLocation
import UIKit

class OnboardingViewController: UIViewController {
    private var locationManager: CLLocationManager

    var authorizationButtonViewController: ButtonViewController!

    var paragraphViewController: ParagraphViewController!

    private lazy var separatorView: SeparatorView = {
        let separatorView = SeparatorView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false

        return separatorView
    }()

    init(locationManager: CLLocationManager) {
        self.locationManager = locationManager

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(separatorView)
        NSLayoutConstraint.activate([
            separatorView.heightAnchor.constraint(equalToConstant: 20.0),
            separatorView.widthAnchor.constraint(equalToConstant: 170.0),
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -30.0),
            separatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40.0)
        ])

        setupParagraphView()
        setupAuthorizationButton()
    }
}

// MARK: - Button Handling

private extension OnboardingViewController {
    func handleAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
}

// MARK: - UI Setup

private extension OnboardingViewController {
    func setupAuthorizationButton() {
        authorizationButtonViewController = ButtonViewController(type: .plain("OnboardingViewController.Button".localized)) {
            self.handleAuthorization()
        }

        addChild(authorizationButtonViewController)

        let authorizationButtonView = authorizationButtonViewController.view!
        view.addSubview(authorizationButtonView)

        authorizationButtonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorizationButtonView.topAnchor.constraint(equalTo: paragraphViewController.view.bottomAnchor, constant: 40.0),
            authorizationButtonView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            ])
        authorizationButtonViewController.didMove(toParent: self)
    }

    func setupParagraphView() {
        paragraphViewController = ParagraphViewController(messageType: .onboarding)
        addChild(paragraphViewController)

        let paragraphView = paragraphViewController.view!
        view.addSubview(paragraphView)

        paragraphView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            paragraphView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40.0),
            paragraphView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 40.0),
            paragraphView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40.0),
            ])
        paragraphViewController.didMove(toParent: self)
    }
}
