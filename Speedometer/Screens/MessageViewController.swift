import UIKit

class MessageViewController: UIViewController {
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!

    private let heading: String
    private let message: String

    init(heading: String, message: String) {
        self.heading = heading
        self.message = message

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }

    override func viewDidLoad() {
        headingLabel?.text = heading
        messageLabel?.text = message

        headingLabel.textColor = view.tintColor
        messageLabel.numberOfLines = 0

        super.viewDidLoad()
    }
}
