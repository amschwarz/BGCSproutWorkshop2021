//
//  UITextView+Placeholder.swift
//  BGCSproutWorkshop2021
//
//  Created by Allison Schwarz on 7/18/21.
//

import UIKit

extension UITextView {
    
    private var isShowingPlaceholder : Bool {
        return alpha != 1.0
    }
    
    func showPlaceholderIfNeeded(_ placeholder: String) {
        guard (text.isEmpty && attributedText.length == 0) else {
            self.alpha = 1.0
            return
        }
        attributedText = NSAttributedString(string: placeholder)
        self.alpha = 0.4
        moveCursorToBeginning()
    }
    
    func removePlaceholderIfNeeded() {
        guard isShowingPlaceholder else {return}
        attributedText = NSAttributedString(string: "")
    }
    
    func moveCursorToBeginning() {
        let newPosition = beginningOfDocument
        selectedTextRange = textRange(from: newPosition, to: newPosition)
    }
}
