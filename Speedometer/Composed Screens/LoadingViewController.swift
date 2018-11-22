import UIKit

class LoadingViewController: UIViewController {

    // MARK: - View Controller Lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)

        view.backgroundColor = .white
        setupUnitSelectionView()
        setupLoadingIndicatorView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LoadingViewController {

    // MARK: - Private Methods

    func setupLoadingIndicatorView() {
        let loadingIndicatorViewController = LoadingIndicatorViewController()
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

    func setupUnitSelectionView() {
        let unitSelectionViewController = UnitSelectionViewController()
        unitSelectionViewController.hideStackView = true
        addChild(unitSelectionViewController)

        let unitSelectionView = unitSelectionViewController.view!
        view.addSubview(unitSelectionView)

        unitSelectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            unitSelectionView.leadingAnchor.constraint(equalTo: unitSelectionView.leadingAnchor),
            unitSelectionView.topAnchor.constraint(equalTo: unitSelectionView.topAnchor),
            unitSelectionView.bottomAnchor.constraint(equalTo: unitSelectionView.bottomAnchor),
            unitSelectionView.trailingAnchor.constraint(equalTo: unitSelectionView.trailingAnchor),
            unitSelectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            unitSelectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            unitSelectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        unitSelectionViewController.didMove(toParent: self)
    }
}
