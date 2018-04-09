
import UIKit

class DrawingView: UIView {

    fileprivate let path = UIBezierPath()
    fileprivate var previousPoint: CGPoint = .zero
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        path.lineWidth = 2
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = false
        contentMode = .redraw
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
        path.move(to: CGPoint(x: point.x + 0.1, y: point.y + 0.1))
        path.addLine(to: point)
        previousPoint = point
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }
        add(point: location)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }
        add(point: location)
    }
    
    fileprivate func add(point: CGPoint) {
        path.addQuadCurve(to: CGPoint(x: (previousPoint.x + point.x) / 2, y: (previousPoint.y + point.y) / 2), controlPoint: previousPoint)
        previousPoint = point
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.black.setStroke()
        path.stroke()
    }

}
