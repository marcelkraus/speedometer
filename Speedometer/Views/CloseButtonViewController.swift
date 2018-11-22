import UIKit

class CloseButtonViewController: UIViewController {

    // MARK: - Outlets & Actions

    @IBAction func didTapButton(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }

    // MARK: - View Controller Lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
