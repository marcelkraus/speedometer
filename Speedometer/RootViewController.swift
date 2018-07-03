import CoreLocation
import UIKit

class RootViewController: UIViewController {
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        guard CLLocationManager.authorizationStatus() != .notDetermined else {
            return transition(to:
                MessageViewController(
                    locationManager: locationManager,
                    heading: "RootViewController.OnboardingInformation.Heading".localized,
                    message: "RootViewController.OnboardingInformation.Message".localized,
                    buttonTitle: "RootViewController.OnboardingInformation.Button".localized
                )
            )
        }

        let storyboard = UIStoryboard.init(name: "Speedometer", bundle: nil)
        let loadingViewController = storyboard.instantiateViewController(withIdentifier: "LoadingViewControllerIdentifier")

        transition(to: loadingViewController) { _ in
            self.chooseViewController()
        }
    }
}

// MARK: - CLLocationManagerDelegate

extension RootViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.chooseViewController()
    }
}

// MARK: - Private Methods

private extension RootViewController {
    func chooseViewController() {
        switch CLLocationManager.authorizationStatus() {
        case .restricted:
            self.transition(to:
                MessageViewController(
                    locationManager: locationManager,
                    heading: "RootViewController.LocationAuthorizationStatusRestricted.Heading".localized,
                    message: "RootViewController.LocationAuthorizationStatusRestricted.Message".localized
                )
            )
        case .denied:
            self.transition(to:
                MessageViewController(
                    locationManager: locationManager,
                    heading: "RootViewController.LocationAuthorizationStatusDenied.Heading".localized,
                    message: "RootViewController.LocationAuthorizationStatusRestricted.Message".localized
                )
            )
        case .authorizedWhenInUse:
            self.transition(to: SpeedometerViewController(locationManager: self.locationManager, unit: Unit(rawValue: UserDefaults.standard.string(forKey: Configuration.currentUnitDefaultsKey)!)!))
        default:
            break
        }
    }
}
