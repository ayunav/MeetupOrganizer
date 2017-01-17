//
//  AddPhotosViewController.swift
//  MeetupOrganizer
//
//  Created by Ayuna NYC on 11/29/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos
import NVActivityIndicatorView


class AddPhotosViewController: UIViewController, UICollectionViewDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak private var addPhotosButton: UIButton!
    @IBOutlet weak private var photoGalleryCollectionView: UICollectionView!
    
    let photoGalleryDataSource = PhotoGalleryDataSource()
    
    let imageManager = PHImageManager.default()
    let deliveryOptions = PHImageRequestOptionsDeliveryMode.opportunistic
    let requestOptions = PHImageRequestOptions()

    var meetupRouter = MeetupRouter()
    var meetupAPI = MeetupAPI()

    var event: Event?
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoGalleryCollectionView.dataSource = photoGalleryDataSource
        photoGalleryCollectionView.delegate = self
        
        if let event = event {
            navigationItem.title = event.name
        }
    }


    
    // TODO: - This method is a monstrosity. Need to rewrite it for clarity, separate into single responsibility methods.
    
    // MARK: - Upload Photos
    
    @IBAction func addPhotosButtonTapped(_ sender: UIButton) {
        
        let imagePickerVC = BSImagePickerViewController()
        
        bs_presentImagePickerController(
            imagePickerVC,
            animated: true,
            select:   { (asset: PHAsset) -> Void in },
            deselect: { (asset: PHAsset) -> Void in },
            cancel:   { (assets: [PHAsset]) -> Void in },
            finish:   { (assets: [PHAsset]) -> Void in
            
                DispatchQueue.main.async {
                    ActivityIndicatorView.sharedInstance.showActivityIndicatorInView(view: self.view)
                }
                
                
                self.requestOptions.isSynchronous = true
                
                
                for asset in assets {
                    
                    self.imageManager.requestImage(
                        for: asset,
                        targetSize:  PHImageManagerMaximumSize,
                        contentMode: PHImageContentMode.default,
                        options:     self.requestOptions,
                        resultHandler: { (image, properties) in
                        
                            
                        guard let _image  = image,
                            let groupName = self.event?.group,
                            let _eventId  = self.event?.eventId
                            else { return }
                    
                            
                        self.meetupAPI.uploadImageData(
                            image: _image,
                            groupName: groupName,
                            eventId: _eventId,
                            completion: { (photosResult) in
                                
                                DispatchQueue.main.async {
                                    switch photosResult {
                                    case .success:
                                        ActivityIndicatorView.sharedInstance.hideActivityIndicator()
                                        self.photoGalleryDataSource.assets = assets
                                        self.photoGalleryCollectionView.reloadSections(NSIndexSet(index: 0) as IndexSet)
                                    case let .failure(error):
                                        print("Error uploading photos to the meetup event: \(error)")
                                    }
                                }
                        })
                    })
                }
        },
            completion: nil)
    }
    
    
    
    
}
