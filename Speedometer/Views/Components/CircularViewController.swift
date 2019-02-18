import UIKit

class CircularViewController: UIViewController {
    private var background: UIColor

    private var filling: UIColor

    var speed: Speed? {
        didSet {
            guard let speed = speed else {
                return
            }

            (view as! CircularView).fillmentLevel = speed.fillment
        }
    }

    init(background: UIColor = .lightGray, filling: UIColor = .brand) {
        self.background = background
        self.filling = filling

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = CircularView(background: background, filling: filling)
    }
}
