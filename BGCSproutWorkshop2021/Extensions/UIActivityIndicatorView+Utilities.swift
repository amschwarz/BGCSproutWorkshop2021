//
//  UIActivityIndicatorView+Posti.swift
//
//  Created by Allison Schwarz on 9/7/19.
//  Copyright © 2019 Allison Schwarz. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {
    func start() {
        DispatchQueue.main.async { [weak self] in
            self?.isHidden = false
            self?.startAnimating()
        }
    }
    
    func stop() {
        DispatchQueue.main.async { [weak self] in
            self?.stopAnimating()
            self?.isHidden = true
        }
    }
}
