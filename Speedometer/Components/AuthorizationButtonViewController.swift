import CoreLocation
import UIKit

class AuthorizationButtonViewController: UIViewController {

    // MARK: - Outlets & Actions

    @IBOutlet weak var button: UIButton! {
        didSet {
            button.setTitle("AuthorizationButtonViewController.Label".localized, for: .normal)
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 10
        }
    }

    @IBAction func didTapButton(_ sender: Any) {
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
    }

    // MARK: - View Controller Lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
