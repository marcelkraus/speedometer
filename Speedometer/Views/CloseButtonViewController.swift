import UIKit

class CloseButtonViewController: UIViewController {
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("ⓧ", for: .normal)
        button.setTitleColor(UIColor(red: 0.012, green: 0.569, blue: 0.576, alpha: 1.00), for: .normal)
        button.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        button.titleLabel?.font = .preferredFont(forTextStyle: .callout)

        return button
    }()

    init() {
        super.init(nibName: nil, bundle: nil)

        setupCloseButtonView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func handleClose() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

private extension CloseButtonViewController {
    func setupCloseButtonView() {
        view.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            closeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
    }
}
