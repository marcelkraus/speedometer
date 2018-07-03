import CoreLocation
import UIKit

class MessageViewController: UIViewController {
    @IBOutlet private weak var headingLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!

    var heading: String?
    var message: String?

    override func viewDidLoad() {
        headingLabel?.text = heading
        headingLabel.textColor = view.tintColor
        messageLabel?.text = message

        super.viewDidLoad()
    }
}
