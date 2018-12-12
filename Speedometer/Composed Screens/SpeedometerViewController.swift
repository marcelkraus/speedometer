import UIKit

class SpeedometerViewController: UIViewController {

    // MARK: - View Controller Lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)

        view.backgroundColor = .white
        setupUnitSelectionView()
        setupCircularView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SpeedometerViewController {

    // MARK: - Private Methods

    func setupCircularView() {
        let circularViewController = CircularViewController()
        addChild(circularViewController)

        let circularView = circularViewController.view!
        view.addSubview(circularView)

        circularView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            circularView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            circularView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            circularView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
            circularView.heightAnchor.constraint(equalTo: circularView.widthAnchor, multiplier: 1.0),
            ])
        circularViewController.didMove(toParent: self)
    }

    func setupUnitSelectionView() {
        let unitSelectionViewController = UnitSelectionViewController(hideStackView: false)
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
