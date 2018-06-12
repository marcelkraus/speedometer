import UIKit

class SettingsViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.modalTransitionStyle = .coverVertical
        headings.forEach { headline in
            headline.textColor = view.tintColor
        }
    }

    // MARK: - Outlets & Actions

    @IBOutlet var headings: [UILabel]!
    @IBOutlet weak var imprintHeading: UILabel! {
        didSet {
            imprintHeading.text = "SettingsViewController.Imprint.Heading".localized
        }
    }
    @IBOutlet weak var imprintContents: UILabel! {
        didSet {
            imprintContents.text = "SettingsViewController.Imprint.Contents".localized

            if let versionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String, let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String {
                imprintContents.text?.append("\n\n\("SettingsViewController.Imprint.AppVersion".localized): \(versionNumber) (\(buildNumber))")
            }
        }
    }
    @IBOutlet weak var button: UIButton! {
        didSet {
            button.setTitle("SettingsViewController.Button.Close".localized, for: .normal)
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 5
        }
    }

    @IBAction func dismissSettings(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
