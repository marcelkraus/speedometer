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

    var hideStackView = false

    var delegate: UnitSelectionViewControllerDelegate?

    // MARK: - Outlets & Actions

    @IBOutlet private weak var stackView: UIStackView! {
        didSet {
            stackView.isHidden = hideStackView
        }
    }

    @IBOutlet private weak var segmentedControl: UISegmentedControl! {
        didSet {
            segmentedControl.removeAllSegments()
            units.enumerated().forEach { (index, unit) in
                segmentedControl.insertSegment(withTitle: unit.abbreviation, at: index, animated: false)
            }
        }
    }

    @IBOutlet private weak var informationButton: UIButton!

    @IBAction func didChangeValue(_ sender: UISegmentedControl) {
        updateUnit(units[sender.selectedSegmentIndex])
    }

    @IBAction func didTapButton(_ button: UIButton) {
        let storyboard = UIStoryboard(name: "Speedometer", bundle: Bundle.main)
        let imprintViewController = storyboard.instantiateViewController(withIdentifier: "ImprintViewControllerIdentifier")

        present(imprintViewController, animated: true, completion: nil)
    }

    // MARK: - View Controller Lifecycle

    init() {
        unit = Unit(rawValue: UserDefaults.standard.string(forKey: Configuration.currentUnitDefaultsKey)!)!

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUnit(unit)
    }
}

// MARK: - Private Methods

private extension UnitSelectionViewController {
    func updateUnit(_ unit: Unit) {
        UserDefaults.standard.set(unit.rawValue, forKey: Configuration.currentUnitDefaultsKey)
        segmentedControl.selectedSegmentIndex = units.index(where: { $0.abbreviation == unit.abbreviation }) ?? 0

        delegate?.didSetUnit(unit)
    }
}
