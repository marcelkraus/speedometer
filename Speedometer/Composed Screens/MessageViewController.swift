import CoreLocation
import UIKit

class MessageViewController: UIViewController {

    // MARK: - Properties

    private var informationType: InformationType

    // MARK: - View Controller Lifecycle

    init(informationType: InformationType) {
        self.informationType = informationType

        super.init(nibName: nil, bundle: nil)

        view.backgroundColor = .white
        setupUnitSelectionView()
        setupInformationView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MessageViewController {

    // MARK: - Private Methods

    func setupInformationView() {
        let informationViewController = InformationViewController(informationType: informationType)
        addChild(informationViewController)

        let informationView = informationViewController.view!
        view.addSubview(informationView)

        informationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            informationView.leadingAnchor.constraint(equalTo: informationView.leadingAnchor),
            informationView.topAnchor.constraint(equalTo: informationView.topAnchor),
            informationView.bottomAnchor.constraint(equalTo: informationView.bottomAnchor),
            informationView.trailingAnchor.constraint(equalTo: informationView.trailingAnchor),
            informationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            informationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            informationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            ])
        informationViewController.didMove(toParent: self)
    }

    func setupUnitSelectionView() {
        let unitSelectionViewController = UnitSelectionViewController(hideStackView: true)
        addChild(unitSelectionViewController)

        let unitSelectionView = unitSelectionViewController.view!
        view.addSubview(unitSelectionView)

        unitSelectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            unitSelectionView.leadingAnchor.constraint(equalTo: unitSelectionView.leadingAnchor),
            unitSelectionView.topAnchor.constraint(equalTo: unitSelectionView.topAnchor),
            unitSelectionView.bottomAnchor.constraint(equalTo: unitSelectionView.bottomAnchor),
            unitSelectionView.trailingAnchor.constraint(equalTo: unitSelectionView.trailingAnchor),
            unitSelectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            unitSelectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            unitSelectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        unitSelectionViewController.didMove(toParent: self)
    }
}
