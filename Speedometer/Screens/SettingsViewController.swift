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

        setupUnitSelection(unit: self.unit)

        headlines.forEach { headline in
            headline.textColor = view.tintColor
        }
    }

    // MARK: - Outlets & Actions

    @IBOutlet var headlines: [UILabel]!

    @IBOutlet weak var appInformation: UILabel! {
        didSet {
            if let productName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName"), let versionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String, let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String {
                appInformation.text = "\(productName) v\(versionNumber) (\(buildNumber))"
            }
        }
    }
    @IBOutlet weak var unitSelection: UISegmentedControl!

    @IBAction func selectUnit(_ sender: UISegmentedControl) {
        let unit = units[sender.selectedSegmentIndex]

        UserDefaults.standard.set(unit.rawValue, forKey: Unit.UserDefaultsKey)
    }

    @IBAction func closeSettings(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Private Methods

private extension SettingsViewController {
    func setupUnitSelection(unit: Unit) {
        unitSelection.removeAllSegments()
        units.enumerated().forEach { (index, unit) in
            unitSelection.insertSegment(withTitle: unit.abbreviation, at: index, animated: false)
        }

        unitSelection.selectedSegmentIndex = units.index(where: { $0.abbreviation == unit.abbreviation }) ?? 0
    }
}
