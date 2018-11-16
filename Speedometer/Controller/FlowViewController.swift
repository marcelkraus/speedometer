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
        let storyboard = UIStoryboard(name: "Speedometer", bundle: Bundle.main)
        let loadingViewController = LoadingViewController()

        transition(to: loadingViewController) { _ in
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                self.transition(to: WelcomeViewController())
            case .restricted:
                self.transition(to: MessageViewController(messageType: .locationAuthorizationStatusRestricted))
            case .denied:
                self.transition(to: MessageViewController(messageType: .locationAuthorizationStatusDenied))
            case .authorizedWhenInUse, .authorizedAlways:
                self.transition(to: storyboard.instantiateViewController(withIdentifier: "SpeedometerViewControllerIdentifier"))
            }
        }
    }
}
