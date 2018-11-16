import CoreLocation
import UIKit

class WelcomeViewController: UIViewController {

    // MARK: - Properties

    private let locationManager = CLLocationManager()

    // MARK: - Outlets & Actions

    @IBOutlet weak var unitSelectionView: UIView!

    @IBOutlet weak var paragraphView: UIView!

    @IBOutlet private weak var authorizationButton: UIButton! {
        didSet {
            authorizationButton.setTitle("WelcomeViewController.Button".localized, for: .normal)
            authorizationButton.layer.masksToBounds = true
            authorizationButton.layer.cornerRadius = 10
        }
    }

    @IBAction func authorizeApp(_ sender: UIButton) {
        locationManager.requestWhenInUseAuthorization()
    }

    // MARK: - View Controller Lifecycle

    init() {
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

// MARK: - Private Methods

private extension WelcomeViewController {
    func setupContainerViewControllers() {
        let unitSelectionViewController = UnitSelectionViewController()
        unitSelectionViewController.hideStackView = true
        addChild(unitSelectionViewController)
        unitSelectionView.addSubview(unitSelectionViewController.view)
        unitSelectionViewController.didMove(toParent: self)

        let paragraphViewController = ParagraphViewController(
            heading: "WelcomeViewController.Heading".localized,
            text: "WelcomeViewController.Text".localized
        )
        addChild(paragraphViewController)
        paragraphView.addSubview(paragraphViewController.view)
        paragraphViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            paragraphView.topAnchor.constraint(equalTo: paragraphViewController.view.topAnchor),
            paragraphView.bottomAnchor.constraint(equalTo: paragraphViewController.view.bottomAnchor),
            paragraphView.trailingAnchor.constraint(equalTo: paragraphViewController.view.trailingAnchor),
            paragraphView.leadingAnchor.constraint(equalTo: paragraphViewController.view.leadingAnchor),
            ])
        paragraphViewController.didMove(toParent: self)
    }
}
