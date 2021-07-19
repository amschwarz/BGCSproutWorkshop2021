//
//  GridViewCell.swift
//  postikard
//
//  Created by Allison Schwarz on 5/8/19.
//  Copyright © 2019 Allison Schwarz. All rights reserved.
//

import UIKit

class GridViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    
    var representedAssetIdentifier: String = ""
    
    var thumbnailImage: UIImage? {
        didSet {
            photo.image = thumbnailImage
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photo.image = nil
    }
}
