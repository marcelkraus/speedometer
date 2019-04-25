import UIKit

class CircularView: UIView {
    private let startAngleInDegrees = 180.0
    private let maxAngleInDegrees = 90.0

    private var background: CGColor = UIColor.lightGray.cgColor
    private var filling: CGColor = UIColor.darkGray.cgColor
    private var lineWeight: Double = 15.0
    private var fillmentLevel: Double = 0.0

    func updateAppearance(background: UIColor, filling: UIColor, lineWeight: Double = 15.0) {
        self.background = background.cgColor
        self.filling = filling.cgColor
        self.lineWeight = lineWeight

        setNeedsDisplay()
    }

    func setFillmentLevel(_ fillmentLevel: Double) {
        self.fillmentLevel = fillmentLevel

        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        drawBackgroundCircle()
        drawCircle(with: fillmentLevel, in: filling)
    }
}

private extension CircularView {
    func radians(of degrees: Double) -> CGFloat {
        return CGFloat(degrees * (.pi / 180))
    }

    func endAngleInDegrees(forFillmentLevel fillmentLevel: Double) -> Double {
        return (maxAngleInDegrees * fillmentLevel) + startAngleInDegrees
    }

    func drawCircle(with fillmentLevel: Double, in color: CGColor) {
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: bounds.maxX, y: bounds.maxY),
            radius: bounds.width - CGFloat(lineWeight) / 2.0,
            startAngle: radians(of: startAngleInDegrees),
            endAngle: radians(of: endAngleInDegrees(forFillmentLevel: fillmentLevel)),
            clockwise: true
        )

        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = color
        circleLayer.lineWidth = CGFloat(lineWeight)

        layer.addSublayer(circleLayer)
    }

    func drawBackgroundCircle() {
        drawCircle(with: 1.0, in: background)
    }
}
