import UIKit

class ImprintViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        modalTransitionStyle = .coverVertical
        heading.textColor = view.tintColor
    }

    // MARK: - Outlets & Actions

    @IBOutlet weak var heading: UILabel! {
        didSet {
            heading.text = "SettingsViewController.Imprint.Heading".localized
        }
    }
    @IBOutlet weak var contents: UILabel! {
        didSet {
            contents.text = "SettingsViewController.Imprint.Contents".localized

            if let versionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String, let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String {
                contents.text?.append("\n\n\("SettingsViewController.Imprint.AppVersion".localized): \(versionNumber) (\(buildNumber))")
            }
        }
    }
    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.setTitle("SettingsViewController.Button.Close".localized, for: .normal)
            closeButton.layer.masksToBounds = true
            closeButton.layer.cornerRadius = 5
        }
    }

    @IBAction func dismiss(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
