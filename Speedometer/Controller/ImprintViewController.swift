import UIKit

class ImprintViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }

    @IBOutlet weak var appTitle: UILabel! {
        didSet {
            let versionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
            let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String

            appTitle.text = "Speedometer (v\(versionNumber), Build \(buildNumber))"
        }
    }

    @IBAction func closeImprint(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
