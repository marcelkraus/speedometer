import CoreLocation
import UIKit

class FlowViewController: UIViewController {
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

extension FlowViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.chooseViewController()
    }
}

// MARK: - Private Methods

private extension FlowViewController {
    func chooseViewController() {
        let loadingViewController = appStoryboard.instantiateViewController(withIdentifier: "LoadingViewControllerIdentifier")
        transition(to: loadingViewController) { _ in
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                let welcomeViewController = self.appStoryboard.instantiateViewController(withIdentifier: "WelcomeViewControllerIdentifier") as! WelcomeViewController
                self.transition(to: welcomeViewController)
            case .restricted:
                let messageViewController = self.appStoryboard.instantiateViewController(withIdentifier: "MessageViewControllerIdentifier") as! MessageViewController
                messageViewController.heading = "FlowViewController.LocationAuthorizationStatusRestricted.Heading".localized
                messageViewController.message = "FlowViewController.LocationAuthorizationStatusRestricted.Message".localized
                self.transition(to: messageViewController)
            case .denied:
                let messageViewController = self.appStoryboard.instantiateViewController(withIdentifier: "MessageViewControllerIdentifier") as! MessageViewController
                messageViewController.heading = "FlowViewController.LocationAuthorizationStatusDenied.Heading".localized
                messageViewController.message = "FlowViewController.LocationAuthorizationStatusRestricted.Message".localized
                self.transition(to: messageViewController)
            case .authorizedWhenInUse, .authorizedAlways:
                self.transition(to: SpeedometerViewController(locationManager: self.locationManager, unit: Unit(rawValue: UserDefaults.standard.string(forKey: Configuration.currentUnitDefaultsKey)!)!))
            }
        }
    }
}
