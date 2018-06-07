import CoreLocation
import UIKit

class MessageViewController: UIViewController {
    private var locationManager: CLLocationManager

    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var button: UIButton!

    private let heading: String
    private let message: String
    private let buttonTitle: String?

    init(locationManager: CLLocationManager, heading: String, message: String, buttonTitle: String?) {
        self.locationManager = locationManager
        self.heading = heading
        self.message = message
        self.buttonTitle = buttonTitle

        super.init(nibName: nil, bundle: nil)
    }

    convenience init(locationManager: CLLocationManager, heading: String, message: String) {
        self.init(locationManager: locationManager, heading: heading, message: message, buttonTitle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }

    override func viewDidLoad() {
        headingLabel?.text = heading
        messageLabel?.text = message

        if nil == buttonTitle {
            button.isHidden = true
        } else {
            button.setTitle(buttonTitle, for: .normal)
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 5
        }

        headingLabel.textColor = view.tintColor

        super.viewDidLoad()
    }

    @IBAction func authorizeApp(_ sender: UIButton) {
        self.locationManager.requestWhenInUseAuthorization()
    }
}
