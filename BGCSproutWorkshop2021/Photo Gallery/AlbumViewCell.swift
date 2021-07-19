//
//  AlbumViewCell.swift
//  postikard
//
//  Created by Allison Schwarz on 5/9/19.
//  Copyright © 2019 Allison Schwarz. All rights reserved.
//

import UIKit

class AlbumViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var art: UIImageView!
    
    var representedAssetIdentifier: String = ""
}
