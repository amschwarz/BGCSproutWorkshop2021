//
//  PhotoManager.swift
//  BGCSproutWorkshop2021
//
//  Created by Allison Schwarz on 7/18/21.
//

import UIKit
import Photos

open class PhotoManager {
    
    public static let shared = PhotoManager()
    
    public let imageManager = PHCachingImageManager()
    
    private init() {}
    
    var thumbnailSize: CGSize {
        let scale = UIScreen.main.scale
        return CGSize(width: 200.0 * scale, height: 200.0 * scale)
    }
}
