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
    let assets = PHAsset.fetchAssets(with: .image, options: nil)
    
    
    // MARK: - Data Source Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return assets.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath) as! PhotoGalleryCollectionViewCell
        
        let asset = assets[indexPath.row]
        
        cell.asset = asset

        return cell
    }
    
}
