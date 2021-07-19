//
//  AttachedImageButton.swift
//  BGCSproutWorkshop2021
//
//  Created by Allison Schwarz on 7/18/21.
//

import UIKit

class AttachedImageButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setBackgroundImage(nil, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setBackgroundImage(nil, for: .normal)
    }
    
    override func setBackgroundImage(_ image: UIImage?, for state: UIControl.State) {
        super.setBackgroundImage(image, for: state)
        guard image == nil else {
            isUserInteractionEnabled = true
            setTitle("", for: .normal)
            backgroundColor = .systemBackground
            return
        }
        showEmptyState()
        isUserInteractionEnabled = false
    }
    
    
    private func showEmptyState() {
        setTitle("No Image", for: .normal)
        backgroundColor = .systemGray
    }
}
