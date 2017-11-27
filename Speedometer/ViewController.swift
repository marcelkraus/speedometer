import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!

    private var theme = Theme.light
    private let locationManager = CLLocationManager()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return theme == .dark ? .lightContent : .default
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initGestureRecognizer()
        initLocationManager()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        updateDisplay(unit: Unit.kilometersPerHour, speed: locationManager.location?.speed ?? 0)
    }

}

private extension ViewController {

    enum Theme {
        case dark, light
    }

    func initLocationManager() {
        locationManager.requestWhenInUseAuthorization()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation

        locationManager.startUpdatingLocation()
    }

    func initGestureRecognizer() {
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(toggleTheme))
        recognizer.direction = [.left, .right]
        recognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(recognizer)
    }

    func updateDisplay(unit: Unit, speed: Double) {
        let speed = speed > 1.0 ? speed * unit.factor : 0

        unitLabel.text = unit.rawValue
        speedLabel.text = String(format: "%03.0f", speed)
    }

    @objc func toggleTheme() {
        theme = theme == .dark ? .light : .dark

        switch theme {
        case .dark:
            view.backgroundColor = UIColor.black
            speedLabel.textColor = UIColor.white
            unitLabel.textColor = UIColor.white
        case .light:
            view.backgroundColor = UIColor.white
            speedLabel.textColor = UIColor.black
            unitLabel.textColor = UIColor.black
        }

        setNeedsStatusBarAppearanceUpdate()
    }

}
