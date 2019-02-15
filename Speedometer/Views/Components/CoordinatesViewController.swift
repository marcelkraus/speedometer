import UIKit

class CoordinatesViewController: UIViewController {
    var coordinates: Coordinates? {
        didSet {
            guard let coordinates = coordinates else {
                return
            }

            coordinatesLabel.text = "\(coordinates.formatted.latitude)\n\(coordinates.formatted.longitude)"
        }
    }

    private lazy var coordinatesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .darkGray

        return label
    }()

    init() {
        super.init(nibName: nil, bundle: nil)

        setupCoordinatesLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CoordinatesViewController {
    func setupCoordinatesLabel() {
        view.addSubview(coordinatesLabel)
        coordinatesLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            coordinatesLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            coordinatesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            coordinatesLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            coordinatesLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
}
