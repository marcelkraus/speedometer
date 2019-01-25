import UIKit

class SpeedometerViewController: UIViewController {
    var imprintButtonView: UIView!
    var circularView: UIView!
    var speedView: UIView!
    var coordinatesView: UIView!
    var speedLimiterView: UIView!

    init() {
        super.init(nibName: nil, bundle: nil)

        view.backgroundColor = .white

        setupCircularView()
        setupSpeedView()
        setupCoordinatesView()
        setupSpeedLimiterView()
        setupImprintButtonView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SpeedometerViewController {
    func setupImprintButtonView() {
        let imprintButtonViewController = ImprintButtonViewController()
        addChild(imprintButtonViewController)

        imprintButtonView = imprintButtonViewController.view!
        view.addSubview(imprintButtonView)

        imprintButtonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imprintButtonView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            imprintButtonView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            ])
        imprintButtonViewController.didMove(toParent: self)
    }

    func setupCircularView() {
        let circularViewController = CircularViewController()
        addChild(circularViewController)

        circularView = circularViewController.view! as? CircularView
        view.addSubview(circularView)

        circularView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            circularView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            circularView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            circularView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            circularView.heightAnchor.constraint(equalTo: circularView.widthAnchor, multiplier: 1.0),
            ])
        circularViewController.didMove(toParent: self)
    }

    func setupSpeedView() {
        let speedViewController = SpeedViewController()
        addChild(speedViewController)

        speedView = speedViewController.view!
        view.addSubview(speedView)

        speedView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            speedView.trailingAnchor.constraint(equalTo: circularView.trailingAnchor),
            speedView.bottomAnchor.constraint(equalTo: circularView.bottomAnchor),
            ])
        speedViewController.didMove(toParent: self)
    }

    func setupCoordinatesView() {
        let coordinatesViewController = CoordinatesViewController()
        addChild(coordinatesViewController)

        coordinatesView = coordinatesViewController.view!
        view.addSubview(coordinatesView)

        coordinatesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            coordinatesView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            coordinatesView.topAnchor.constraint(equalTo: speedView.bottomAnchor, constant: 20),
            coordinatesView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
        coordinatesViewController.didMove(toParent: self)
    }

    func setupSpeedLimiterView() {
        let speedLimiterViewController = SpeedLimiterViewController()
        addChild(speedLimiterViewController)

        speedLimiterView = speedLimiterViewController.view!
        view.addSubview(speedLimiterView)

        speedLimiterView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            speedLimiterView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            speedLimiterView.topAnchor.constraint(equalTo: coordinatesView.bottomAnchor, constant: 20),
            speedLimiterView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
        speedLimiterViewController.didMove(toParent: self)
    }
}
