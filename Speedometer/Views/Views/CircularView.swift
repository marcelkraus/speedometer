import UIKit

class CircularView: UIView {
    private let startAngleInDegrees: Double

    private let maxAngleInDegrees: Double

    private let lineWeight: Double

    private let color: CGColor

    var fillment: Double {
        didSet {
            setNeedsDisplay()
        }
    }

    init(startAngleInDegrees: Double, maxAngleInDegrees: Double, lineWeight: Double, color: UIColor, fillment: Double) {
        self.startAngleInDegrees = startAngleInDegrees
        self.maxAngleInDegrees = maxAngleInDegrees
        self.lineWeight = lineWeight
        self.color = color.cgColor
        self.fillment = fillment

        super.init(frame: .zero)
    }

    convenience init(color: UIColor, fillment: Double) {
        self.init(startAngleInDegrees: 180.0, maxAngleInDegrees: 90.0, lineWeight: 12.0, color: color, fillment: fillment)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: bounds.maxX, y: bounds.maxY),
            radius: bounds.width - CGFloat(lineWeight) / 2.0,
            startAngle: CGFloat(radians(of: startAngleInDegrees)),
            endAngle: CGFloat(radians(of: endAngleInDegrees(forFillmentLevel: fillment))),
            clockwise: true
        )

        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = color
        circleLayer.lineWidth = CGFloat(lineWeight)

        layer.addSublayer(circleLayer)
    }

    private func radians(of degrees: Double) -> Double {
        return degrees * (.pi / 180)
    }

    private func endAngleInDegrees(forFillmentLevel fillmentLevel: Double) -> Double {
        return (maxAngleInDegrees * fillmentLevel) + startAngleInDegrees
    }
}
