import CoreLocation
import UIKit

class WelcomeViewController: UIViewController {
    private lazy var locationManager = CLLocationManager()

    @IBOutlet private weak var welcomeMessageTitle: UILabel! {
        didSet {
            welcomeMessageTitle.text = "WelcomeViewController.WelcomeMessageTitle".localized
        }
    }

    @IBOutlet private weak var welcomeMessageContents: UILabel! {
        didSet {
            welcomeMessageContents.text = "WelcomeViewController.WelcomeMessageContents".localized
        }
    }

    @IBOutlet private weak var authorizeLocationDataButton: UIButton! {
        didSet {
            authorizeLocationDataButton.setTitle("WelcomeViewController.ButtonTitle".localized, for: .normal)
        }
    }

    @IBAction func authorizeApp(_ sender: UIButton) {
        locationManager.requestWhenInUseAuthorization()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        messageTitle.textColor = view.tintColor
    }
}
