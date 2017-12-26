import CoreLocation
import UIKit

class FlowViewController: UIViewController {

    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        transition(to: LoadingViewController())
    }

}

extension FlowViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch CLLocationManager.authorizationStatus()  {
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
        case .restricted:
            self.transition(to: MessageViewController(message: "The user cannot change this app’s status, possibly due to active restrictions such as parental controls being in place.", heading: ".restricted"))
        case .denied:
            self.transition(to: MessageViewController(message: "The user explicitly denied the use of location services for this app or location services are currently disabled in Settings.", heading: ".denied"))
        case .authorizedWhenInUse, .authorizedAlways:
            self.transition(to: SpeedometerViewController(locationManager: self.locationManager, unit: .kilometersPerHour))
        }
    }

}
