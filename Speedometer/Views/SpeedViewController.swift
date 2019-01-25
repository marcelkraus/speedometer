import CoreLocation
import UIKit

class SpeedViewController: UIViewController {

    // MARK: - Properties

    let locationManager = CLLocationManager()

    // MARK: - Outlets & Actions

    @IBOutlet weak var speedLabel: UILabel!

    @IBOutlet weak var unitLabel: UILabel!

    @IBOutlet weak var unitBackgroundView: UIView! {
        didSet {
            unitBackgroundView.layer.masksToBounds = true
            unitBackgroundView.layer.cornerRadius = unitBackgroundView.frame.height/4
        }
    }

    // MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
}

extension SpeedViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var unit: Unit {
            return Unit(rawValue: UserDefaults.standard.string(forKey: AppConfig.UserDefaultsKey.unit)!)!
        }

        guard let location = locations.last else {
            return
        }

        let speed = Speed(speed: location.speed, unit: unit)
        speedLabel.text = speed.asString
        unitLabel.text = speed.unit.abbreviation
    }
}
