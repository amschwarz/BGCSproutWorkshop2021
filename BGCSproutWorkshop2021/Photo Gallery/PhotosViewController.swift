//
//  PhotosViewController.swift
//
//  Created by Allison Schwarz on 5/8/19.
//  Copyright © 2019 Allison Schwarz. All rights reserved.
//

import UIKit
import Photos

class PhotosViewController: UIViewController {
    
    @IBOutlet weak var photosView: UICollectionView!
    
    @IBOutlet weak var scrollParentView: UIView!
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var selected: UIImageView!
    
    private var photos: PHFetchResult<PHAsset>?
    var selectedAsset : PHAsset?
    
    fileprivate var thumbnailSize: CGSize!
    private static let cellIdentifier = "GridViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photosView.delegate = self
        photosView.dataSource = self
        
        imageScrollView.delegate = self
        imageScrollView.minimumZoomScale = 1.0
        imageScrollView.maximumZoomScale = 100.0

        let scale = UIScreen.main.scale
        thumbnailSize = CGSize(width: 200.0 * scale, height: 200.0 * scale)
    }
    
    func setPhotos(photos: PHFetchResult<PHAsset>?) {
        self.photos = photos
        defer { photosView.reloadData() }
        guard let asset = photos?.firstObject else {return}
        didSelectAsset(asset)
    }
    
    func didSelectAsset(_ asset: PHAsset) {
        selectedAsset = asset
        imageScrollView.zoomScale = 1
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
//        options.isSynchronous = true
//        options.resizeMode = .exact
        PhotoManager.shared.imageManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: options, resultHandler: { image, _ in
            guard let image = image else {return}
            DispatchQueue.main.async {
                self.selected.image = image
            }
        })
    }
}

extension PhotosViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosViewController.cellIdentifier, for: indexPath) as? GridViewCell
            else { return UICollectionViewCell() }
        guard let asset = photos?.object(at: indexPath.item) else {return cell}
        
        // Request an image for the asset from the PHCachingImageManager.
        cell.representedAssetIdentifier = asset.localIdentifier
        PhotoManager.shared.imageManager.requestImage(for: asset, targetSize: thumbnailSize, contentMode: .aspectFill, options: nil, resultHandler: { image, _ in
            if cell.representedAssetIdentifier == asset.localIdentifier {
                cell.photo.image = image
            }
        })
        cell.alpha = asset.localIdentifier == selectedAsset?.localIdentifier ? 0.5 : 1.0
        return cell
    }
}

extension PhotosViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let asset = photos?.object(at: indexPath.item) else {return}
        didSelectAsset(asset)
        collectionView.reloadData()
    }
}

extension PhotosViewController : UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.selected
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 3) / 4
        return CGSize(width: width, height: width)
    }
}
