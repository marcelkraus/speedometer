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
            self.transition(to: MessageViewController(heading: NSLocalizedString("ErrorHeading", comment: ""), message: NSLocalizedString("LocationRestrictionError", comment: "")))
        case .denied:
            self.transition(to: MessageViewController(heading: NSLocalizedString("ErrorHeading", comment: ""), message: NSLocalizedString("NoLocationServicesError", comment: "")))
        case .authorizedWhenInUse:
            self.transition(to: SpeedometerViewController(locationManager: self.locationManager, unit: Unit(rawValue: UserDefaults.standard.string(forKey: Unit.UserDefaultsKey)!)!))
        default:
            break
        }
    }
}
