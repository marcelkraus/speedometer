import UIKit

class MessageViewController: UIViewController {
    var messageType: MessageType

    private var paragraphViewController: ParagraphViewController!
    private var separatorViewController: SeparatorViewController!

    init(messageType: MessageType) {
        self.messageType = messageType

        super.init(nibName: nil, bundle: nil)

        view.backgroundColor = .white
        setupSeparatorView()
        setupParagraphView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Setup

private extension MessageViewController {
    func setupParagraphView() {
        paragraphViewController = ParagraphViewController(messageType: messageType)
        addChild(paragraphViewController)

        let paragraphView = paragraphViewController.view!
        view.addSubview(paragraphView)

        paragraphView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            paragraphView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40.0),
            paragraphView.topAnchor.constraint(equalTo: separatorViewController.view.bottomAnchor, constant: 40.0),
            paragraphView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40.0),
            ])
        paragraphViewController.didMove(toParent: self)
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
