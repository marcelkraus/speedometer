import UIKit

class LoadingIndicatorViewController: UIViewController {
    @IBOutlet weak var label: UILabel! {
        didSet {
            label.text = "LoadingIndicatorViewController.Indicator".localized
        }
    }
}
