import UIKit

class SeparatorViewController: UIViewController {
    private lazy var separatorView: UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(red: 0.012, green: 0.569, blue: 0.576, alpha: 0.75)
        separatorView.layer.cornerRadius = 10.0

        return separatorView
    }()

    init() {
        super.init(nibName: nil, bundle: nil)

        setupSeparatorView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SeparatorViewController {
    func setupSeparatorView() {
        view.addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorView.topAnchor.constraint(equalTo: view.topAnchor),
            separatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
    }
}
