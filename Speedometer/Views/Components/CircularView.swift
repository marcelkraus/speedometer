import UIKit

class CircularView: UIView {
    private enum Layer {
        case indicator, track
    }

    private let startAngleInDegrees: Double

    private let maxAngleInDegrees: Double

    private let lineWeight: Double

    let indicatorColor: CGColor

    let trackColor: CGColor

    var indicatorFillment: Double {
        didSet {
            setNeedsDisplay()
        }
    }

    init(startAngleInDegrees: Double, maxAngleInDegrees: Double, lineWeight: Double, indicatorColor: UIColor, trackColor: UIColor, indicatorFillment: Double) {
        self.startAngleInDegrees = startAngleInDegrees
        self.maxAngleInDegrees = maxAngleInDegrees
        self.lineWeight = lineWeight
        self.indicatorColor = indicatorColor.cgColor
        self.trackColor = trackColor.cgColor
        self.indicatorFillment = indicatorFillment

        super.init(frame: .zero)
    }

    convenience init(indicatorColor: UIColor, trackColor: UIColor, indicatorFillment: Double) {
        self.init(startAngleInDegrees: 180.0, maxAngleInDegrees: 90.0, lineWeight: 12.0, indicatorColor: indicatorColor, trackColor: trackColor, indicatorFillment: indicatorFillment)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        layer.addSublayer(circleLayer(for: .track))
        layer.addSublayer(circleLayer(for: .indicator))
    }

    private func circleLayer(for layer: Layer) -> CAShapeLayer {
        let fillment = (layer == .track) ? 1.0 : indicatorFillment
        let color = (layer == .track) ? trackColor : indicatorColor

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

        return circleLayer
    }

    private func radians(of degrees: Double) -> Double {
        return degrees * (.pi / 180)
    }

    private func endAngleInDegrees(forFillmentLevel fillmentLevel: Double) -> Double {
        return (maxAngleInDegrees * fillmentLevel) + startAngleInDegrees
    }
}
