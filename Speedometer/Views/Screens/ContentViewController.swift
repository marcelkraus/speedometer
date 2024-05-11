import UIKit

class ContentViewController: UIViewController {
    private let circularView: CircularView = {
        let circularView = CircularView(indicatorColor: AppDelegate.shared.theme.interactionColor, trackColor: AppDelegate.shared.theme.tertiaryContentColor, indicatorFillment: 0.0)
        circularView.translatesAutoresizingMaskIntoConstraints = false

        return circularView
    }()

    var locationViewController: LocationViewController!

    var speedViewController: SpeedViewController!

    private lazy var swipeInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "↓ " + "SpeedometerViewController.SwipeInfo".localized + " ↓"
        label.font = AppDelegate.shared.theme.swipeInfoFont
        label.textColor = AppDelegate.shared.theme.tertiaryContentColor

        return label
    }()

    private lazy var settingsButtonView: UIButton = {
        let settingsButtonView = UIButton(type: .custom)
        settingsButtonView.translatesAutoresizingMaskIntoConstraints = false
        settingsButtonView.tintColor = AppDelegate.shared.theme.interactionColor
        settingsButtonView.setImage(UIImage(named: "Info")?.withRenderingMode(.alwaysTemplate), for: .normal)
        settingsButtonView.contentEdgeInsets = UIEdgeInsets(top: 12.0, left: 12.0, bottom: 12.0, right: 12.0)

        settingsButtonView.addTarget(self, action: #selector(showSettings), for: .touchUpInside)

        return settingsButtonView
    }()

    var unit: Unit = .selected {
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
        setupLocationView()
        setupGestureRecognizer()

        StoreReviewHelper.askForReview(in: view.window?.windowScene)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with speedProvidedByDevice: Double, at location: Location) {
        circularView.indicatorFillment = unit.calculcateFillment(for: speedProvidedByDevice)
        speedViewController.speed = unit.calculateSpeed(for: speedProvidedByDevice)
        speedViewController.unit = unit
        locationViewController.location = location
    }
}

// MARK: - Obj-C Selectors

@objc private extension ContentViewController {
    func showSettings() {
        let settingsViewController = SettingsViewController()
        settingsViewController.modalPresentationStyle = .fullScreen
        settingsViewController.delegate = self

        present(settingsViewController, animated: true, completion: nil)
    }

    func selectNextUnit() {
        let impactGenerator = UIImpactFeedbackGenerator(style: .medium)
        impactGenerator.prepare()

        unit = unit.next

        impactGenerator.impactOccurred()
    }
}

// MARK: - UI Setup

private extension ContentViewController {
    func setupCircularView() {
        view.addSubview(circularView)

        NSLayoutConstraint.activate([
            circularView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            circularView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            circularView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            circularView.heightAnchor.constraint(equalTo: circularView.widthAnchor, multiplier: 1.0),
        ])
    }

    func setupLocationView() {
        locationViewController = LocationViewController()
        addChild(locationViewController)

        let locationView = locationViewController.view!
        view.addSubview(locationView)

        locationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationView.topAnchor.constraint(equalTo: circularView.bottomAnchor),
            locationView.bottomAnchor.constraint(equalTo: settingsButtonView.topAnchor),
            locationView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
        locationViewController.didMove(toParent: self)
    }

    func setupGestureRecognizer() {
        let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(selectNextUnit))
        gestureRecognizer.direction = .down
        view.addGestureRecognizer(gestureRecognizer)
    }

    func setupSettingsButtonView() {
        view.addSubview(settingsButtonView)
        NSLayoutConstraint.activate([
            settingsButtonView.heightAnchor.constraint(equalToConstant: 44.0),
            settingsButtonView.widthAnchor.constraint(equalToConstant: 44.0),
            settingsButtonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8.0),
            settingsButtonView.bottomAnchor.constraint(equalTo: swipeInfoLabel.bottomAnchor, constant: 12.0),
        ])
    }

    func setupSpeedView() {
        speedViewController = SpeedViewController()
        addChild(speedViewController)

        let speedView = speedViewController.view!
        view.addSubview(speedView)

        speedView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            speedView.trailingAnchor.constraint(equalTo: circularView.trailingAnchor),
            speedView.bottomAnchor.constraint(equalTo: circularView.bottomAnchor),
        ])
        speedViewController.didMove(toParent: self)
    }

    func setupSwipeInfoLabel() {
        view.addSubview(swipeInfoLabel)
        swipeInfoLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            swipeInfoLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            swipeInfoLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20.0),
        ])
    }
}

extension ContentViewController: SettingsViewControllerDelegate {
    func settingsViewControllerDidTapCloseButton(_ settingsViewController: SettingsViewController) {
        settingsViewController.dismiss(animated: true, completion: nil)
    }
}
