//
//  PhotoEditorViewController.swift
//  BGCSproutWorkshop2021
//
//  Created by Allison Schwarz on 7/18/21.
//

import UIKit

protocol PhotoEditorDelegate: AnyObject {
    func savedPhoto(_ image: UIImage)
}

class PhotoEditorViewController: UIViewController {
    
    weak var delegate: PhotoEditorDelegate?
    var originalImage: UIImage?
    private var latestCenter = CGPoint()
    
    @IBOutlet weak var imageBackground: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gridView: GridView! {
        didSet {
            gridView.isHidden = true
        }
    }
    @IBOutlet weak var overlayTop: UIView!
    @IBOutlet weak var overlayBottom: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = originalImage
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        view.addGestureRecognizer(panGesture)
        panGesture.delegate = self
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(_:)))
        view.addGestureRecognizer(pinchGesture)
        pinchGesture.delegate = self
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        let image = view.toImage(imageBackground.frame)
        delegate?.savedPhoto(image)
        dismiss(animated: false, completion: nil)
    }
    
    private func updateOverlay(with gesture: UIGestureRecognizer) {
        let isGesturing = gesture.state != .cancelled && gesture.state != .ended
        let alpha : CGFloat = isGesturing ? 0.7 : 1.0
        overlayTop.alpha = alpha
        overlayBottom.alpha = alpha
        gridView.isHidden = !isGesturing
    }
}

extension PhotoEditorViewController : UIGestureRecognizerDelegate {
    @objc public func didPan(_ gestureRecognizer : UIPanGestureRecognizer) {
        guard gestureRecognizer.view != nil, let pannedView = imageView else {return}
        updateOverlay(with: gestureRecognizer)
        // Get the changes in the X and Y directions relative to
        // the superview's coordinate space.
        let translation = gestureRecognizer.translation(in: pannedView.superview)
        if gestureRecognizer.state == .began {
            // Save the view's original position.
            latestCenter = pannedView.center
        }
        guard gestureRecognizer.state != .cancelled else {
            // On cancellation, return the piece to its original location.
            pannedView.center = latestCenter
            return
        }
        // Update the position for the .began, .changed, and .ended states
        // Add the X and Y translation to the view's original position.
        let newCenter = CGPoint(x: latestCenter.x + translation.x, y: latestCenter.y + translation.y)
        pannedView.center = newCenter
    }
    
    @IBAction public func didPinch(_ gestureRecognizer : UIPinchGestureRecognizer) {
        updateOverlay(with: gestureRecognizer)
        
        //Get the gesture zoom scale and transform the image
        let scale = gestureRecognizer.scale
        imageView.transform = imageView.transform.scaledBy(x: scale, y: scale)
        //Reset gesture scale
        gestureRecognizer.scale = 1

        //Recenter image in view
        imageView.center = CGPoint(x: imageView.bounds.width/2.0, y: imageView.bounds.height/2.0)
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                  shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer)
        -> Bool {
            return true
    }
}
