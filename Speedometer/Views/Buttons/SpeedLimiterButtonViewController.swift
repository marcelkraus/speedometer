import UIKit

protocol SpeedLimiterButtonViewControllerDelegate {
    func didEnableSpeedLimiter()
}

class SpeedLimiterButtonViewController: UIViewController {
    var delegate: SpeedLimiterButtonViewControllerDelegate?

    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("SpeedLimiterButtonViewController.Button".localized, for: .normal)
        button.setTitleColor(UIColor(red: 0.012, green: 0.569, blue: 0.576, alpha: 1.00), for: .normal)
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        button.titleLabel?.font = .preferredFont(forTextStyle: .title3)

        return button
    }()

    init() {
        super.init(nibName: nil, bundle: nil)

        setupButtonView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func handleTap() {
        delegate?.didEnableSpeedLimiter()
    }
}

private extension SpeedLimiterButtonViewController {
    func setupButtonView() {
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
    }
}
