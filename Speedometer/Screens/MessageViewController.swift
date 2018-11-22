import CoreLocation
import UIKit

class MessageViewController: UIViewController {

    // MARK: - Properties

    private var informationType: InformationType

    // MARK: - Outlets & Actions

    @IBOutlet weak var unitSelectionView: UIView!

    @IBOutlet weak var paragraphView: UIView!

    // MARK: - View Controller Lifecycle

    init(informationType: InformationType) {
        self.informationType = informationType

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupContainerViewControllers()
    }
}

private extension MessageViewController {

    // MARK: - Private Methods

    func setupContainerViewControllers() {
        let unitSelectionViewController = UnitSelectionViewController()
        unitSelectionViewController.hideStackView = true
        addChild(unitSelectionViewController)
        unitSelectionView.addSubview(unitSelectionViewController.view)
        unitSelectionViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            unitSelectionView.leadingAnchor.constraint(equalTo: unitSelectionViewController.view.leadingAnchor),
            unitSelectionView.topAnchor.constraint(equalTo: unitSelectionViewController.view.topAnchor),
            unitSelectionView.bottomAnchor.constraint(equalTo: unitSelectionViewController.view.bottomAnchor),
            unitSelectionView.trailingAnchor.constraint(equalTo: unitSelectionViewController.view.trailingAnchor),
            ])
        unitSelectionViewController.didMove(toParent: self)

        let paragraphViewController = InformationViewController(informationType: informationType)
        addChild(paragraphViewController)
        paragraphView.addSubview(paragraphViewController.view)
        paragraphViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            paragraphView.leadingAnchor.constraint(equalTo: paragraphViewController.view.leadingAnchor),
            paragraphView.topAnchor.constraint(equalTo: paragraphViewController.view.topAnchor),
            paragraphView.bottomAnchor.constraint(equalTo: paragraphViewController.view.bottomAnchor),
            paragraphView.trailingAnchor.constraint(equalTo: paragraphViewController.view.trailingAnchor),
            ])
        paragraphViewController.didMove(toParent: self)
    }
}
