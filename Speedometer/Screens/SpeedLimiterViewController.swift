import UIKit

class SpeedLimiterViewController: UIViewController {
    private var buttonView: UIView!

    init() {
        super.init(nibName: nil, bundle: nil)

        view.backgroundColor = .white
        setupButtonView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SpeedLimiterViewController {
    func setupButtonView() {
        let speedLimiterButtonViewController = SpeedLimiterButtonViewController()
        addChild(speedLimiterButtonViewController)

        buttonView = speedLimiterButtonViewController.view!
        view.addSubview(buttonView)

        buttonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            buttonView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            buttonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            buttonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        speedLimiterButtonViewController.didMove(toParent: self)
    }
}
