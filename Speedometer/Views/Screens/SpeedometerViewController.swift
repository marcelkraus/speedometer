import UIKit

class SpeedometerViewController: UIViewController {
    var circularViewController: CircularViewController!
    var coordinatesViewController: CoordinatesViewController!
    var imprintButtonViewController: ButtonViewController!
    var speedViewController: SpeedViewController!

    private var swipeInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "↓ " + "SpeedometerViewController.SwipeInfo".localized + " ↓"
        label.font = .preferredFont(forTextStyle: .caption2)
        label.textColor = .darkGray

        return label
    }()

    var unit: Unit = Unit.selected {
        didSet {
            speedViewController.unit = unit
        }
    }

    init() {
        super.init(nibName: nil, bundle: nil)

        setupSwipeInfoLabel()
        setupImprintButtonView()
        setupCircularView()
        setupSpeedView()
        setupCoordinatesView()
        setupGestureRecognizer()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(speed: Speed, coordinates: Coordinates) {
        circularViewController.speed = speed
        speedViewController.speed = speed
        speedViewController.unit = unit
        coordinatesViewController.coordinates = coordinates
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

// MARK: - Obj-C Selectors

private extension SpeedometerViewController {
    @objc func selectNextUnit() {
        unit = unit.next
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
            coordinatesView.bottomAnchor.constraint(equalTo: imprintButtonViewController.view.topAnchor),
            coordinatesView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
            ])
        coordinatesViewController.didMove(toParent: self)
    }
    
    func setupGestureRecognizer() {
        let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(selectNextUnit))
        gestureRecognizer.direction = .down
        view.addGestureRecognizer(gestureRecognizer)
    }

    func setupImprintButtonView() {
        imprintButtonViewController = ButtonViewController(type: .info)
        addChild(imprintButtonViewController)

        let imprintButtonView = imprintButtonViewController.view!
        view.addSubview(imprintButtonView)

        imprintButtonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imprintButtonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            imprintButtonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20.0)
            ])
        imprintButtonViewController.didMove(toParent: self)
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
