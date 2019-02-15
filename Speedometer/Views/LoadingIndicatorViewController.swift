import UIKit

class LoadingIndicatorViewController: UIViewController {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 20.0

        return stackView
    }()

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.color = .darkGray
        activityIndicatorView.startAnimating()

        return activityIndicatorView
    }()

    private lazy var indicatorLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .darkGray
        label.text = "LoadingIndicatorViewController.Indicator".localized

        return label
    }()

    init() {
        super.init(nibName: nil, bundle: nil)

        setupStackView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LoadingIndicatorViewController {
    func setupStackView() {
        stackView.addArrangedSubview(activityIndicatorView)
        stackView.addArrangedSubview(indicatorLabel)

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
            ])
    }
}
