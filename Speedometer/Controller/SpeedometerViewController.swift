import CoreLocation
import UIKit

class SpeedometerViewController: UIViewController {

    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var speedLabel: UILabel!
    @IBOutlet private weak var unitLabel: UILabel!

    private let locationManager: CLLocationManager

    private var speed = 0.0 {
        didSet {
            speedLabel.text = speed(speed, in: unit)
        }
    }

    private var unit: Unit {
        didSet {
            unitLabel.text = abbreviation(for: unit)
        }
    }

    private var theme = ThemeManager.themes.first! {
        didSet {
            view.backgroundColor = theme.color.background
            speedLabel.textColor = theme.color.speedLabel
            unitLabel.textColor = theme.color.unitLabel
        }
    }

    init(locationManager: CLLocationManager, unit: Unit) {
        self.locationManager = locationManager
        self.unit = unit

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLocationManager()
        setupGestureRecognizers()
    }

}

extension SpeedometerViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        speed = locations.last?.speed ?? 0
    }

}

private extension SpeedometerViewController {

    func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }

    func setupGestureRecognizers() {
        let nextThemeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(nextTheme))
        nextThemeGestureRecognizer.numberOfTouchesRequired = 2
        nextThemeGestureRecognizer.direction = .up
        view.addGestureRecognizer(nextThemeGestureRecognizer)

        let previousThemeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(previousTheme))
        previousThemeGestureRecognizer.numberOfTouchesRequired = 2
        previousThemeGestureRecognizer.direction = .down
        view.addGestureRecognizer(previousThemeGestureRecognizer)

        let toggleUnitGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleUnit))
        view.addGestureRecognizer(toggleUnitGestureRecognizer)
    }

    func speed(_ speed: Double, in unit: Unit) -> String {
        let speed = speed > 1.0 ? speed * unit.data.factor : 0

        return String(format: "%01.0f", speed)
    }

    func abbreviation(for unit: Unit) -> String {
        return unit.data.abbreviation
    }

    @objc func toggleUnit(_ recognizer: UITapGestureRecognizer) {
        guard recognizer.state == .ended else {
            return
        }

        unit.toggle()
    }

    @objc func nextTheme(_ recognizer: UISwipeGestureRecognizer) {
        guard recognizer.state == .recognized else {
            return
        }

        theme = ThemeManager().after(theme)
    }

    @objc func previousTheme(_ recognizer: UISwipeGestureRecognizer) {
        guard recognizer.state == .recognized else {
            return
        }

        theme = ThemeManager().before(theme)
    }

}
