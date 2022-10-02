import UIKit

class BlockingOverlayViewController: UIViewController {
    private lazy var backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = UIColor(white: 1, alpha: 0.9)

        backgroundView.addSubview(canvasView)
        NSLayoutConstraint.activate([
            canvasView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            canvasView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
        ])

        return backgroundView
    }()

    private lazy var canvasView: UIView = {
        let canvasView = UIView()
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        canvasView.backgroundColor = AppDelegate.shared.theme.interactionColor
        canvasView.layer.masksToBounds = true
        canvasView.layer.cornerRadius = 20.0
        canvasView.widthAnchor.constraint(equalToConstant: 200).isActive = true

        canvasView.addSubview(activityIndicatorView)
        canvasView.addSubview(label)
        NSLayoutConstraint.activate([
            activityIndicatorView.topAnchor.constraint(equalTo: canvasView.topAnchor, constant: 20.0),
            activityIndicatorView.centerXAnchor.constraint(equalTo: canvasView.centerXAnchor),
            label.centerXAnchor.constraint(equalTo: canvasView.centerXAnchor),
            label.topAnchor.constraint(equalTo: activityIndicatorView.bottomAnchor, constant: 20.0),
            label.bottomAnchor.constraint(equalTo: canvasView.bottomAnchor, constant: -20.0),
        ])

        return canvasView
    }()

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.style = .large
        activityIndicatorView.startAnimating()

        return activityIndicatorView
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppDelegate.shared.theme.headingFont
        label.textColor = AppDelegate.shared.theme.onInteractionColor
        label.text = "BlockingOverlayViewController.LoadingMessage".localized

        return label
    }()

    override func viewDidLoad() {
        view.addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }
}
