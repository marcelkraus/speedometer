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
        let loadingViewController = LoadingViewController()
        transition(to: loadingViewController) { _ in
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                self.transition(to: self.storyboard!.instantiateViewController(withIdentifier: "WelcomeViewControllerIdentifier"))
            case .restricted:
                let messageViewController = self.storyboard!.instantiateViewController(withIdentifier: "MessageViewControllerIdentifier") as! MessageViewController
                messageViewController.messageType = .locationAuthorizationStatusRestricted
                self.transition(to: messageViewController)
            case .denied:
                let messageViewController = self.storyboard!.instantiateViewController(withIdentifier: "MessageViewControllerIdentifier") as! MessageViewController
                messageViewController.messageType = .locationAuthorizationStatusDenied
                self.transition(to: messageViewController)
            case .authorizedWhenInUse, .authorizedAlways:
                self.transition(to: self.storyboard!.instantiateViewController(withIdentifier: "SpeedometerViewControllerIdentifier"))
            }
        }
    }
}
