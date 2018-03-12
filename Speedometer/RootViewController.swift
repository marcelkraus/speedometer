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
            return transition(to: AuthorizationViewController(locationManager: locationManager))
        }

        transition(to: LoadingViewController()) { _ in
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
            self.transition(to: MessageViewController(heading: "Houston, we've had a problem here!", message: "Usage of this app is not possible due to restrictions of Location Services.\n\nPlease remove any restrictions in settings:\n\nSettings > General > Restrictions > Location Services\n\nor contact your administrator."))
        case .denied:
            self.transition(to: MessageViewController(heading: "Houston, we've had a problem here!", message: "Please ensure to allow Location Services for Speedometer to use this app.\n\nPlease check the following settings to be enabled:\n\nSettings > Privacy > Location Services\n\nand\n\nSettings > Privacy > Location Services > Speedometer > While Using"))
        case .authorizedWhenInUse:
            self.transition(to: SpeedometerViewController(locationManager: self.locationManager, unit: Unit(rawValue: UserDefaults.standard.string(forKey: Unit.UserDefaultsKey)!)!))
        default:
            break
        }
    }
}
