import CoreLocation
import UIKit

class MessageViewController: UIViewController {
    enum MessageType {
        case locationAuthorizationStatusDenied
        case locationAuthorizationStatusRestricted
        case unknownError
    }

    @IBOutlet private weak var messageTitle: UILabel!
    @IBOutlet private weak var messageContents: UILabel!

    var messageType: MessageType = .unknownError

    override func viewDidLoad() {
        super.viewDidLoad()

        messageTitle.textColor = view.tintColor

        switch messageType {
        case .locationAuthorizationStatusDenied:
            messageTitle.text = "MessageViewController.LocationAuthorizationStatusRestricted.Title".localized
            messageContents.text = "MessageViewController.LocationAuthorizationStatusRestricted.Contents".localized
        case .locationAuthorizationStatusRestricted:
            messageTitle.text = "MessageViewController.LocationAuthorizationStatusDenied.Title".localized
            messageContents.text = "MessageViewController.LocationAuthorizationStatusRestricted.Contents".localized
        default:
            messageTitle.text = "MessageViewController.UnknownError.Title".localized
            messageContents.text = "MessageViewController.UnknownError.Contents".localized
        }
    }
}
