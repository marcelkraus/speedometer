import CoreLocation
import UIKit

class FlowViewController: UIViewController {
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        selectViewController()
    }
}

// MARK: - ButtonViewControllerDelegate

extension FlowViewController: ButtonViewControllerDelegate {
    func didTapButton(type: ButtonType) {
        switch type {
        case .info:
            present(ImprintViewController(), animated: true, completion: nil)
        case .plain(_):
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

// MARK: - CLLocationManagerDelegate

extension FlowViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.selectViewController()
    }
}

// MARK: - Private Methods

private extension FlowViewController {
    func selectViewController() {
        transition(to: LoadingViewController()) { _ in
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                let onboardingViewController = OnboardingViewController()
                onboardingViewController.authorizationButtonViewController.delegate = self
                self.transition(to: onboardingViewController)
            case .restricted:
                self.transition(to: MessageViewController(informationType: .locationAuthorizationStatusRestricted))
            case .denied:
                self.transition(to: MessageViewController(informationType: .locationAuthorizationStatusDenied))
            case .authorizedWhenInUse, .authorizedAlways:
                let speedometerViewController = SpeedometerViewController()
                speedometerViewController.imprintButtonViewController.delegate = self
                self.transition(to: speedometerViewController)
            }
        }
    }
}
