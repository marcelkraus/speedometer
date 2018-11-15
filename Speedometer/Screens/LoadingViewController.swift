import UIKit

class LoadingViewController: UIViewController {
    @IBOutlet weak var bottomBarView: UIView!
    @IBOutlet weak var loadingIndicatorView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupContainerViewControllers()
    }
}

private extension LoadingViewController {
    func setupContainerViewControllers() {
        let bottomBarViewController = BottomBarViewController()
        addChild(bottomBarViewController)
        bottomBarView.addSubview(bottomBarViewController.view)
        bottomBarViewController.didMove(toParent: self)

        let loadingIndicatorViewController = LoadingIndicatorViewController()
        addChild(loadingIndicatorViewController)
        loadingIndicatorView.addSubview(loadingIndicatorViewController.view)
        loadingIndicatorViewController.didMove(toParent: self)
    }
}
