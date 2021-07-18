//
//  PhotoManager.swift
//
//  Created by Allison Schwarz on 5/15/19.
//  Copyright © 2019 Allison Schwarz. All rights reserved.
//

import UIKit
import Photos

open class PhotoManager {
    
    public static let shared = PhotoManager()
    
    public let imageManager = PHCachingImageManager()
    
    public var hasSaved = false

    public static let context = CIContext()
    
    private init() {}

}
