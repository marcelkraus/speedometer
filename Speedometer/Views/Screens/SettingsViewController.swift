import StoreKit
import UIKit

class SettingsViewController: UIViewController {
    private var productRequest: SKProductsRequest!

    private lazy var separatorView: UIView = {
        let separatorViewController = SeparatorViewController()
        addChild(separatorViewController)

        return separatorViewController.view!
    }()

    private lazy var contentStackView: UIStackView = {
        let contentView = UIStackView()
        contentView.axis = .vertical
        contentView.spacing = 40.0
        contentView.alignment = .center
        contentView.addArrangedSubview(tipJarStackView)
        contentView.addArrangedSubview(imprintView)
        contentView.addArrangedSubview(swipeInfoLabel)

        return contentView
    }()

    private lazy var tipJarIntroductionView: UIView = {
        let tipJarIntroductionViewController = ParagraphViewController(heading: "SettingsViewController.TipJar.Heading".localized, text: "SettingsViewController.TipJar.Text".localized)
        addChild(tipJarIntroductionViewController)

        return tipJarIntroductionViewController.view!
    }()

    private lazy var tipJarButtonStackView: UIStackView = {
        let buttonSmall = UIButton()
        buttonSmall.layer.cornerRadius = 8.0
        buttonSmall.backgroundColor = .lightGray
        buttonSmall.titleLabel?.numberOfLines = 0
        buttonSmall.titleLabel?.textAlignment = .center
        buttonSmall.setTitle("😀", for: .normal)

        let buttonMedium = UIButton()
        buttonMedium.layer.cornerRadius = 8.0
        buttonMedium.backgroundColor = .lightGray
        buttonMedium.titleLabel?.numberOfLines = 0
        buttonMedium.titleLabel?.textAlignment = .center
        buttonMedium.setTitle("😘", for: .normal)

        let buttonLarge = UIButton()
        buttonLarge.layer.cornerRadius = 8.0
        buttonLarge.backgroundColor = .lightGray
        buttonLarge.titleLabel?.numberOfLines = 0
        buttonLarge.titleLabel?.textAlignment = .center
        buttonLarge.setTitle("🥳", for: .normal)

        let tipJarButtonStackView = UIStackView()
        tipJarButtonStackView.spacing = 8.0
        tipJarButtonStackView.distribution = .fillEqually
        tipJarButtonStackView.addArrangedSubview(buttonSmall)
        tipJarButtonStackView.addArrangedSubview(buttonMedium)
        tipJarButtonStackView.addArrangedSubview(buttonLarge)

        NSLayoutConstraint.activate([
            tipJarButtonStackView.heightAnchor.constraint(equalTo: buttonSmall.widthAnchor),
        ])

        return tipJarButtonStackView
    }()

    private lazy var tipJarStackView: UIStackView = {
        let tipJarStackView = UIStackView()
        tipJarStackView.axis = .vertical
        tipJarStackView.spacing = 20.0
        tipJarStackView.addArrangedSubview(tipJarIntroductionView)
        tipJarStackView.addArrangedSubview(tipJarButtonStackView)

        return tipJarStackView
    }()

    private lazy var imprintView: UIView = {
        let imprintViewController = ParagraphViewController(heading: "SettingsViewController.Imprint.Heading".localized, text: String(format: "SettingsViewController.Imprint.Text".localized, versionNumber, buildNumber))
        addChild(imprintViewController)

        return imprintViewController.view!
    }()

    private lazy var swipeInfoLabel: UILabel = {
        let swipeInfoLabel = UILabel()
        swipeInfoLabel.text = "↓ " + "SettingsViewController.Imprint.SwipeInfo".localized + " ↓"
        swipeInfoLabel.font = .swipeInfo
        swipeInfoLabel.textColor = .swipeInfo

        return swipeInfoLabel
    }()

    init() {
        super.init(nibName: nil, bundle: nil)

        setupSeparatorView()
        setupContentView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(dismissSettings))
        gestureRecognizer.direction = .down

        view = UIView()
        view.backgroundColor = .white
        view.addGestureRecognizer(gestureRecognizer)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        retrieveProductInformation()
    }
}

// MARK: - SKProductsRequestDelegate

extension SettingsViewController: SKProductsRequestDelegate {
    func retrieveProductInformation() {
        let identifiers = Set(["de.marcelkraus.speedometer.tip.small", "de.marcelkraus.speedometer.tip.medium", "de.marcelkraus.speedometer.tip.large"])

        productRequest = SKProductsRequest(productIdentifiers: identifiers)
        productRequest.delegate = self
        productRequest.start()
    }

    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print(response.products)
    }
}

// MARK: - Obj-C Selectors

private extension SettingsViewController {
    @objc func dismissSettings() {
        let impactGenerator = UIImpactFeedbackGenerator(style: .medium)
        impactGenerator.prepare()
        impactGenerator.impactOccurred()

        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UI Methods

private extension SettingsViewController {
    func setupSeparatorView() {
        view.addSubview(separatorView)

        separatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separatorView.heightAnchor.constraint(equalToConstant: 20.0),
            separatorView.widthAnchor.constraint(equalToConstant: 170.0),
            separatorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: -30.0),
            separatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40.0)
        ])
    }

    func setupContentView() {
        view.addSubview(contentStackView)

        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 40.0),
            contentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40.0),
            contentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40.0),
        ])
    }
}

// MARK: - Private Methods

private extension SettingsViewController {
    var versionNumber: String {
        guard let versionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
            return "–"
        }

        return versionNumber
    }

    var buildNumber: String {
        guard let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String else {
            return "–"
        }

        return buildNumber
    }
}
