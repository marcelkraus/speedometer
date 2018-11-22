import UIKit

class LoadingIndicatorViewController: UIViewController {

    // MARK: - Outlets & Actions

    @IBOutlet weak var label: UILabel! {
        didSet {
            label.text = "LoadingIndicatorViewController.Indicator".localized
        }
    }

    // MARK: - View Controller Lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
