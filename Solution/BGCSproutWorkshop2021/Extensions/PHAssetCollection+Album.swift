//
//  PHAssetCollection+Album.swift
//
//  Created by Allison Schwarz on 5/10/19.
//  Copyright © 2019 Allison Schwarz. All rights reserved.
//

import UIKit
import Photos

public extension PHAssetCollection {
    func convertToAlbum() -> AlbumModel? {
        let scale = UIScreen.main.scale
        let thumbnailSize = CGSize(width: 200.0 * scale, height: 200.0 * scale)
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
        
        let result = PHAsset.fetchAssets(in: self, options: fetchOptions)
        guard let asset = result.firstObject else {return nil}
        let newAlbum = AlbumModel(name: localizedTitle ?? "", count: result.count, collection:self)
        
        let imageRequestOptions = PHImageRequestOptions()
        imageRequestOptions.isNetworkAccessAllowed = false
        imageRequestOptions.isSynchronous = true
        imageRequestOptions.deliveryMode = .highQualityFormat
        //imageRequestOptions.resizeMode = .exact
        PHImageManager.default().requestImage(
            for: asset,
            targetSize: thumbnailSize,
            contentMode: .aspectFit,
            options: imageRequestOptions,
            resultHandler: {(img, info) in
                newAlbum.thumbnail = img }
        )
        
        return newAlbum
    }
}
