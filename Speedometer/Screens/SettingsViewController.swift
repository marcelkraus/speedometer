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

        self.modalTransitionStyle = .flipHorizontal

        configureUnitSelection(unit: self.unit)
        configureSpeedLimitSelection()

        headings.forEach { headline in
            headline.textColor = view.tintColor
        }
    }

    // MARK: - Outlets & Actions

    @IBOutlet var headings: [UILabel]!
    @IBOutlet weak var unitSelectionHeading: UILabel! {
        didSet {
            unitSelectionHeading.text = "SettingsViewController.UnitSelection.Heading".localized
        }
    }
    @IBOutlet weak var speedLimitHeading: UILabel! {
        didSet {
            speedLimitHeading.text = "SettingsViewController.SpeedWarning.Heading".localized
        }
    }
    @IBOutlet weak var imprintHeading: UILabel! {
        didSet {
            if let productName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName"), let versionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String, let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String {
                imprintHeading.text = "\(productName) v\(versionNumber) (\(buildNumber))"
            }
        }
    }
    @IBOutlet weak var imprintContents: UILabel! {
        didSet {
            imprintContents.text = "SettingsViewController.Imprint.Contents".localized
        }
    }
    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.setTitle("SettingsViewController.Button.Close".localized, for: .normal)
        }
    }

    @IBOutlet weak var unitSelection: UISegmentedControl!
    @IBOutlet weak var speedWarningSlider: UISlider!
    @IBOutlet weak var speedWarningValue: UILabel!

    @IBAction func selectUnit(_ sender: UISegmentedControl) {
        changeUnit(unit: units[sender.selectedSegmentIndex])
    }

    @IBAction func selectSpeedLimit(_ sender: UISlider) {
        let roundedValue = round(sender.value / Float(unit.speedLimitSliderSteps)) * Float(unit.speedLimitSliderSteps)

        sender.setValue(roundedValue, animated: true)
        speedWarningValue.text = String(format: "%.0f", roundedValue)

        UserDefaults.standard.set(roundedValue, forKey: Speed.WarningDefaultsKey)
    }

    @IBAction func closeSettings(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Private Methods

private extension SettingsViewController {
    func configureUnitSelection(unit: Unit) {
        unitSelection.removeAllSegments()
        units.enumerated().forEach { (index, unit) in
            unitSelection.insertSegment(withTitle: unit.abbreviation, at: index, animated: false)
        }

        unitSelection.selectedSegmentIndex = units.index(where: { $0.abbreviation == unit.abbreviation }) ?? 0
    }

    func changeUnit(unit: Unit) {
        self.unit = unit
        UserDefaults.standard.set(unit.rawValue, forKey: Unit.UserDefaultsKey)
        UserDefaults.standard.removeObject(forKey: Speed.WarningDefaultsKey)

        configureSpeedLimitSelection()
    }

    func configureSpeedLimitSelection() {
        speedWarningSlider.maximumValue = unit.maximumSpeedLimit
        speedWarningSlider.value = UserDefaults.standard.float(forKey: Speed.WarningDefaultsKey)
        speedWarningValue.text = String(format: "%.0f", speedWarningSlider.value)
    }
}
