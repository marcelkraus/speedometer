import UIKit

class SpeedViewController: UIViewController {
    private lazy var speedLabel: UILabel = {
        let speedLabel = UILabel()
        speedLabel.translatesAutoresizingMaskIntoConstraints = false
        speedLabel.font = AppDelegate.shared.theme.speedFont
        speedLabel.textColor = AppDelegate.shared.theme.primaryContentColor
        speedLabel.textAlignment = .right
        speedLabel.text = "0"

        return speedLabel
    }()

    private lazy var unitBackgroundView: UIView = {
        let unitBackgroundView = UIView()
        unitBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        unitBackgroundView.backgroundColor = AppDelegate.shared.theme.interactionColor
        unitBackgroundView.layer.cornerRadius = 20.0
        unitBackgroundView.layer.masksToBounds = true

        return unitBackgroundView
    }()

    private lazy var unitLabel: UILabel = {
        let unitLabel = UILabel()
        unitLabel.translatesAutoresizingMaskIntoConstraints = false
        unitLabel.font = AppDelegate.shared.theme.unitFont
        unitLabel.textColor = AppDelegate.shared.theme.onInteractionColor
        unitLabel.textAlignment = .center

        return unitLabel
    }()

    var speed: Double = 0.0 {
        didSet {
            speedLabel.text = unit.localizedString(for: speed)
        }
    }

    var unit: Unit = Unit.selected {
        didSet {
            unitLabel.text = unit.rawValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(speedLabel)
        view.addSubview(unitBackgroundView)
        unitBackgroundView.addSubview(unitLabel)

        NSLayoutConstraint.activate([
            speedLabel.heightAnchor.constraint(equalToConstant: 90.0),
            speedLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            speedLabel.bottomAnchor.constraint(equalTo: unitBackgroundView.topAnchor, constant: -20.0),
            unitBackgroundView.heightAnchor.constraint(equalToConstant: 40.0),
            unitBackgroundView.widthAnchor.constraint(equalToConstant: 180.0),
            unitBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            unitBackgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 40.0),
            unitBackgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            unitLabel.centerXAnchor.constraint(equalTo: unitBackgroundView.centerXAnchor),
            unitLabel.centerYAnchor.constraint(equalTo: unitBackgroundView.centerYAnchor)
        ])
    }
}
