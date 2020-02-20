import CoreLocation
import UIKit

class OnboardingViewController: UIViewController {
    private var locationManager: CLLocationManager

    private lazy var authorizationButtonView: UIButton = {
        let authorizationButtonView = UIButton()
        authorizationButtonView.translatesAutoresizingMaskIntoConstraints = false
        authorizationButtonView.setTitle("OnboardingViewController.Button".localized, for: .normal)
        authorizationButtonView.setTitleColor(.branding, for: .normal)
        authorizationButtonView.addTarget(self, action: #selector(handleAuthorization), for: .touchUpInside)

        return authorizationButtonView
    }()

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

@objc private extension OnboardingViewController {
    func handleAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
}

private extension OnboardingViewController {
    func setupAuthorizationButton() {
        view.addSubview(authorizationButtonView)

        NSLayoutConstraint.activate([
            authorizationButtonView.topAnchor.constraint(equalTo: paragraphViewController.view.bottomAnchor, constant: 40.0),
            authorizationButtonView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
    }

    func setupParagraphView() {
        paragraphViewController = ParagraphViewController(heading: Message.onboarding.heading, text: Message.onboarding.text)
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
