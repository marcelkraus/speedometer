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

// MARK: - Private Methods

private extension LoadingViewController {
    func setupContainerViewControllers() {
        let unitSelectionViewController = UnitSelectionViewController()
        unitSelectionViewController.hideStackView = true
        addChild(unitSelectionViewController)
        unitSelectionView.addSubview(unitSelectionViewController.view)
        unitSelectionViewController.didMove(toParent: self)

        let loadingIndicatorViewController = LoadingIndicatorViewController()
        addChild(loadingIndicatorViewController)
        loadingIndicatorView.addSubview(loadingIndicatorViewController.view)
        loadingIndicatorViewController.didMove(toParent: self)
    }
}
