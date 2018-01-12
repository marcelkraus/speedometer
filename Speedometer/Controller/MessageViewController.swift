import UIKit

class MessageViewController: UIViewController {
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!

    private let heading: String
    private let message: String

    init(message: String, heading: String = "An error has occurred") {
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

        super.viewDidLoad()
    }
}
