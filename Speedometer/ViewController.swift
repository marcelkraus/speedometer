import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!

    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initLocationManager()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        updateDisplay(unit: Unit.kilometersPerHour, speed: locationManager.location?.speed ?? 0)
    }

}

private extension ViewController {

    func initLocationManager() {
        locationManager.requestWhenInUseAuthorization()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation

        locationManager.startUpdatingLocation()
    }

    func updateDisplay(unit: Unit, speed: Double) {
        let speed = speed > 1.0 ? speed * unit.factor : 0

        unitLabel.text = unit.rawValue
        speedLabel.text = String(format: "%03.0f", speed)
    }

}
