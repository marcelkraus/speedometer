import UIKit

class CircularViewController: UIViewController {
    private lazy var backgroundView: CircularView = {
        let backgroundView = CircularView(color: .lightGray, fillment: 1.0)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false

        return backgroundView
    }()

    private lazy var indicatorView: CircularView = {
        let indicatorView = CircularView(color: .branding, fillment: 0.0)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false

        return indicatorView
    }()

    var fillment: Double = 0.0 {
        didSet {
            indicatorView.fillment = fillment
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(backgroundView)
        view.addSubview(indicatorView)

        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            indicatorView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            indicatorView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            indicatorView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            indicatorView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
        ])
    }
}
