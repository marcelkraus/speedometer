import CoreLocation
import UIKit

class AuthorizationViewController: UIViewController {

    private var locationManager: CLLocationManager

    init(locationManager: CLLocationManager) {
        self.locationManager = locationManager

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }

    @IBAction func authorizeApp(_ sender: UIButton) {
        self.locationManager.requestWhenInUseAuthorization()
    }

}
