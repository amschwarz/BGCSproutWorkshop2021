//
//  PhotoGalleryViewController.swift
//  postikard
//
//  Created by Allison Schwarz on 5/12/19.
//  Copyright © 2019 Allison Schwarz. All rights reserved.
//

import UIKit
import Photos

protocol PhotoGalleryDelegate: AnyObject {
    func didSelectImage(_ asset: PHAsset)
}

class PhotoGalleryViewController: UIViewController {
    
    weak var delegate: PhotoGalleryDelegate?
    
    @IBOutlet weak var albumsView: UIView!
    @IBOutlet weak var gallery: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private var allPhotos: PHFetchResult<PHAsset>?
    
    private var albums:[AlbumModel] = [AlbumModel]()
    private var galleryViewController : PhotosViewController?
    private var albumsViewController : AlbumsViewController?
    private var fetchOptions = PHFetchOptions()
    private var selectButton : UIBarButtonItem?
    
    let allPhotosString = NSLocalizedString("All Photos", comment:"")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        albumsView.isHidden = true
        title = allPhotosString
        updateNavigation()
        
        PHPhotoLibrary.shared().register(self)
        loadPhotos()
    }
    
    private func loadPhotos() {
        spinner.start()
        
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchAllPhotos()
        fetchAlbums()
        DispatchQueue.main.async { [weak self] in
            guard let albums = self?.albums else {return}
            self?.galleryViewController?.setPhotos(photos: self?.allPhotos)
            self?.albumsViewController?.setAlbums(albums: albums, allPhotos: self?.allPhotos)
        }
        
        spinner.stop()
    }
    
    public func updateNavigation() {
        configureTitleView()
        selectButton = UIBarButtonItem(title: NSLocalizedString("Select", comment: ""), style: .done, target: self, action: #selector(selectTapped))
        navigationItem.rightBarButtonItem = selectButton
    }
    
    private func configureTitleView(isDropDown: Bool = false) {
        navigationItem.title = title
        let titleView = UILabel()
        
        let attachment = NSTextAttachment()
        attachment.image = isDropDown ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
        let attachmentString = NSAttributedString(attachment: attachment)
        let attrTitle = NSMutableAttributedString(string: "\(title ?? allPhotosString) ")
        attrTitle.append(attachmentString)
        titleView.attributedText = attrTitle
        
        titleView.font = UIFont.boldSystemFont(ofSize: 17.0)
        let width = titleView.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).width
        titleView.frame = CGRect(origin:CGPoint.zero, size:CGSize(width: width, height: 500))
        navigationItem.titleView = titleView
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(PhotoGalleryViewController.titleWasTapped))
        titleView.isUserInteractionEnabled = true
        titleView.addGestureRecognizer(recognizer)
    }
    
    private func switchView() {
        let isGalleryHidden = gallery.isHidden
        gallery.isHidden = !isGalleryHidden
        albumsView.isHidden = isGalleryHidden
        navigationItem.rightBarButtonItem = gallery.isHidden ? nil : selectButton
    }
    
    @objc private func titleWasTapped() {
        guard albums.count > 0 else {return}
        switchView()
        configureTitleView(isDropDown: !albumsView.isHidden)
    }
    
    @objc private func selectTapped() {
        guard let asset = galleryViewController?.selectedAsset else {return}
        delegate?.didSelectImage(asset)
        dismiss(animated: true, completion: nil)
    }
    
    func fetchAllPhotos() {
        allPhotos = PHAsset.fetchAssets(with: fetchOptions)
    }
    
    func fetchAlbums() {
        let options = PHFetchOptions()
        let userAlbums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: options)
        let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: options)
        
        smartAlbums.enumerateObjects{ (object: AnyObject!, count: Int, stop: UnsafeMutablePointer) in
            guard let asset = object as? PHAssetCollection else {return}
            self.addAssetToAlbums(asset: asset)
        }
        userAlbums.enumerateObjects{ (object: AnyObject!, count: Int, stop: UnsafeMutablePointer) in
            guard let asset = object as? PHAssetCollection else {return}
            self.addAssetToAlbums(asset: asset)
        }
    }
    
    private func addAssetToAlbums(asset: PHAssetCollection) {
        guard let album = asset.convertToAlbum() else {return}
        guard self.albums.filter({ $0.collection.localIdentifier == album.collection.localIdentifier}).isEmpty else {return}
        self.albums.append(album)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedGallery" {
            galleryViewController = segue.destination as? PhotosViewController
        } else if segue.identifier == "embedAlbums" {
            albumsViewController = segue.destination as? AlbumsViewController
            albumsViewController?.delegate = self
        }
    }
    
}

extension PhotoGalleryViewController : PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        loadPhotos()
    }
}

extension PhotoGalleryViewController : AlbumSelectionDelegate {
    func didSelectAlbum(_ album: AlbumModel?) {
        defer { switchView() }
        guard let album = album else {
            title = allPhotosString
            configureTitleView()
            galleryViewController?.setPhotos(photos: allPhotos)
            return
        }
        title = album.name
        configureTitleView()
        let photos = PHAsset.fetchAssets(in: album.collection, options: fetchOptions)
        galleryViewController?.setPhotos(photos: photos)
    }
    
}
