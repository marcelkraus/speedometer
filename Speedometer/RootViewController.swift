import CoreLocation
import UIKit

class RootViewController: UIViewController {
    private let locationManager = CLLocationManager()
    private var contentViewController: ContentViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        selectViewController()
    }
}

// MARK: - CLLocationManagerDelegate

extension RootViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.selectViewController()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }

        contentViewController.update(with: location.speed, at: Location(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
    }
}

// MARK: - Private Methods

private extension RootViewController {
    func selectViewController() {
        transition(to: LoadingViewController()) { _ in
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                let onboardingViewController = OnboardingViewController()
                onboardingViewController.delegate = self

                self.transition(to: onboardingViewController)
            case .restricted:
                self.locationManager.stopUpdatingLocation()

                self.transition(to: MessageViewController(messageType: .locationAuthorizationStatusRestricted))
            case .denied:
                self.locationManager.stopUpdatingLocation()

                self.transition(to: MessageViewController(messageType: .locationAuthorizationStatusDenied))
            case .authorizedWhenInUse, .authorizedAlways:
                self.locationManager.startUpdatingLocation()

                self.contentViewController = ContentViewController()
                self.transition(to: self.contentViewController)
            @unknown default:
                fatalError("selectViewController() has been detected an unsupported authorization status of the CLLocationManager instance")
            }
        }
    }
}

// MARK: - OnboardingViewControllerDelegate

extension RootViewController: OnboardingViewControllerDelegate {
    func didTapAuthorizeButton() {
        locationManager.requestWhenInUseAuthorization()
    }
}
