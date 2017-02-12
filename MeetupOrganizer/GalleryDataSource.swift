//
//  GalleryDataSource.swift
//  MeetupOrganizer
//
//  Created by Ayuna NYC on 12/6/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import UIKit
import Photos


class GalleryDataSource: NSObject, UICollectionViewDataSource
{
    // MARK: - Properties
    
    fileprivate let CellIdentifier = "GalleryCollectionViewCellIdentifier"

    fileprivate let manager = PHImageManager.default()

    var assets: [PHAsset] = []
    
    
    // MARK: - Data Source Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if assets.count > 0 {
            return assets.count
        } else {
            return 21
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath) as! GalleryCollectionViewCell
        
        if assets.isEmpty == true {
            cell.galleryImageView.image = UIImage(named: PlaceholderImage.meetupLogoGray)
        } else {
            let asset = assets[indexPath.row]
            cell.asset = asset
        }
        
        return cell
    }
    
    
    
}
