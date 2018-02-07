import CoreLocation
import UIKit

class AuthorizationViewController: UIViewController {
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var button: UIButton!

    private let heading: String
    private let message: String

    private var locationManager: CLLocationManager

    init(locationManager: CLLocationManager, heading: String, message: String) {
        self.locationManager = locationManager
        self.heading = heading
        self.message = message

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }

    override func viewDidLoad() {
        headingLabel?.text = heading
        messageLabel?.text = message

        headingLabel.textColor = view.tintColor
        messageLabel.numberOfLines = 0

        super.viewDidLoad()
    }

    @IBAction func authorizeApp(_ sender: UIButton) {
        self.locationManager.requestWhenInUseAuthorization()
    }
}
