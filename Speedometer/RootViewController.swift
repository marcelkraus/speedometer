import CoreLocation
import UIKit

class RootViewController: UIViewController {
    private let locationManager = CLLocationManager()

    private var onboardingViewController: OnboardingViewController!
    private var speedometerViewController: SpeedometerViewController!

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

extension RootViewController: ButtonViewControllerDelegate {
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

extension RootViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.selectViewController()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }

        let speed = Speed(speed: location.speed, unit: speedometerViewController.unit)
        let coordinates = Coordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)

        speedometerViewController.update(speed: speed, coordinates: coordinates)
    }
}

// MARK: - Private Methods

private extension RootViewController {
    func selectViewController() {
        transition(to: LoadingViewController()) { _ in
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                self.locationManager.stopUpdatingLocation()
                self.onboardingViewController = OnboardingViewController()
                self.onboardingViewController.authorizationButtonViewController.delegate = self
                self.transition(to: self.onboardingViewController)
            case .restricted:
                self.locationManager.stopUpdatingLocation()
                self.transition(to: MessageViewController(messageType: .locationAuthorizationStatusRestricted))
            case .denied:
                self.locationManager.stopUpdatingLocation()
                self.transition(to: MessageViewController(messageType: .locationAuthorizationStatusDenied))
            case .authorizedWhenInUse, .authorizedAlways:
                self.locationManager.startUpdatingLocation()
                self.speedometerViewController = SpeedometerViewController()
                self.speedometerViewController.imprintButtonViewController.delegate = self
                self.transition(to: self.speedometerViewController)
            }
        }
    }
}
