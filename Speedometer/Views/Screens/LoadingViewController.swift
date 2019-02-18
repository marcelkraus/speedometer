import UIKit

class LoadingViewController: UIViewController {
    var loadingIndicatorViewController: LoadingIndicatorViewController!

    init() {
        super.init(nibName: nil, bundle: nil)

        setupLoadingIndicatorView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Setup

private extension LoadingViewController {
    func setupLoadingIndicatorView() {
        loadingIndicatorViewController = LoadingIndicatorViewController()
        addChild(loadingIndicatorViewController)

        let loadingIndicatorView = loadingIndicatorViewController.view!
        view.addSubview(loadingIndicatorView)

        loadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingIndicatorView.leadingAnchor.constraint(equalTo: loadingIndicatorView.leadingAnchor),
            loadingIndicatorView.topAnchor.constraint(equalTo: loadingIndicatorView.topAnchor),
            loadingIndicatorView.bottomAnchor.constraint(equalTo: loadingIndicatorView.bottomAnchor),
            loadingIndicatorView.trailingAnchor.constraint(equalTo: loadingIndicatorView.trailingAnchor),
            loadingIndicatorView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loadingIndicatorView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            ])
        loadingIndicatorViewController.didMove(toParent: self)
    }
}
