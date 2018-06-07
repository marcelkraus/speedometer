import UIKit

class SettingsViewController: UIViewController {
    private var unit: Unit

    // MARK: - Controller Lifecycle

    init(unit: Unit) {
        self.unit = unit

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.modalTransitionStyle = .coverVertical

        configureSpeedLimitSelection()

        headings.forEach { headline in
            headline.textColor = view.tintColor
        }
    }

    // MARK: - Outlets & Actions

    @IBOutlet var headings: [UILabel]!
    @IBOutlet weak var speedLimitHeading: UILabel! {
        didSet {
            speedLimitHeading.text = "SettingsViewController.SpeedWarning.Heading".localized
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

    @IBOutlet weak var unitSelection: UISegmentedControl!
    @IBOutlet weak var speedWarningSlider: UISlider!
    @IBOutlet weak var speedWarningValue: UILabel!

    @IBAction func selectSpeedLimit(_ sender: UISlider) {
        let roundedValue = round(sender.value / Float(unit.speedLimitSliderSteps)) * Float(unit.speedLimitSliderSteps)

        sender.setValue(roundedValue, animated: true)
        speedWarningValue.text = String(format: Configuration.speedStringFormat, roundedValue)

        UserDefaults.standard.set(roundedValue, forKey: Configuration.currentSpeedLimitDefaultsKey)
    }

    @IBAction func dismissSettings(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Private Methods

private extension SettingsViewController {
    func configureSpeedLimitSelection() {
        speedWarningSlider.maximumValue = unit.maximumSpeedLimit
        speedWarningSlider.value = UserDefaults.standard.float(forKey: Configuration.currentSpeedLimitDefaultsKey)
        speedWarningValue.text = String(format: Configuration.speedStringFormat, speedWarningSlider.value)
    }
}
