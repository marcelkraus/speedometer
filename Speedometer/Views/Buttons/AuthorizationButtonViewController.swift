import CoreLocation
import UIKit

class AuthorizationButtonViewController: UIViewController {
    private let locationManager = CLLocationManager()

    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("AuthorizationButtonViewController.Label".localized, for: .normal)
        button.setTitleColor(UIColor(red: 0.012, green: 0.569, blue: 0.576, alpha: 1.00), for: .normal)
        button.addTarget(self, action: #selector(handleAuthorization), for: .touchUpInside)
        button.titleLabel?.font = .preferredFont(forTextStyle: .title2)

        return button
    }()

    init() {
        super.init(nibName: nil, bundle: nil)

        setupButtonView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func handleAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
}

private extension AuthorizationButtonViewController {
    func setupButtonView() {
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
    }
}
