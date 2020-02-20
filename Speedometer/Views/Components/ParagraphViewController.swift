import UIKit

class ParagraphViewController: UIViewController {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headingLabel, textLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20.0

        return stackView
    }()

    private lazy var headingLabel: UILabel = {
        let headingLabel = UILabel()
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        headingLabel.font = .heading
        headingLabel.textColor = .branding
        headingLabel.numberOfLines = 2

        return headingLabel
    }()

    private lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = .text
        textLabel.textColor = .text
        textLabel.numberOfLines = 0

        return textLabel
    }()

    init(heading: String, text: String) {
        super.init(nibName: nil, bundle: nil)

        self.headingLabel.text = heading
        self.textLabel.text = text
    }

    init(messageType: MessageType) {
        super.init(nibName: nil, bundle: nil)

        setupFromMessage(ofType: messageType)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

private extension ParagraphViewController {
    func setupFromMessage(ofType messageType: MessageType) {
        switch messageType {
        case .locationAuthorizationStatusDenied:
            headingLabel.text = "ParagraphViewController.LocationAuthorizationStatusRestricted.Heading".localized
            textLabel.text = "ParagraphViewController.LocationAuthorizationStatusRestricted.Text".localized
        case .locationAuthorizationStatusRestricted:
            headingLabel.text = "ParagraphViewController.LocationAuthorizationStatusDenied.Heading".localized
            textLabel.text = "ParagraphViewController.LocationAuthorizationStatusRestricted.Text".localized
        case .onboarding:
            headingLabel.text = "ParagraphViewController.Onboarding.Heading".localized
            textLabel.text = "ParagraphViewController.Onboarding.Text".localized
        }
    }
}
