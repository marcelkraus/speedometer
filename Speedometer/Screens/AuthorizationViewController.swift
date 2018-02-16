import CoreLocation
import UIKit

class AuthorizationViewController: UIViewController {
    @IBOutlet weak var headingLabel: UILabel!

    private var locationManager: CLLocationManager

    init(locationManager: CLLocationManager) {
        self.locationManager = locationManager

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }

    override func viewDidLoad() {
        headingLabel.textColor = view.tintColor

        super.viewDidLoad()
    }

    @IBAction func authorizeApp(_ sender: UIButton) {
        self.locationManager.requestWhenInUseAuthorization()
    }
}
