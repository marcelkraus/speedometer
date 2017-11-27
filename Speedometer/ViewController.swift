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
        unitLabel.text = Unit.kilometersPerHour.rawValue
        speedLabel.text = speed(locationManager.location!.speed, inUnit: Unit.kilometersPerHour)
    }

}

private extension ViewController {

    func initLocationManager() {
        locationManager.requestWhenInUseAuthorization()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation

        locationManager.startUpdatingLocation()
    }

    func speed(_ speed: Double, inUnit unit: Unit) -> String {
        return String(format: "%03.0f", speed * unit.factor)
    }

}
