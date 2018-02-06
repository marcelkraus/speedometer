import UIKit

class ImprintViewController: UIViewController {
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
    }

    // MARK: - Outlets & Actions

    @IBOutlet weak var unitSelection: UISegmentedControl!

    @IBAction func selectUnit(_ sender: UISegmentedControl) {
        let unit = units[sender.selectedSegmentIndex]

        UserDefaults.standard.set(unit.rawValue, forKey: Unit.UserDefaultsKey)
    }

    @IBAction func closeImprint(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Private Methods

private extension ImprintViewController {
    func setupUnitSelection(unit: Unit) {
        unitSelection.removeAllSegments()
        units.enumerated().forEach { (index, unit) in
            unitSelection.insertSegment(withTitle: unit.abbreviation, at: index, animated: false)
        }

        unitSelection.selectedSegmentIndex = units.index(where: { $0.abbreviation == unit.abbreviation }) ?? 0
    }
}
