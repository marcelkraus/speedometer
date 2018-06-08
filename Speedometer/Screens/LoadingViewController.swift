import UIKit

class LoadingViewController: UIViewController {
    @IBOutlet weak var loadingIndicatorLabel: UILabel! {
        didSet {
            loadingIndicatorLabel.text = "LoadingViewController.Indicator".localized
        }
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
}
