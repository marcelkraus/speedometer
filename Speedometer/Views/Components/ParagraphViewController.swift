import UIKit

class ParagraphViewController: UIViewController {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 40.0

        return stackView
    }()

    private lazy var headingLabel: UILabel = {
        let label = UILabel()
        label.font = .heading
        label.numberOfLines = 2

        return label
    }()

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = .text
        label.numberOfLines = 0

        return label
    }()

    init(heading: String, text: String) {
        super.init(nibName: nil, bundle: nil)

        self.headingLabel.text = heading
        self.textLabel.text = text

        setupStackView()
    }

    init(messageType: MessageType) {
        super.init(nibName: nil, bundle: nil)

        setupFromMessage(ofType: messageType)
        setupStackView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        headingLabel.textColor = view.tintColor
    }
}

private extension ParagraphViewController {
    func setupFromMessage(ofType messageType: MessageType) {
        switch messageType {
        case .locationAuthorizationStatusDenied:
            headingLabel.text = "Message.LocationAuthorizationStatusRestricted.Heading".localized
            textLabel.text = "Message.LocationAuthorizationStatusRestricted.Text".localized
        case .locationAuthorizationStatusRestricted:
            headingLabel.text = "Message.LocationAuthorizationStatusDenied.Heading".localized
            textLabel.text = "Message.LocationAuthorizationStatusRestricted.Text".localized
        case .onboarding:
            headingLabel.text = "Message.Onboarding.Heading".localized
            textLabel.text = "Message.Onboarding.Text".localized
        }
    }
}

private extension ParagraphViewController {
    func setupStackView() {
        stackView.addArrangedSubview(headingLabel)
        stackView.addArrangedSubview(textLabel)

        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
}
