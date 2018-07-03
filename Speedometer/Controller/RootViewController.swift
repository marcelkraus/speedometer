import CoreLocation
import UIKit

class RootViewController: UIViewController {
    private let appStoryboard = UIStoryboard.init(name: "Speedometer", bundle: nil)
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        chooseViewController()
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
        let loadingViewController = appStoryboard.instantiateViewController(withIdentifier: "LoadingViewControllerIdentifier")
        transition(to: loadingViewController) { _ in
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                let welcomeViewController = self.appStoryboard.instantiateViewController(withIdentifier: "WelcomeViewControllerIdentifier") as! WelcomeViewController
                self.transition(to: welcomeViewController)
            case .restricted:
                let messageViewController = self.appStoryboard.instantiateViewController(withIdentifier: "MessageViewControllerIdentifier") as! MessageViewController
                messageViewController.heading = "RootViewController.LocationAuthorizationStatusRestricted.Heading".localized
                messageViewController.message = "RootViewController.LocationAuthorizationStatusRestricted.Message".localized
                self.transition(to: messageViewController)
            case .denied:
                let messageViewController = self.appStoryboard.instantiateViewController(withIdentifier: "MessageViewControllerIdentifier") as! MessageViewController
                messageViewController.heading = "RootViewController.LocationAuthorizationStatusDenied.Heading".localized
                messageViewController.message = "RootViewController.LocationAuthorizationStatusRestricted.Message".localized
                self.transition(to: messageViewController)
            case .authorizedWhenInUse, .authorizedAlways:
                self.transition(to: SpeedometerViewController(locationManager: self.locationManager, unit: Unit(rawValue: UserDefaults.standard.string(forKey: Configuration.currentUnitDefaultsKey)!)!))
            }
        }
    }
}
