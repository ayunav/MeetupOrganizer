//
//  PhotoGalleryDataSource.swift
//  MeetupOrganizer
//
//  Created by Ayuna NYC on 12/6/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import UIKit
import Photos


class PhotoGalleryDataSource: NSObject, UICollectionViewDataSource
{
    // MARK: - Properties
    
    private let CellIdentifier = "PhotoGalleryCollectionViewCellIdentifier"

    let manager = PHImageManager.default()

    var assets: [PHAsset] = []
    
    
    
    // MARK: - Data Source Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if assets.count > 0 {
            return assets.count
        } else {
            return 21
        }
        
//        return assets.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath) as! PhotoGalleryCollectionViewCell
        
        if assets.isEmpty == true {
            cell.galleryImageView.image = UIImage(named: PlaceholderGray)
        } else {
            let asset = assets[indexPath.row]
            cell.asset = asset
        }
        
        return cell
    }
    
    
    
}
