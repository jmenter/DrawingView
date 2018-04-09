
import UIKit

class DrawingView: UIView {

    fileprivate let path = UIBezierPath()
    
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
        guard let location = touches.first?.location(in: self) else { return }
        path.move(to: CGPoint(x: location.x + 0.1, y: location.y + 0.1))
        add(point: location)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }
        add(point: location)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }
        add(point: location)
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.black.setStroke()
        path.stroke()
    }

    fileprivate func add(point: CGPoint) {
        path.addLine(to: point)
        setNeedsDisplay()
    }
    
}
