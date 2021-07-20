//
//  UIView+Utilities.swift
//  BGCSproutWorkshop2021
//
//  Created by Allison Schwarz on 7/19/21.
//

import UIKit

extension UIView {
    func toImage(_ bounds: CGRect) -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        let renderer = UIGraphicsImageRenderer(bounds: bounds, format: format)
        let image = renderer.image { rendererContext in
            self.layer.render(in: rendererContext.cgContext)
        }
        return image
    }
}
