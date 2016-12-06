//
//  PhotoGalleryDataSource.swift
//  MeetupOrganizer
//
//  Created by Ayuna NYC on 12/6/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import UIKit

class PhotoGalleryDataSource: NSObject, UICollectionViewDataSource
{
    // MARK: - Properties
    
    private let CellIdentifier = "GalleryCollectionViewCellIdentifier"
    
    let meetup = Meetup(name: "iOSoho")
//    let photos = meetup.photos // what object?
    
    // MARK: - Data Source Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
//        return photos.count
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath) as! PhotoCollectionViewCell
        
//        let photo = photos[indexPath.row]
//        cell.updateWithImage(image: photo.image)
        
        return cell
    }
}
