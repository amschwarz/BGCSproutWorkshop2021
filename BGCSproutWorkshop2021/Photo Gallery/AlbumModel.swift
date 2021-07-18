//
//  AlbumModel.swift
//
//  Created by Allison Schwarz on 5/10/19.
//  Copyright © 2019 Allison Schwarz. All rights reserved.
//

import UIKit
import Photos

open class AlbumModel {
    public let name: String
    public let count: Int
    public let collection: PHAssetCollection
    public var thumbnail: UIImage? = nil
    
    init(name:String, count:Int, collection:PHAssetCollection) {
        self.name = name
        self.count = count
        self.collection = collection
    }
}
