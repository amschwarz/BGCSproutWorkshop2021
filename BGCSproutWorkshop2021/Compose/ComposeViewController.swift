//
//  ComposeViewController.swift
//  BGCSproutWorkshop2021
//
//  Created by Allison Schwarz on 7/14/21.
//

import UIKit

class ComposeViewController: UIViewController {
    
    lazy var sendButton: UIBarButtonItem  = {
        return UIBarButtonItem(title: "Send", style: .done, target: self, action: #selector(sendPost))
    }()

    @IBOutlet weak var profile: UIButton! {
        didSet {
            profile.layer.cornerRadius = profile.frame.height / 2
            profile.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var imageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = sendButton
        textView.becomeFirstResponder()
    }
    
    @IBAction func attachImage(_ sender: Any) {
    }
    
    @objc func sendPost() {
        //Call api to send the post
    }

    @IBAction func showProfilePicker(_ sender: Any) {
        //Show profile selection view
    }
    
}

