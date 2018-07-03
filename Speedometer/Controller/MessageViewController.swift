import CoreLocation
import UIKit

class MessageViewController: UIViewController {
    @IBOutlet private weak var headingLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var button: UIButton!

    var locationManager: CLLocationManager?
    var heading: String?
    var message: String?
    var buttonTitle: String?

    override func viewDidLoad() {
        headingLabel?.text = heading
        messageLabel?.text = message

        if nil == buttonTitle {
            button.isHidden = true
        } else {
            button.setTitle(buttonTitle, for: .normal)
            button.layer.masksToBounds = true
            button.layer.cornerRadius = CGFloat(Configuration.buttonBorderRadius)
        }

        headingLabel.textColor = view.tintColor

        super.viewDidLoad()
    }

    @IBAction func authorizeApp(_ sender: UIButton) {
        self.locationManager?.requestWhenInUseAuthorization()
    }
}
