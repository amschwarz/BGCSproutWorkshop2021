//
//  ComposeViewController.swift
//  BGCSproutWorkshop2021
//
//  Created by Allison Schwarz on 7/14/21.
//

import Photos
import UIKit

class ComposeViewController: UIViewController {
    
    lazy var sendButton: UIBarButtonItem  = {
        return UIBarButtonItem(title: "Send", style: .done, target: self, action: #selector(sendPost))
    }()
    
    lazy var keyboardToolbar: UIToolbar  = {
        let bar = UIToolbar()
        let camera = UIBarButtonItem(image: UIImage(systemName: "camera"), style: .done, target: self, action: #selector(cameraTapped))
        bar.items = [camera]
        bar.sizeToFit()
        return bar
    }()

    @IBOutlet weak var profile: UIButton! {
        didSet {
            profile.layer.cornerRadius = profile.frame.height / 2
            profile.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.inputAccessoryView = keyboardToolbar
            textView.delegate = self
        }
    }
    
    @IBOutlet weak var imageButton: AttachedImageButton! {
        didSet {
            imageButton.layer.cornerRadius = 8.0
            imageButton.clipsToBounds = true
            imageButton.setBackgroundImage(nil, for: .normal)
        }
    }
    
    private var attachedImage: UIImage? {
        didSet {
            imageButton.setBackgroundImage(attachedImage, for: .normal)
        }
    }
    
    private let textViewPlaceholder = NSLocalizedString("What is on your mind?", comment: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = sendButton
        textView.becomeFirstResponder()
        shouldEnableSend()
    }
    
    @IBAction func imageTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "PhotoEditor", bundle: nil)
        guard let editorViewController = storyboard.instantiateInitialViewController() as? PhotoEditorViewController else { return }
        editorViewController.originalImage = attachedImage
        editorViewController.modalPresentationStyle = .overFullScreen
        present(editorViewController, animated: true, completion: nil)
    }
    
    @objc func cameraTapped() {
        let storyboard = UIStoryboard(name: "PhotoGallery", bundle: nil)
        guard let navViewController = storyboard.instantiateInitialViewController() as? UINavigationController else { return }
        guard let galleryViewController = navViewController.viewControllers.first as? PhotoGalleryViewController else { return }
        galleryViewController.delegate = self
        present(navViewController, animated: true, completion: nil)
    }

    func shouldEnableSend() {
        guard !textView.text.isEmpty && self.attachedImage != nil else {
            sendButton.isEnabled = false
            return
        }
        sendButton.isEnabled = true
    }
    
    @objc func sendPost() {
        //Call api to send the post
    }

    @IBAction func showProfilePicker(_ sender: Any) {
        //Show profile selection view
    }
}

extension ComposeViewController: PhotoGalleryDelegate {
    func didSelectImage(_ asset: PHAsset) {
        PhotoManager.shared.imageManager.requestImage(for: asset, targetSize: PhotoManager.shared.thumbnailSize, contentMode: .aspectFill, options: nil, resultHandler: { image, _ in
            self.attachedImage = image
        })
    }
}

extension ComposeViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        shouldEnableSend()
    }
}

