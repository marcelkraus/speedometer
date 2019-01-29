import UIKit

class SpeedViewController: UIViewController {
    var speed: Speed? {
        didSet {
            guard let speed = speed else {
                return
            }

            speedLabel.text = speed.asString
        }
    }

    var unit: Unit? {
        didSet {
            guard let unit = unit else {
                return
            }

            unitLabel.text = unit.abbreviation
        }
    }

    @IBOutlet private weak var speedLabel: UILabel!

    @IBOutlet private weak var unitLabel: UILabel!

    @IBOutlet private weak var unitBackgroundView: UIView! {
        didSet {
            unitBackgroundView.layer.masksToBounds = true
            unitBackgroundView.layer.cornerRadius = 20.0
        }
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
