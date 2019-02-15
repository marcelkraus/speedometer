import UIKit

class CircularView: UIView {

    // MARK: - Properties

    static let startAngleInDegrees = 180.0

    static let maxAngleInDegrees = 90.0

    var background: CGColor {
        didSet {
            setNeedsDisplay()
        }
    }

    var filling: CGColor {
        didSet {
            setNeedsDisplay()
        }
    }

    var lineWeight: Double = 15.0 {
        didSet {
            setNeedsDisplay()
        }
    }

    var fillmentLevel: Double = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }

    // MARK: - View Lifecycle

    init(background: UIColor, filling: UIColor) {
        self.background = background.cgColor
        self.filling = filling.cgColor

        super.init(frame: CGRect.zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        drawBackgroundCircle()
        drawCircle(with: fillmentLevel, in: filling)
    }
}

private extension CircularView {

    // MARK: - Private Methods

    func radians(of degrees: Double) -> CGFloat {
        return CGFloat(degrees * (.pi / 180))
    }

    func endAngleInDegrees(forFillmentLevel fillmentLevel: Double) -> Double {
        return (CircularView.maxAngleInDegrees * fillmentLevel) + CircularView.startAngleInDegrees
    }

    func drawCircle(with fillmentLevel: Double, in color: CGColor) {
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: bounds.maxX, y: bounds.maxY),
            radius: bounds.width - CGFloat(lineWeight) / 2.0,
            startAngle: radians(of: CircularView.startAngleInDegrees),
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
