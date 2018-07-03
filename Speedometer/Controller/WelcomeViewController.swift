import CoreLocation
import UIKit

class WelcomeViewController: UIViewController {
    private let locationManager = CLLocationManager()

    @IBOutlet private weak var messageTitle: UILabel! {
        didSet {
            messageTitle.text = "WelcomeViewController.Title".localized
        }
    }

    @IBOutlet private weak var messageContents: UILabel! {
        didSet {
            messageContents.text = "WelcomeViewController.Contents".localized
        }
    }

    @IBOutlet private weak var authorizationButton: UIButton! {
        didSet {
            authorizationButton.setTitle("WelcomeViewController.Button".localized, for: .normal)
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
