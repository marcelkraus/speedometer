import UIKit

class MessageViewController: UIViewController {
    var informationType: InformationType

    private var informationViewController: InformationViewController!
    private var separatorViewController: SeparatorViewController!

    init(informationType: InformationType) {
        self.informationType = informationType

        super.init(nibName: nil, bundle: nil)

        view.backgroundColor = .white
        setupSeparatorView()
        setupInformationView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Setup

private extension MessageViewController {
    func setupInformationView() {
        informationViewController = InformationViewController(informationType: informationType)
        addChild(informationViewController)

        let informationView = informationViewController.view!
        view.addSubview(informationView)

        informationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            informationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40.0),
            informationView.topAnchor.constraint(equalTo: separatorViewController.view.bottomAnchor, constant: 40.0),
            informationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40.0),
            ])
        informationViewController.didMove(toParent: self)
    }

    func setupSeparatorView() {
        separatorViewController = SeparatorViewController()
        addChild(separatorViewController)

        let separatorView = separatorViewController.view!
        view.addSubview(separatorView)

        separatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separatorView.heightAnchor.constraint(equalToConstant: 20.0),
            separatorView.widthAnchor.constraint(equalToConstant: 170.0),
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -30.0),
            separatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40.0)
            ])
        separatorViewController.didMove(toParent: self)
    }
}
