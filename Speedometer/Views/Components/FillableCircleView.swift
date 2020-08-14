import UIKit

class FillableCircleView: UIControl {
    let color: UIColor
    let isFilled: Bool
    let outlineWidth: CGFloat

    init(color: UIColor, isFilled: Bool = false, outlineWidth: Double = 6.0) {
        self.color = color
        self.isFilled = isFilled
        self.outlineWidth = CGFloat(outlineWidth)

        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        color.set()

        let context = UIGraphicsGetCurrentContext()!
        context.setLineWidth(outlineWidth);
        let center = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        let radius = (frame.size.width - (outlineWidth * 2))/2
        context.addArc(center: center, radius: radius, startAngle: 0.0, endAngle: .pi * 2.0, clockwise: true)

        isFilled ? context.fillPath() : context.strokePath()
    }
}
