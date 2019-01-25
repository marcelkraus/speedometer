import UIKit

protocol SpeedLimiterViewControllerDelegate {
    func didEnableSpeedLimiter()
    func didDisableSpeedLimiter()
}

class SpeedLimiterViewController: UIViewController {
    enum Status {
        case disabled, enabled
    }

    // MARK: - Properties

    private var speedLimiterButtonView: UIView!

    private var speedLimiterInfoView: UIView!

    private var status: Status = .disabled {
        didSet {
            switch status {
            case .disabled:
                speedLimiterButtonView.isHidden = false
                speedLimiterInfoView.isHidden = true
            case .enabled:
                speedLimiterButtonView.isHidden = true
                speedLimiterInfoView.isHidden = false
            }
        }
    }

    // MARK: - View Controller Lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)

        view.backgroundColor = .white

        setupSpeedLimiterButtonView()
        setupSpeedLimiterInfoView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SpeedLimiterViewController {

    // MARK: - Private Methods

    func setupSpeedLimiterButtonView() {
        let speedLimiterButtonViewController = SpeedLimiterButtonViewController()
        addChild(speedLimiterButtonViewController)

        speedLimiterButtonView = speedLimiterButtonViewController.view!
        view.addSubview(speedLimiterButtonView)

        speedLimiterButtonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            speedLimiterButtonView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            speedLimiterButtonView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            speedLimiterButtonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            speedLimiterButtonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        speedLimiterButtonViewController.didMove(toParent: self)

        speedLimiterButtonViewController.delegate = self
    }

    func setupSpeedLimiterInfoView() {
        let speedLimiterInfoViewController = SpeedLimiterInfoViewController()
        addChild(speedLimiterInfoViewController)

        speedLimiterInfoView = speedLimiterInfoViewController.view!
        view.addSubview(speedLimiterInfoView)

        speedLimiterInfoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            speedLimiterInfoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            speedLimiterInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            speedLimiterInfoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            speedLimiterInfoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        speedLimiterInfoViewController.didMove(toParent: self)

        speedLimiterInfoViewController.delegate = self

        speedLimiterInfoView.isHidden = true
    }
}

extension SpeedLimiterViewController: SpeedLimiterViewControllerDelegate {

    // MARK: - SpeedLimiterViewControllerDelegate

    func didEnableSpeedLimiter() {
        status = .enabled
    }

    func didDisableSpeedLimiter() {
        status = .disabled
    }
}
