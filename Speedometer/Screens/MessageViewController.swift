import UIKit

class MessageViewController: UIViewController {
    private var informationType: InformationType

    init(informationType: InformationType) {
        self.informationType = informationType

        super.init(nibName: nil, bundle: nil)

        view.backgroundColor = .white
        setupInformationView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MessageViewController {
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
}
