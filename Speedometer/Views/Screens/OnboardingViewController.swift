import UIKit

protocol OnboardingViewControllerDelegate: class {
    func didTapAuthorizeButton()
}

class OnboardingViewController: UIViewController {
    weak var delegate: OnboardingViewControllerDelegate?

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

    private lazy var paragraphViewController: ParagraphViewController = {
        let paragraphViewController = ParagraphViewController(heading: Message.onboarding.heading, text: Message.onboarding.text)
        paragraphViewController.view.translatesAutoresizingMaskIntoConstraints = false

        return paragraphViewController
    }()

    private lazy var authorizationButtonView: UIButton = {
        let authorizationButtonView = UIButton()
        authorizationButtonView.translatesAutoresizingMaskIntoConstraints = false
        authorizationButtonView.setTitle("OnboardingViewController.Button".localized, for: .normal)
        authorizationButtonView.setTitleColor(.branding, for: .normal)
        authorizationButtonView.addTarget(self, action: #selector(didTapAuthorizeButton), for: .touchUpInside)

        return authorizationButtonView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(paragraphViewController)
        view.addSubview(paragraphViewController.view)
        paragraphViewController.didMove(toParent: self)

        view.addSubview(authorizationButtonView)

        NSLayoutConstraint.activate([
            paragraphViewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40.0),
            paragraphViewController.view.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 40.0),
            paragraphViewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40.0),
            authorizationButtonView.topAnchor.constraint(equalTo: paragraphViewController.view.bottomAnchor, constant: 40.0),
            authorizationButtonView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
    }

    @objc private func didTapAuthorizeButton() {
        delegate?.didTapAuthorizeButton()
    }
}
