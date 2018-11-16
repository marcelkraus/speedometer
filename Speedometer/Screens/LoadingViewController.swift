import UIKit

class LoadingViewController: UIViewController {
    @IBOutlet weak var unitSelectionView: UIView!
    @IBOutlet weak var loadingIndicatorView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupContainerViewControllers()
    }
}

private extension LoadingViewController {
    func setupContainerViewControllers() {
        let unitSelectionViewController = UnitSelectionViewController()
        addChild(unitSelectionViewController)
        unitSelectionView.addSubview(unitSelectionViewController.view)
        unitSelectionViewController.didMove(toParent: self)

        let loadingIndicatorViewController = LoadingIndicatorViewController()
        addChild(loadingIndicatorViewController)
        loadingIndicatorView.addSubview(loadingIndicatorViewController.view)
        loadingIndicatorViewController.didMove(toParent: self)
    }
}
