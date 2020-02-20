import UIKit

class LocationViewController: UIViewController {
    var location: Location? {
        didSet {
            guard let location = location else {
                return
            }

            locationLabel.text = "\(location.localizedString.latitude)\n\(location.localizedString.longitude)"
        }
    }

    private lazy var locationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.numberOfLines = 2
        locationLabel.font = .location
        locationLabel.textColor = .location

        return locationLabel
    }()

    init() {
        super.init(nibName: nil, bundle: nil)

        setupLocationLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LocationViewController {
    func setupLocationLabel() {
        view.addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            locationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            locationLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
}
