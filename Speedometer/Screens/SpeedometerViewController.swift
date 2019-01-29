import CoreLocation
import UIKit

class SpeedometerViewController: UIViewController {
    private let locationManager = CLLocationManager()

    private var swipeInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "↓ " + "SpeedometerViewController.SwipeInfo".localized + " ↓"
        label.font = .preferredFont(forTextStyle: .caption2)
        label.textColor = .darkGray

        return label
    }()

    private var circularViewController: CircularViewController!

    private var speedViewController: SpeedViewController!

    private var coordinatesViewController: CoordinatesViewController!

    private var imprintButtonView: UIView!

    private var circularView: CircularView!

    private var speedView: UIView!

    private var coordinatesView: UIView!

    var unit: Unit = Unit(rawValue: UserDefaults.standard.string(forKey: AppConfig.UserDefaultsKey.unit)!)! {
        didSet {
            UserDefaults.standard.set(unit.next.rawValue, forKey: AppConfig.UserDefaultsKey.unit)
            speedViewController.unit = unit
        }
    }

    init() {
        super.init(nibName: nil, bundle: nil)

        view.backgroundColor = .white
        setupSwipeInfoLabel()
        setupImprintButtonView()
        setupCircularView()
        setupSpeedView()
        setupCoordinatesView()
        setupGestureRecognizer()

        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Obj-C Selectors

private extension SpeedometerViewController {
    @objc func selectNextUnit() {
        unit = unit.next
    }
}

// MARK: - CLLocationManagerDelegate

extension SpeedometerViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }

        let speed = Speed(speed: location.speed, unit: unit)

        circularViewController.speed = speed
        speedViewController.speed = speed
        speedViewController.unit = unit
        coordinatesViewController.coordinates = Coordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }
}

// MARK: - UI Setup

private extension SpeedometerViewController {
    func setupSwipeInfoLabel() {
        view.addSubview(swipeInfoLabel)
        swipeInfoLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            swipeInfoLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            swipeInfoLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20.0)
            ])
    }

    func setupImprintButtonView() {
        let imprintButtonViewController = ImprintButtonViewController()
        addChild(imprintButtonViewController)

        imprintButtonView = imprintButtonViewController.view!
        view.addSubview(imprintButtonView)

        imprintButtonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imprintButtonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            imprintButtonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20.0)
            ])
        imprintButtonViewController.didMove(toParent: self)
    }

    func setupCircularView() {
        circularViewController = CircularViewController()
        addChild(circularViewController)

        circularView = circularViewController.view! as? CircularView
        view.addSubview(circularView)

        circularView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            circularView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            circularView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            circularView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            circularView.heightAnchor.constraint(equalTo: circularView.widthAnchor, multiplier: 1.0)
            ])
        circularViewController.didMove(toParent: self)
    }

    func setupSpeedView() {
        speedViewController = SpeedViewController()
        addChild(speedViewController)

        speedView = speedViewController.view!
        view.addSubview(speedView)

        speedView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            speedView.trailingAnchor.constraint(equalTo: circularView.trailingAnchor),
            speedView.bottomAnchor.constraint(equalTo: circularView.bottomAnchor)
            ])
        speedViewController.didMove(toParent: self)
    }

    func setupCoordinatesView() {
        coordinatesViewController = CoordinatesViewController()
        addChild(coordinatesViewController)

        coordinatesView = coordinatesViewController.view!
        view.addSubview(coordinatesView)

        coordinatesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            coordinatesView.topAnchor.constraint(equalTo: circularView.bottomAnchor),
            coordinatesView.bottomAnchor.constraint(equalTo: imprintButtonView.topAnchor),
            coordinatesView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
            ])
        coordinatesViewController.didMove(toParent: self)
    }

    func setupGestureRecognizer() {
        let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(selectNextUnit))
        gestureRecognizer.direction = .down
        view.addGestureRecognizer(gestureRecognizer)
    }
}
