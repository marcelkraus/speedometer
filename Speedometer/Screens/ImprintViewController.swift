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

        view.backgroundColor = UIColor.clear.withAlphaComponent(0.7)
        heading.textColor = view.tintColor
    }

    // MARK: - Outlets & Actions

    @IBOutlet weak var backgroundView: UIView! {
        didSet {
            backgroundView.layer.masksToBounds = true
            backgroundView.layer.cornerRadius = 20
        }
    }
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

    @IBAction func dismiss(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
