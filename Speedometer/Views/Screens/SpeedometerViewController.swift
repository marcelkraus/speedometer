import UIKit

class SpeedometerViewController: UIViewController {
    var circularViewController: CircularViewController!
    var coordinatesViewController: CoordinatesViewController!
    var speedViewController: SpeedViewController!

    private lazy var swipeInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "↓ " + "SpeedometerViewController.SwipeInfo".localized + " ↓"
        label.font = .swipeInfo
        label.textColor = .swipeInfo

        return label
    }()

    private lazy var settingsButtonView: UIButton = {
        let settingsButtonView = UIButton(type: .infoDark)
        settingsButtonView.translatesAutoresizingMaskIntoConstraints  = false
        settingsButtonView.tintColor = .branding
        settingsButtonView.addTarget(self, action: #selector(showSettings), for: .touchUpInside)

        return settingsButtonView
    }()

    var unit: Unit = Unit.selected {
        didSet {
            speedViewController.unit = unit
        }
    }

    init() {
        super.init(nibName: nil, bundle: nil)

        setupSwipeInfoLabel()
        setupSettingsButtonView()
        setupCircularView()
        setupSpeedView()
        setupCoordinatesView()
        setupGestureRecognizer()

        StoreReviewHelper.askForReview()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(deviceValue: Double, coordinates: Coordinates) {
        circularViewController.fillmentLevel = unit.calculcateFillment(for: deviceValue)
        speedViewController.speed = unit.calculateSpeed(for: deviceValue)
        speedViewController.unit = unit
        coordinatesViewController.coordinates = coordinates
    }
}

// MARK: - Obj-C Selectors

@objc private extension SpeedometerViewController {
    func showSettings() {
        present(SettingsViewController(), animated: true, completion: nil)
    }

    func selectNextUnit() {
        let impactGenerator = UIImpactFeedbackGenerator(style: .medium)
        impactGenerator.prepare()

        unit = unit.next

        impactGenerator.impactOccurred()
    }
}

// MARK: - UI Setup

private extension SpeedometerViewController {
    func setupCircularView() {
        circularViewController = CircularViewController()
        addChild(circularViewController)

        let circularView = circularViewController.view!
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

    func setupCoordinatesView() {
        coordinatesViewController = CoordinatesViewController()
        addChild(coordinatesViewController)

        let coordinatesView = coordinatesViewController.view!
        view.addSubview(coordinatesView)

        coordinatesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            coordinatesView.topAnchor.constraint(equalTo: circularViewController.view.bottomAnchor),
            coordinatesView.bottomAnchor.constraint(equalTo: settingsButtonView.topAnchor),
            coordinatesView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
            ])
        coordinatesViewController.didMove(toParent: self)
    }
    
    func setupGestureRecognizer() {
        let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(selectNextUnit))
        gestureRecognizer.direction = .down
        view.addGestureRecognizer(gestureRecognizer)
    }

    func setupSettingsButtonView() {
        view.addSubview(settingsButtonView)
        NSLayoutConstraint.activate([
            settingsButtonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            settingsButtonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20.0)
        ])
    }

    func setupSpeedView() {
        speedViewController = SpeedViewController()
        addChild(speedViewController)

        let speedView = speedViewController.view!
        view.addSubview(speedView)

        speedView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            speedView.trailingAnchor.constraint(equalTo: circularViewController.view.trailingAnchor),
            speedView.bottomAnchor.constraint(equalTo: circularViewController.view.bottomAnchor)
            ])
        speedViewController.didMove(toParent: self)
    }

    func setupSwipeInfoLabel() {
        view.addSubview(swipeInfoLabel)
        swipeInfoLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            swipeInfoLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            swipeInfoLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20.0)
            ])
    }
}
