import UIKit

class SpeedLimiterButtonViewController: UIViewController {

    // MARK: - Properties

    var delegate: SpeedLimiterViewControllerDelegate?

    // MARK: - Outlets & Actions

    @IBOutlet weak var statusLabel: UILabel! {
        didSet {
            statusLabel.text = "SpeedLimiterButtonViewController.Status".localized
        }
    }

    @IBOutlet weak var button: UIButton! {
        didSet {
            button.setTitle("SpeedLimiterButtonViewController.Button".localized, for: .normal)
        }
    }

    @IBAction func buttonWasTapped(_ sender: Any) {
        delegate?.didEnableSpeedLimiter()
    }
}
