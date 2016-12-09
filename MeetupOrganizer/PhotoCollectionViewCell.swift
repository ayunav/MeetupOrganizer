//
//  PhotoGalleryCollectionViewCell.swift
//  MeetupOrganizer
//
//  Created by Ayuna NYC on 12/6/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import UIKit
import Photos

class PhotoGalleryCollectionViewCell: UICollectionViewCell
{
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    let manager = PHImageManager.default()
    let deliveryOptions = PHImageRequestOptionsDeliveryMode.opportunistic
    let requestOptions = PHImageRequestOptions()
    
    let thumbnailSize = CGSize(width: 100, height: 100)
    
    var asset: PHAsset?
    {
        didSet
        {
            if let _asset = asset
            {
                manager.requestImage(for: _asset, targetSize: thumbnailSize, contentMode: PHImageContentMode.aspectFill, options: requestOptions, resultHandler: requestResultHandler)
            }
        }
    }
    
    
    func requestResultHandler(image: UIImage?, properties: [AnyHashable: Any]?) -> Void
    {
        updateWithImage(image: image)
    }

    
    func updateWithImage(image: UIImage?)
    {
        if let imageToDisplay = image
        {
            spinner.stopAnimating()
            imageView.image = imageToDisplay
        } else {
            spinner.startAnimating()
            imageView.image = nil
        }
    }
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        updateWithImage(image: nil)
    }
    
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        
        updateWithImage(image: nil)
    }

    
}

