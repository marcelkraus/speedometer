import UIKit

class CircularViewController: UIViewController {
    private lazy var circularView: CircularView = {
        let circularView = CircularView(indicatorColor: .branding, trackColor: .lightGray, indicatorFillment: 0.0)
        circularView.translatesAutoresizingMaskIntoConstraints = false

        return circularView
    }()

    var indicatorFillment: Double = 0.0 {
        didSet {
            circularView.indicatorFillment = indicatorFillment
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(circularView)

        NSLayoutConstraint.activate([
            circularView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            circularView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            circularView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            circularView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
