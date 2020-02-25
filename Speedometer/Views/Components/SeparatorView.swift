import UIKit

class SeparatorView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.masksToBounds = true
        backgroundColor = .branding
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        layer.cornerRadius = rect.height/2
    }
}
