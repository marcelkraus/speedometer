import UIKit

class LoadingViewController: UIViewController {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8.0
        stackView.addArrangedSubview(activityIndicatorView)
        stackView.addArrangedSubview(indicatorLabel)

        return stackView
    }()

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.color = AppDelegate.shared.theme.primaryContentColor
        activityIndicatorView.startAnimating()

        return activityIndicatorView
    }()

    private lazy var indicatorLabel: UILabel = {
        let indicatorLabel = UILabel()
        indicatorLabel.translatesAutoresizingMaskIntoConstraints = false
        indicatorLabel.font = AppDelegate.shared.theme.activityIndicatorFont
        indicatorLabel.textColor = AppDelegate.shared.theme.primaryContentColor
        indicatorLabel.text = "LoadingIndicatorViewController.Indicator".localized

        return indicatorLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }
}
