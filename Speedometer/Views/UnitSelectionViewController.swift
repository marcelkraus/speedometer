import UIKit

protocol UnitSelectionViewControllerDelegate {
    func didSetUnit(_ unit: Unit)
}

class UnitSelectionViewController: UIViewController {

    // MARK: - Properties

    private var unit: Unit {
        didSet {
            updateUnit(unit)
        }
    }

    private var hideStackView: Bool

    var delegate: UnitSelectionViewControllerDelegate?

    // MARK: - Outlets & Actions

    @IBOutlet weak var stackView: UIStackView!

    @IBOutlet weak var segmentedControl: UISegmentedControl! {
        didSet {
            segmentedControl.removeAllSegments()
            units.enumerated().forEach { (index, unit) in
                segmentedControl.insertSegment(withTitle: unit.abbreviation, at: index, animated: false)
            }
        }
    }

    @IBOutlet weak var informationButton: UIButton!

    @IBAction func didChangeValue(_ sender: UISegmentedControl) {
        updateUnit(units[sender.selectedSegmentIndex])
    }

    // MARK: - View Controller Lifecycle

    init(hideStackView: Bool) {
        self.hideStackView = hideStackView
        unit = Unit(rawValue: UserDefaults.standard.string(forKey: AppConfiguration.currentUnitDefaultsKey)!)!

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        stackView.isHidden = hideStackView
        updateUnit(unit)
    }
}

private extension UnitSelectionViewController {

    // MARK: - Private Methods

    func updateUnit(_ unit: Unit) {
        UserDefaults.standard.set(unit.rawValue, forKey: AppConfiguration.currentUnitDefaultsKey)
        segmentedControl.selectedSegmentIndex = units.index(where: { $0.abbreviation == unit.abbreviation }) ?? 0

        delegate?.didSetUnit(unit)
    }
}
