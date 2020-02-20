import UIKit

class SpeedViewController: UIViewController {
    private lazy var speedLabel: UILabel = {
        let label = UILabel()
        label.font = .speed
        label.textColor = .speed
        label.textAlignment = .right
        label.text = "0"

        return label
    }()

    private lazy var unitLabel: UILabel = {
        let label = UILabel()
        label.font = .unit
        label.textColor = .unit
        label.textAlignment = .center

        return label
    }()

    private let unitBackgroundView = SeparatorView()

    var speed: Double? {
        didSet {
            guard let speed = speed else {
                return
            }

            speedLabel.text = unit.format(for: speed)
        }
    }

    var unit: Unit = Unit.selected {
        didSet {
            unitLabel.text = unit.rawValue
        }
    }

    init() {
        super.init(nibName: nil, bundle: nil)

        // explicitly assign unit again to call `didSet`, see https://goo.gl/iWB3df
        ({ self.unit = unit })()

        setupUnitLabelView()
        setupUnitBackgroundView()
        setupSpeedLabelView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SpeedViewController {
    func setupUnitLabelView() {
        unitBackgroundView.addSubview(unitLabel)
        unitLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            unitLabel.centerXAnchor.constraint(equalTo: unitBackgroundView.centerXAnchor),
            unitLabel.centerYAnchor.constraint(equalTo: unitBackgroundView.centerYAnchor)
            ])
    }

    func setupUnitBackgroundView() {
        view.addSubview(unitBackgroundView)
        unitBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            unitBackgroundView.heightAnchor.constraint(equalToConstant: 40.0),
            unitBackgroundView.widthAnchor.constraint(equalToConstant: 180.0),
            unitBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            unitBackgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 40.0),
            unitBackgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }

    func setupSpeedLabelView() {
        view.addSubview(speedLabel)
        speedLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            speedLabel.heightAnchor.constraint(equalToConstant: 90.0),
            speedLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            speedLabel.bottomAnchor.constraint(equalTo: unitBackgroundView.topAnchor, constant: -20.0)
            ])
    }
}
