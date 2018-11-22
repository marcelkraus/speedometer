import UIKit

class LoadingViewController: UIViewController {

    // MARK: - Outlets & Actions

    @IBOutlet weak var unitSelectionView: UIView!
    @IBOutlet weak var loadingIndicatorView: UIView!

    // MARK: - View Controller Lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupContainerViewControllers()
    }
}

private extension LoadingViewController {

    // MARK: - Private Methods

    func setupContainerViewControllers() {
        let unitSelectionViewController = UnitSelectionViewController()
        unitSelectionViewController.hideStackView = true
        addChild(unitSelectionViewController)
        unitSelectionView.addSubview(unitSelectionViewController.view)
        unitSelectionViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            unitSelectionView.leadingAnchor.constraint(equalTo: unitSelectionViewController.view.leadingAnchor),
            unitSelectionView.topAnchor.constraint(equalTo: unitSelectionViewController.view.topAnchor),
            unitSelectionView.bottomAnchor.constraint(equalTo: unitSelectionViewController.view.bottomAnchor),
            unitSelectionView.trailingAnchor.constraint(equalTo: unitSelectionViewController.view.trailingAnchor),
            ])
        unitSelectionViewController.didMove(toParent: self)

        let loadingIndicatorViewController = LoadingIndicatorViewController()
        addChild(loadingIndicatorViewController)
        loadingIndicatorView.addSubview(loadingIndicatorViewController.view)
        loadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingIndicatorView.leadingAnchor.constraint(equalTo: loadingIndicatorViewController.view.leadingAnchor),
            loadingIndicatorView.topAnchor.constraint(equalTo: loadingIndicatorViewController.view.topAnchor),
            loadingIndicatorView.bottomAnchor.constraint(equalTo: loadingIndicatorViewController.view.bottomAnchor),
            loadingIndicatorView.trailingAnchor.constraint(equalTo: loadingIndicatorViewController.view.trailingAnchor),
            ])
        loadingIndicatorViewController.didMove(toParent: self)
    }
}
