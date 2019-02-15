import UIKit

class SpeedViewController: UIViewController {
    private let speedLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 120.0, weight: .thin)
        label.textAlignment = .right
        label.text = "120"

        return label
    }()

    private let unitLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.textColor = .white
        label.textAlignment = .center

        return label
    }()

    private let unitBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.012, green: 0.569, blue: 0.576, alpha: 1.00)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20.0

        return view
    }()

    var speed: Speed? {
        didSet {
            guard let speed = speed else {
                return
            }

            speedLabel.text = speed.asString
        }
    }

    var unit: Unit = Unit(rawValue: UserDefaults.standard.string(forKey: AppConfig.UserDefaultsKey.unit)!)! {
        didSet {
            unitLabel.text = unit.abbreviation
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
