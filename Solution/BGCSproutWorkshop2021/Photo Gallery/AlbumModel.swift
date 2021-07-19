//
//  AlbumModel.swift
//  BGCSproutWorkshop2021
//
//  Created by Allison Schwarz on 7/18/21.
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
