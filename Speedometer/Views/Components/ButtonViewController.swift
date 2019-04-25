import UIKit

class ButtonViewController: UIViewController {
    private var type: ButtonType

    private var completionHandler: () -> Void

    private lazy var button: UIButton = {
        var button: UIButton
        switch type {
        case .plain(let title):
            button = UIButton()
            button.setTitle(title, for: .normal)
            button.setTitleColor(.branding, for: .normal)
        case .info:
            button = UIButton(type: .infoDark)
            button.tintColor = .branding
        }
        button.titleLabel?.font = .button
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)

        return button
    }()

    init(type: ButtonType, completionHandler: @escaping () -> Void) {
        self.type = type
        self.completionHandler = completionHandler

        super.init(nibName: nil, bundle: nil)

        setupButtonView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@objc private extension ButtonViewController {
    func didTapButton() {
        completionHandler()
    }
}

private extension ButtonViewController {
    func setupButtonView() {
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
    }
}
