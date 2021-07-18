//
//  AlbumsViewController.swift
//
//  Created by Allison Schwarz on 5/9/19.
//  Copyright © 2019 Allison Schwarz. All rights reserved.
//

import UIKit
import Photos

protocol AlbumSelectionDelegate {
    //returns nil if "All Photos" is selected
    func didSelectAlbum(_ album: AlbumModel?)
}

class AlbumsViewController: UITableViewController {
    
    var delegate : AlbumSelectionDelegate?
    
    private static let cellIdentifier = "AlbumViewCell"
    private static let allPhotosIndex = 0
    
    private var albums:[AlbumModel] = [AlbumModel]()
    private var allPhotos: PHFetchResult<PHAsset>?
    fileprivate var thumbnailSize: CGSize!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        let scale = UIScreen.main.scale
        thumbnailSize = CGSize(width: 20.0 * scale, height: 20.0 * scale)
    }
    
    func setAlbums(albums: [AlbumModel], allPhotos: PHFetchResult<PHAsset>?) {
        self.albums = albums
        self.allPhotos = allPhotos
        tableView.safeReload()
    }
    
    private func album(at indexPath: IndexPath) -> AlbumModel? {
        guard indexPath.row != 0 else {return nil}
        let index = indexPath.row - 1
        guard albums.count > index else {return nil}
        return albums[index]
    }
    
}

// UITableView Delegate methods
extension AlbumsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumsViewController.cellIdentifier, for: indexPath) as? AlbumViewCell
            else { return UITableViewCell() }
        guard indexPath.row != AlbumsViewController.allPhotosIndex else {
            cell.title.text = NSLocalizedString("All Photos", comment: "")
            cell.count.text = String(allPhotos?.count ?? 0)
            
            guard let asset = allPhotos?.firstObject else {return cell}
            cell.representedAssetIdentifier = asset.localIdentifier
            PhotoManager.shared.imageManager.requestImage(for: asset, targetSize: thumbnailSize, contentMode: .aspectFill, options: nil, resultHandler: { image, _ in
                if cell.representedAssetIdentifier == asset.localIdentifier {
                    cell.art.image = image
                }
            })
            return cell
        }
        guard let album = album(at: indexPath) else {return UITableViewCell()}
        cell.title.text = album.name
        cell.count.text = String(album.count)
        cell.art.image = album.thumbnail
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row != AlbumsViewController.allPhotosIndex else {
            delegate?.didSelectAlbum(nil)
            return
        }
        guard let album = album(at: indexPath) else {return}
        delegate?.didSelectAlbum(album)
    }
    
}

