import UIKit

class MessageViewController: UIViewController {
    private var messageType: Message

    private lazy var separatorView: UIView = {
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = .branding
        separatorView.layer.cornerRadius = 10.0
        separatorView.layer.masksToBounds = true

        view.addSubview(separatorView)
        NSLayoutConstraint.activate([
            separatorView.heightAnchor.constraint(equalToConstant: 20.0),
            separatorView.widthAnchor.constraint(equalToConstant: 170.0),
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -30.0),
            separatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40.0)
        ])

        return separatorView
    }()

    private lazy var paragraphViewController: ParagraphViewController! = {
        let paragraphViewController = ParagraphViewController(heading: messageType.heading, text: messageType.text)
        paragraphViewController.view.translatesAutoresizingMaskIntoConstraints = false

        return paragraphViewController
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

        addChild(paragraphViewController)
        view.addSubview(paragraphViewController.view)
        NSLayoutConstraint.activate([
            paragraphViewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40.0),
            paragraphViewController.view.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 40.0),
            paragraphViewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40.0),
        ])
        paragraphViewController.didMove(toParent: self)
    }
}
