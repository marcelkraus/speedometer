import UIKit

class ImprintButtonViewController: UIViewController {
    private lazy var imprintButton: UIButton = {
        let button = UIButton(type: .infoDark)
        button.addTarget(self, action: #selector(handleImprint), for: .touchUpInside)
        button.tintColor = UIColor(red: 0.012, green: 0.569, blue: 0.576, alpha: 1.00)

        return button
    }()

    init() {
        super.init(nibName: nil, bundle: nil)

        setupImprintButtonView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func handleImprint() {
        let imprintViewController = ImprintViewController()
        imprintViewController.modalPresentationStyle = .overCurrentContext
        imprintViewController.modalTransitionStyle = .crossDissolve

        present(imprintViewController, animated: true, completion: nil)
    }
}

private extension ImprintButtonViewController {
    func setupImprintButtonView() {
        view.addSubview(imprintButton)

        imprintButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imprintButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imprintButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imprintButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imprintButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
    }
}
