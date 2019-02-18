import UIKit

class SeparatorViewController: UIViewController {
    private let separatorView = SeparatorView()

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
