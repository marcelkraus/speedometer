import UIKit

class SpeedLimiterInfoViewController: UIViewController {

    // MARK: - Properties

    var delegate: SpeedLimiterViewControllerDelegate?

    // MARK: - Outlets & Actions

    @IBOutlet weak var statusLabel: UILabel! {
        didSet {
            statusLabel.text = "SpeedLimiterInfoViewController.Status".localized
        }
    }

    @IBOutlet weak var button: UIButton! {
        didSet {
            button.setTitle("SpeedLimiterInfoViewController.Button".localized, for: .normal)
        }
    }

    @IBAction func buttonWasTapped(_ sender: Any) {
        delegate?.didDisableSpeedLimiter()
    }

}
