import UIKit

protocol ButtonViewControllerDelegate {
    func didTapButton(type: ButtonType)
}

class ButtonViewController: UIViewController {
    var delegate: ButtonViewControllerDelegate?

    private(set) var type: ButtonType

    private lazy var button: UIButton = {
        var button: UIButton
        switch type {
        case .plain(let title):
            button = UIButton()
            button.setTitle(title, for: .normal)
            button.setTitleColor(.brand, for: .normal)
            button.titleLabel?.font = .preferredFont(forTextStyle: .title2)
        case .info:
            button = UIButton(type: .infoDark)
            button.tintColor = .brand
            button.titleLabel?.font = .preferredFont(forTextStyle: .title3)
        }
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)

        return button
    }()

    init(type: ButtonType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)

        setupButtonView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@objc private extension ButtonViewController {
    func didTapButton() {
        delegate?.didTapButton(type: type)
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
