//
//  PhotoEditorViewController.swift
//  BGCSproutWorkshop2021
//
//  Created by Allison Schwarz on 7/18/21.
//

import UIKit

class PhotoEditorViewController: UIViewController {
    
    var originalImage: UIImage?
    //private var latestCenter = CGPoint()
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = originalImage
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
}

//Uncomment below to handle gestures
//extension PhotoEditorViewController : UIGestureRecognizerDelegate {
//    @objc public func didPan(_ gestureRecognizer : UIPanGestureRecognizer) {
//        guard gestureRecognizer.view != nil, let pannedView = imageView else {return}
//        // Get the changes in the X and Y directions relative to
//        // the superview's coordinate space.
//        let translation = gestureRecognizer.translation(in: pannedView.superview)
//        if gestureRecognizer.state == .began {
//            // Save the view's original position.
//            latestCenter = pannedView.center
//        }
//        guard gestureRecognizer.state != .cancelled else {
//            // On cancellation, return the piece to its original location.
//            pannedView.center = latestCenter
//            return
//        }
//        // Update the position for the .began, .changed, and .ended states
//        // Add the X and Y translation to the view's original position.
//        let newCenter = CGPoint(x: latestCenter.x + translation.x, y: latestCenter.y + translation.y)
//        pannedView.center = newCenter
//    }
//
//    @IBAction public func didPinch(_ gestureRecognizer : UIPinchGestureRecognizer) {
//        //Get the gesture zoom scale and transform the image
//        let scale = gestureRecognizer.scale
//        imageView.transform = imageView.transform.scaledBy(x: scale, y: scale)
//        //Reset gesture scale
//        gestureRecognizer.scale = 1
//
//        //Recenter image in view
//        imageView.center = CGPoint(x: imageView.bounds.width/2.0, y: imageView.bounds.height/2.0)
//    }
//
//    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
//                                  shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer)
//        -> Bool {
//            return true
//    }
//}
