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
        setupParagraphView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MessageViewController {

    // MARK: - Private Methods

    func setupParagraphView() {
        let paragraphViewController = InformationViewController(informationType: informationType)
        addChild(paragraphViewController)

        let paragraphView = paragraphViewController.view!
        view.addSubview(paragraphView)

        paragraphView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            paragraphView.leadingAnchor.constraint(equalTo: paragraphView.leadingAnchor),
            paragraphView.topAnchor.constraint(equalTo: paragraphView.topAnchor),
            paragraphView.bottomAnchor.constraint(equalTo: paragraphView.bottomAnchor),
            paragraphView.trailingAnchor.constraint(equalTo: paragraphView.trailingAnchor),
            paragraphView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            paragraphView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            paragraphView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            ])
        paragraphViewController.didMove(toParent: self)
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
