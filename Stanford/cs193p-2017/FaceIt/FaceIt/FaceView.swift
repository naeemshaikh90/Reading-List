/**
 * Created by Naeem Shaikh on 08/03/17.
 *
 * Copyright © 2017-present Naeem Shaikh
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

@IBDesignable
class FaceView: UIView
{
    // MARK:- Public API
    
    @IBInspectable
    var scale: CGFloat = 0.9 { didSet { setNeedsDisplay() } }
    
    @IBInspectable
    var eyesOpen: Bool = false { didSet { setNeedsDisplay() } }
    
    @IBInspectable
    var lineWidth: CGFloat = 5.0 { didSet { setNeedsDisplay() } }
    
    @IBInspectable
    var color: UIColor = .blue { didSet { setNeedsDisplay() } }
    
    // 1.0 is full smile and -1.0 is full frown
    @IBInspectable
    var mouthCurvature: Double = 1.0 { didSet { setNeedsDisplay() } }
    
    func changeScale(byReactingTo pinchRecognizer: UIPinchGestureRecognizer)
    {
        switch pinchRecognizer.state {
        case .changed, .ended:
            scale *= pinchRecognizer.scale
            pinchRecognizer.scale = 1
        default:
            break
        }
    }
    
    // MARK:- Private Implementation
    
    private let skullStartAngle: CGFloat = 0
    private let skullEndAngle = 2 * CGFloat.pi
    private let skullClockWise = false
    
    private var skullCenter: CGPoint {
        return CGPoint(
            x: bounds.midX,
            y: bounds.midY
        )
    }
    
    private var skullRadius: CGFloat {
        return (min(bounds.size.width, bounds.size.height) / 2) * scale
    }
    
    private struct Ratios {
        static let skullRadiusToEyeOffset: CGFloat = 3
        static let skullRadiusToEyeRadius: CGFloat = 10
        static let skullRadiusToMouthWidth: CGFloat = 1
        static let skullRadiusToMouthHeight: CGFloat = 3
        static let skullRadiusToMouthOffset: CGFloat = 3
    }
    
    private enum Eye {
        case left
        case right
    }
    
    private func pathForEye(_ eye: Eye) -> UIBezierPath
    {
        func centerForEye(_ eye: Eye) -> CGPoint {
            let eyeOffset = skullRadius / Ratios.skullRadiusToEyeOffset
            var eyeCenter = skullCenter
            eyeCenter.y -= eyeOffset
            eyeCenter.x += ((eye == .left) ? -1 : 1) * eyeOffset
            return eyeCenter
        }
        
        let eyeCenter = centerForEye(eye)
        let eyeRadius = skullRadius / Ratios.skullRadiusToEyeRadius
        
        let path: UIBezierPath
        if eyesOpen {
            path = UIBezierPath(
                arcCenter: eyeCenter,
                radius: eyeRadius,
                startAngle: skullStartAngle,
                endAngle: skullEndAngle,
                clockwise: skullClockWise
            )
        } else {
            path = UIBezierPath()
            path.move(
                to: CGPoint(
                    x: eyeCenter.x - eyeRadius,
                    y: eyeCenter.y
                )
            )
            path.addLine(
                to: CGPoint(
                    x: eyeCenter.x + eyeRadius, y: eyeCenter.y
                )
            )
        }
        path.lineWidth = lineWidth
        return path
    }
    
    private func pathForMouth() -> UIBezierPath
    {
        let mouthWidth = skullRadius / Ratios.skullRadiusToMouthWidth
        let mouthHeight = skullRadius / Ratios.skullRadiusToMouthHeight
        let mouthOffset = skullRadius / Ratios.skullRadiusToMouthOffset
        
        let mouthRect = CGRect(
            x: skullCenter.x - mouthWidth / 2,
            y: skullCenter.y + mouthOffset,
            width: mouthWidth,
            height: mouthHeight
        )
        
        let smileOffset = CGFloat(max(-1, min(mouthCurvature, 1))) * mouthRect.height
        
        let start = CGPoint(
            x: mouthRect.minX,
            y: mouthRect.midY)
        let end = CGPoint(
            x: mouthRect.maxX,
            y: mouthRect.midY)
        
        let cp1 = CGPoint(
            x: start.x + mouthRect.width / 3,
            y: start.y + smileOffset
        )
        let cp2 = CGPoint(
            x: end.x - mouthRect.width / 3,
            y: end.y + smileOffset
        )
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        return path
    }
    
    private func pathForSkull() -> UIBezierPath
    {
        let path = UIBezierPath(
            arcCenter: skullCenter,
            radius: skullRadius,
            startAngle: skullStartAngle,
            endAngle: skullEndAngle,
            clockwise: skullClockWise
        )
        path.lineWidth = lineWidth
        return path
    }
    
    override func draw(_ rect: CGRect) {
        color.set()
        pathForSkull().stroke()
        pathForEye(.left).stroke()
        pathForEye(.right).stroke()
        pathForMouth().stroke()
    }

}
