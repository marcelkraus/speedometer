import UIKit

class InformationViewController: UIViewController {

    // MARK: - Properties

    private var heading: String?
    private var text: String?

    // MARK: - Outlets & Actions

    @IBOutlet weak var headingLabel: UILabel!

    @IBOutlet weak var textLabel: UILabel!

    // MARK: - View Controller Lifecycle

    init(heading: String, text: String) {
        self.heading = heading
        self.text = text

        super.init(nibName: nil, bundle: nil)
    }

    init(informationType: InformationType) {
        super.init(nibName: nil, bundle: nil)

        setupWithTextBlock(ofType: informationType)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        headingLabel.textColor = view.tintColor

        headingLabel.text = heading
        textLabel.text = text
    }
}

private extension InformationViewController {

    // MARK: - Private Methods

    func setupWithTextBlock(ofType informationType: InformationType) {
        switch informationType {
        case .locationAuthorizationStatusDenied:
            heading = "Information.LocationAuthorizationStatusRestricted.Heading".localized
            text = "Information.LocationAuthorizationStatusRestricted.Text".localized
        case .locationAuthorizationStatusRestricted:
            heading = "Information.LocationAuthorizationStatusDenied.Heading".localized
            text = "Information.LocationAuthorizationStatusRestricted.Text".localized
        case .onboardingInformation:
            heading = "Information.OnboardingInformation.Heading".localized
            text = "Information.OnboardingInformation.Text".localized
        }
    }
}
