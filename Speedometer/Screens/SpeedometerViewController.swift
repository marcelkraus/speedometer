import UIKit

class SpeedometerViewController: UIViewController {
    private var imprintButtonView: UIView!
    private var circularView: UIView!
    private var speedView: UIView!
    private var coordinatesView: UIView!

    init() {
        super.init(nibName: nil, bundle: nil)

        view.backgroundColor = .white
        setupImprintButtonView()
        setupCircularView()
        setupSpeedView()
        setupCoordinatesView()
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
            imprintButtonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            imprintButtonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20.0),
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
            circularView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            circularView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            circularView.heightAnchor.constraint(equalTo: circularView.widthAnchor, multiplier: 1.0)
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
            coordinatesView.topAnchor.constraint(equalTo: circularView.bottomAnchor),
            coordinatesView.bottomAnchor.constraint(equalTo: imprintButtonView.topAnchor),
            coordinatesView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
            ])
        coordinatesViewController.didMove(toParent: self)
    }
}
