import UIKit

class ParagraphViewController: UIViewController {

    // MARK: - Properties

    var heading: String

    var text: String

    // MARK: - Outlets & Actions

    @IBOutlet private weak var headingLabel: UILabel!

    @IBOutlet private weak var textLabel: UILabel!

    // MARK: - View Controller Lifecycle

    init(heading: String, text: String) {
        self.heading = heading
        self.text = text

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        headingLabel.text = heading
        textLabel.text = text

        headingLabel.textColor = view.tintColor
    }
}
