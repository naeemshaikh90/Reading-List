/**
 * Created by Naeem Shaikh on 29/03/17.
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

/*
 * Simple UIScrollView example, using download image from url
 */

import UIKit

class ImageViewController: UIViewController
{
    // MARK: Model
    
    var imageURL: URL? {
        didSet {
            image = nil
            if view.window != nil { // If we're on the screen
                fetchImage()        // than only load the image
            }
        }
    }
    
    // MARK: Private Method
    
    private func fetchImage() {
        if let url = imageURL {
            // next line of code can cause error
            let urlContents = try? Data(contentsOf: url)
            if let imageData = urlContents {
                image = UIImage(data: imageData)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageURL = DemoURL.stanford // For Demo/testing purposes only
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {   // We're about to be appear on the screen
            fetchImage()    // load image if needed
        }
    }
    
    // MARK: UI
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            // Most important thing to set 'contentSize' of 'UIScrollView'
            scrollView.contentSize = imageView.frame.size
            
            // For zooming we need to handle 'viewForZooming'
            scrollView.delegate = self
            // And set min and max zoom scales
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
            scrollView.addSubview(imageView)
        }
    }
    
    fileprivate var imageView = UIImageView()
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            // be careful here as 'scrollView' might be nil
            // so use optional(?) chaining
            scrollView?.contentSize = imageView.frame.size
        }
    }
}

// MARK: UIScrollViewDelegate
// Extension which will make 'ImageViewController' conforms to 'UIScrollViewDelegate'
// Handles 'UIScrollViewDelegate' delegate methods
extension ImageViewController: UIScrollViewDelegate
{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
