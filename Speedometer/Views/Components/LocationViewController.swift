import UIKit

class LocationViewController: UIViewController {
    private lazy var locationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.numberOfLines = 2
        locationLabel.font = .location
        locationLabel.textColor = .location

        return locationLabel
    }()

    var location: Location? {
        didSet {
            guard let location = location else {
                return
            }

            locationLabel.text = "\(location.localizedString.latitude)\n\(location.localizedString.longitude)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(locationLabel)
        NSLayoutConstraint.activate([
            locationLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            locationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            locationLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
