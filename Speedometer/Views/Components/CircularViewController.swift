import UIKit

class CircularViewController: UIViewController {
    var circularView = CircularView()

    var speed: Speed? {
        didSet {
            guard let speed = speed else {
                return
            }

            circularView.setFillmentLevel(speed.fillment)
        }
    }

    init() {
        super.init(nibName: nil, bundle: nil)

        setupCircularView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        circularView.updateAppearance(background: .circularViewBackground, filling: .branding)
    }
}

private extension CircularViewController {
    func setupCircularView() {
        view.addSubview(circularView)
        circularView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            circularView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            circularView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            circularView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            circularView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
    }
}
