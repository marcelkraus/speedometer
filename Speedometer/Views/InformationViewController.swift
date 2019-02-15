import UIKit

class InformationViewController: UIViewController {
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
        label.font = .preferredFont(forTextStyle: .title1)
        label.numberOfLines = 2
        label.textColor = UIColor(red: 0.012, green: 0.569, blue: 0.576, alpha: 1.00)

        return label
    }()

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0

        return label
    }()

    init(heading: String, text: String) {
        super.init(nibName: nil, bundle: nil)

        self.headingLabel.text = heading
        self.textLabel.text = text

        setupStackView()
    }

    init(informationType: InformationType) {
        super.init(nibName: nil, bundle: nil)

        setupWithInformationTemplate(ofType: informationType)
        setupStackView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension InformationViewController {
    func setupWithInformationTemplate(ofType informationType: InformationType) {
        switch informationType {
        case .locationAuthorizationStatusDenied:
            headingLabel.text = "Information.LocationAuthorizationStatusRestricted.Heading".localized
            textLabel.text = "Information.LocationAuthorizationStatusRestricted.Text".localized
        case .locationAuthorizationStatusRestricted:
            headingLabel.text = "Information.LocationAuthorizationStatusDenied.Heading".localized
            textLabel.text = "Information.LocationAuthorizationStatusRestricted.Text".localized
        case .onboardingInformation:
            headingLabel.text = "Information.OnboardingInformation.Heading".localized
            textLabel.text = "Information.OnboardingInformation.Text".localized
        }
    }
}

private extension InformationViewController {
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
