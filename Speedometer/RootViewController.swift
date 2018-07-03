import CoreLocation
import UIKit

class RootViewController: UIViewController {
    private let locationManager = CLLocationManager()
    private let currentStoryboard = UIStoryboard.init(name: "Speedometer", bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        let welcomeViewController = currentStoryboard.instantiateViewController(withIdentifier: "WelcomeViewControllerIdentifier") as! WelcomeViewController
        guard CLLocationManager.authorizationStatus() != .notDetermined else {
            return transition(to: welcomeViewController)
        }

        let loadingViewController = currentStoryboard.instantiateViewController(withIdentifier: "LoadingViewControllerIdentifier")
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
            let messageViewController = currentStoryboard.instantiateViewController(withIdentifier: "MessageViewControllerIdentifier") as! MessageViewController
            messageViewController.heading = "RootViewController.LocationAuthorizationStatusRestricted.Heading".localized
            messageViewController.message = "RootViewController.LocationAuthorizationStatusRestricted.Message".localized
            self.transition(to: messageViewController)
        case .denied:
            let messageViewController = currentStoryboard.instantiateViewController(withIdentifier: "MessageViewControllerIdentifier") as! MessageViewController
            messageViewController.heading = "RootViewController.LocationAuthorizationStatusDenied.Heading".localized
            messageViewController.message = "RootViewController.LocationAuthorizationStatusRestricted.Message".localized
            self.transition(to: messageViewController)
        case .authorizedWhenInUse:
            self.transition(to: SpeedometerViewController(locationManager: self.locationManager, unit: Unit(rawValue: UserDefaults.standard.string(forKey: Configuration.currentUnitDefaultsKey)!)!))
        default:
            break
        }
    }
}
