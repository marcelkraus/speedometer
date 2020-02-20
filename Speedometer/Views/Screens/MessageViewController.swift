import UIKit

class MessageViewController: UIViewController {
    var messageType: Message

    private var paragraphViewController: ParagraphViewController!

    private lazy var separatorView: SeparatorView = {
        let separatorView = SeparatorView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false

        return separatorView
    }()

    init(messageType: Message) {
        self.messageType = messageType

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(separatorView)
        NSLayoutConstraint.activate([
            separatorView.heightAnchor.constraint(equalToConstant: 20.0),
            separatorView.widthAnchor.constraint(equalToConstant: 170.0),
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -30.0),
            separatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40.0)
        ])

        setupParagraphView()
    }
}

// MARK: - UI Setup

private extension MessageViewController {
    func setupParagraphView() {
        paragraphViewController = ParagraphViewController(heading: messageType.heading, text: messageType.text)
        addChild(paragraphViewController)

        let paragraphView = paragraphViewController.view!
        view.addSubview(paragraphView)

        paragraphView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            paragraphView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40.0),
            paragraphView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 40.0),
            paragraphView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40.0),
            ])
        paragraphViewController.didMove(toParent: self)
    }
}
