import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var speedLabel: UILabel!

    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initLocationManager()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let speed = locationManager.location!.speed
        speedLabel.text = String(format: "%03.0f", speed)
    }

}

private extension ViewController {

    func initLocationManager() {
        locationManager.requestWhenInUseAuthorization()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation

        locationManager.startUpdatingLocation()
    }

}
