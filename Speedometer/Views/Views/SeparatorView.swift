import UIKit

class SeparatorView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.layer.masksToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = rect.height/2

        super.draw(rect)
    }
}
