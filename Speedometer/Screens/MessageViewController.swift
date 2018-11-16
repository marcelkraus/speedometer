import CoreLocation
import UIKit

class MessageViewController: UIViewController {

    // MARK: - Enums

    enum MessageType {
        case locationAuthorizationStatusDenied
        case locationAuthorizationStatusRestricted
    }

    // MARK: - Properties

    var messageType: MessageType {
        didSet {

        }
    }

    // MARK: - Outlets & Actions

    @IBOutlet weak var unitSelectionView: UIView!

    @IBOutlet weak var paragraphView: UIView!

    // MARK: - View Controller Lifecycle

    init(messageType: MessageType) {
        self.messageType = messageType

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupContainerViewControllers()
    }
}

// MARK: - Private Methods

private extension MessageViewController {
    func setupContainerViewControllers() {
        let unitSelectionViewController = UnitSelectionViewController()
        unitSelectionViewController.hideStackView = true
        addChild(unitSelectionViewController)
        unitSelectionView.addSubview(unitSelectionViewController.view)
        unitSelectionViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            unitSelectionView.leadingAnchor.constraint(equalTo: unitSelectionViewController.view.leadingAnchor),
            unitSelectionView.topAnchor.constraint(equalTo: unitSelectionViewController.view.topAnchor),
            unitSelectionView.bottomAnchor.constraint(equalTo: unitSelectionViewController.view.bottomAnchor),
            unitSelectionView.trailingAnchor.constraint(equalTo: unitSelectionViewController.view.trailingAnchor),
            ])
        unitSelectionViewController.didMove(toParent: self)

        var messageContent: (heading: String, text: String)
        switch messageType {
        case .locationAuthorizationStatusDenied:
            messageContent.heading = "MessageViewController.LocationAuthorizationStatusRestricted.Title".localized
            messageContent.text = "MessageViewController.LocationAuthorizationStatusRestricted.Contents".localized
        case .locationAuthorizationStatusRestricted:
            messageContent.heading = "MessageViewController.LocationAuthorizationStatusDenied.Title".localized
            messageContent.text = "MessageViewController.LocationAuthorizationStatusRestricted.Contents".localized
        }

        let paragraphViewController = ParagraphViewController(heading: messageContent.heading, text: messageContent.text)
        addChild(paragraphViewController)
        paragraphView.addSubview(paragraphViewController.view)
        paragraphViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            paragraphView.leadingAnchor.constraint(equalTo: paragraphViewController.view.leadingAnchor),
            paragraphView.topAnchor.constraint(equalTo: paragraphViewController.view.topAnchor),
            paragraphView.bottomAnchor.constraint(equalTo: paragraphViewController.view.bottomAnchor),
            paragraphView.trailingAnchor.constraint(equalTo: paragraphViewController.view.trailingAnchor),
            ])
        paragraphViewController.didMove(toParent: self)
    }
}
