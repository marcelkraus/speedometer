import UIKit

class ImprintViewController: UIViewController {
    @IBOutlet weak var backgroundView: UIView! {
        didSet {
            backgroundView.layer.masksToBounds = true
            backgroundView.layer.cornerRadius = 25
        }
    }

    @IBOutlet weak var imprintHeading: UILabel! {
        didSet {
            imprintHeading.text = "SettingsViewController.Imprint.Heading".localized
        }
    }

    @IBOutlet weak var imprintContents: UILabel! {
        didSet {
            imprintContents.text = "SettingsViewController.Imprint.Contents".localized
        }
    }

    @IBOutlet weak var versionHeading: UILabel! {
        didSet {
            versionHeading.text = "SettingsViewController.Version.Heading".localized
        }
    }

    @IBOutlet weak var versionContents: UILabel! {
        didSet {
            versionContents.text = "–"

            if let versionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String, let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String {
                versionContents.text = "\("SettingsViewController.Version.Version".localized) \(versionNumber) (\("SettingsViewController.Version.Build".localized) \(buildNumber))"
            }
        }
    }

    @IBAction func dismiss(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        imprintHeading.textColor = view.tintColor
        versionHeading.textColor = view.tintColor
        view.backgroundColor = UIColor.clear.withAlphaComponent(0.75)
    }
}
