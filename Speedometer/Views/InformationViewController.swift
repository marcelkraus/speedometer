import UIKit

class InformationViewController: UIViewController {

    // MARK: - Properties

    private var informationType: InformationType

    // MARK: - Outlets & Actions

    @IBOutlet weak var headingLabel: UILabel!

    @IBOutlet weak var textLabel: UILabel!

    // MARK: - View Controller Lifecycle

    init(informationType: InformationType) {
        self.informationType = informationType

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        headingLabel.textColor = view.tintColor

        switch informationType {
        case .locationAuthorizationStatusDenied:
            headingLabel.text = "Information.LocationAuthorizationStatusRestricted.Heading".localized
            textLabel.text = "Information.LocationAuthorizationStatusRestricted.Text".localized
        case .locationAuthorizationStatusRestricted:
            headingLabel.text = "Information.LocationAuthorizationStatusDenied.Heading".localized
            textLabel.text = "Information.LocationAuthorizationStatusRestricted.Text".localized
        case .onboardingInformation:
            headingLabel.text = "Information.OnboardingInformation.Heading".localized
            textLabel.text = "Information.OnboardingInformation.Text".localized
        }
    }
}
