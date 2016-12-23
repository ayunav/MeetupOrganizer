//
//  EventDetailViewController.swift
//  MeetupOrganizer
//
//  Created by Ayuna NYC on 11/29/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos
import NVActivityIndicatorView



// display placeholder image in the gallery collection view? 

class EventDetailViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var addPhotosButton: UIButton!
    
    @IBOutlet weak var photoGalleryCollectionView: UICollectionView!
    let photoGalleryDataSource = PhotoGalleryDataSource()
    
    let imageManager = PHImageManager.default()
    let deliveryOptions = PHImageRequestOptionsDeliveryMode.opportunistic
    let requestOptions = PHImageRequestOptions()

    var meetupRouter = MeetupRouter()
    
    var meetupAPI = MeetupAPI()

    var event: Event? // how to initialize properties on VC?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoGalleryCollectionView.dataSource = photoGalleryDataSource
        photoGalleryCollectionView.delegate = self
        
        // need to figure out how to kick off request access to photos on addPhotosButtonTapped, not on the view did load. Moving this ^^^ (datasource and delegate to addPhotosButtonTapped) doesn't affect it
        
        if let event = event {
            navigationItem.title = event.title
        }
    }

    
    // MARK: - Actions
    
    @IBAction func addPhotosButtonTapped(_ sender: UIButton) {
        
        // how to prompt request access to photos on specific action not when this screen opens
        
        let imagePickerVC = BSImagePickerViewController()
        
        bs_presentImagePickerController(imagePickerVC,
                                        animated: true,
                                        select: { (asset: PHAsset) -> Void in
                                            // User selected an asset.
                                            // Do something with it, start upload perhaps?
        }, deselect: { (asset: PHAsset) -> Void in
            // User deselected an assets.
            // Do something, cancel upload?
        }, cancel: { (assets: [PHAsset]) -> Void in
            // User cancelled. And this where the assets currently selected.
        }, finish:
            { (assets: [PHAsset]) -> Void in
                
                // 1. the col view will display selected photos,
                // change cells' alpha to opaque,
                // add spinning activity indicators indicating upload progress
                // 2. if there's a problem with upload, display a user facing error message
                // 3. when upload is complete & successful (json response came back), stop & hide activity indicators, change cells' aipha to clear
                
                
                OperationQueue.main.addOperation {
                    UIActivityIndicatorViewUtils.sharedInstance.showActivityIndicatorInView(view: self.view)
                }
                
                self.requestOptions.isSynchronous = true
                
                for asset in assets {
                    self.imageManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.default, options: self.requestOptions, resultHandler: { (image, properties) in
                        
                        guard let _image = image, let groupName = self.event?.group, let _eventId = self.event?.eventId else {
                            return
                        }
                    
                        self.meetupAPI.uploadImageData(image: _image, groupName: groupName, eventID: _eventId, completion: { (photosResult) in
                            OperationQueue.main.addOperation {
                                
                                switch photosResult {
                                case .Success:
                                    UIActivityIndicatorViewUtils.sharedInstance.hideActivityIndicatorInView()
                                    self.photoGalleryDataSource.assets = assets
                                    self.photoGalleryCollectionView.reloadSections(NSIndexSet(index: 0) as IndexSet)
                                case let .Failure(error):
                                    print("Error uploading photos to the meetup event: \(error)")
                                }
                            }
                        })
                    })
                }
        }, completion: nil)
    }
    
    
}

protocol PreparedUploadDelegate {
    func preparedUpload(preparedUpload: PreparedUpload, didStartLoadingCellAtIndexPath: IndexPath)
    func preparedUpload(preparedUpload: PreparedUpload, didFinishLoadingCellAtIndexPath: IndexPath)
    // TODO error handling delegate method
}

struct PreparedUpload {
    func imageAtIndexPath(indexPath: IndexPath) -> UIImage? {
        return nil // TODO
    }
    
    var delegate: PreparedUploadDelegate?

    let assets: [PHAsset]

    init(assets: [PHAsset])
    {
        self.assets = assets
        for (i, asset) in assets.enumerated()
        {
            self.delegate?.preparedUpload(preparedUpload: self, didStartLoadingCellAtIndexPath: IndexPath(row: i, section: 0))
            
            
            
//            self.imageManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.default, options: self.requestOptions, resultHandler: { (image, properties) in
//                
//                guard let _image = image else { return }
//                self.meetupRouter.uploadImageData(image: _image, groupName: "iOSoho", eventID: "232809656") { (photosResult) -> Void in // need a closure here, move collection view code in here, based on the result of the closure
//                    
//                    
//                    OperationQueue.main.addOperation {
//                        switch photosResult {
//                        case let .Success(photos):
//                            self.photoDataSource.photos = photos
//                            self.delegate?.preparedUpload(preparedUpload: self, didFinishLoadingCellAtIndexPath: IndexPath(row: i, section: 0)
//                            // inside the completion
//                            // spinning indicator - stop animating if success
//                            
//                        }
//                    }
        }
    }
}
