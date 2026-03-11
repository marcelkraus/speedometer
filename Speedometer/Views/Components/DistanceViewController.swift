import UIKit

class DistanceViewController: UIViewController {
    private lazy var distanceLabel: UILabel = {
        let distanceLabel = UILabel()
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.font = AppDelegate.shared.theme.locationFont
        distanceLabel.textColor = AppDelegate.shared.theme.secondaryContentColor
        distanceLabel.textAlignment = .center
        distanceLabel.text = Distance.localizedString(for: .selected)

        return distanceLabel
    }()

    var distance: String? {
        didSet {
            distanceLabel.text = distance
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(distanceLabel)
        NSLayoutConstraint.activate([
            distanceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            distanceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            distanceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            distanceLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
