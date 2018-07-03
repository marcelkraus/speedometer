import UIKit

class LoadingViewController: UIViewController {
    @IBOutlet weak var loadingIndicatorLabel: UILabel! {
        didSet {
            loadingIndicatorLabel.text = "LoadingViewController.Indicator".localized
        }
    }
}
