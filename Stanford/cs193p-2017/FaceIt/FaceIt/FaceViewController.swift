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

class FaceViewController: UIViewController
{
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            let pinchHandler = #selector(FaceView.changeScale(byReactingTo:))
            let pinchRecognizer = UIPinchGestureRecognizer(target: faceView, action: pinchHandler)
            faceView.addGestureRecognizer(pinchRecognizer)
            
            let tapHandler = #selector(toggelEyes(byReactingTo:))
            let tapRecognizer = UITapGestureRecognizer(target: self, action: tapHandler)
            tapRecognizer.numberOfTapsRequired = 1
            faceView.addGestureRecognizer(tapRecognizer)
            
            let swipeUpHandler = #selector(increaseHappiness)
            let swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: swipeUpHandler)
            swipeUpRecognizer.direction = .up
            faceView.addGestureRecognizer(swipeUpRecognizer)
            
            let swipeDownHandler = #selector(decreaseHappiness)
            let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: swipeDownHandler)
            swipeDownRecognizer.direction = .down
            faceView.addGestureRecognizer(swipeDownRecognizer)
            
            updateUI()
        }
    }
    
    func toggelEyes(byReactingTo tapRecognizer:UITapGestureRecognizer) {
        if tapRecognizer.state == .ended {
            let eyes: FacialExpression.Eyes = (expression.eyes == .closed) ? .open : .closed
            expression = FacialExpression(eyes: eyes, mouth: expression.mouth)
        }
    }
    
    func increaseHappiness() {
        expression = expression.happier
    }
    
    func decreaseHappiness() {
        expression = expression.sadder
    }
    
    var expression = FacialExpression(eyes: .closed, mouth: .neutral) {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI()
    {
        switch expression.eyes {
        case .closed:
            faceView?.eyesOpen = false
        case .open:
            faceView?.eyesOpen = true
        case .squinting:
            faceView?.eyesOpen = false
        }
        
        faceView?.mouthCurvature = mouthCurvaters[expression.mouth] ?? 0.0
    }
    
    private let mouthCurvaters = [
        FacialExpression.Mouth.frown: -1.0,
        .smirk: -0.5,
        .neutral: 0.0,
        .grin: 0.5,
        .smile: 1.0
    ]
}

