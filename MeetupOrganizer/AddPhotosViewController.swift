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

    
    // MARK: - Actions
    
    @IBAction func addPhotosButtonTapped(_ sender: UIButton) {
        
        let imagePickerVC = BSImagePickerViewController()
        
        bs_presentImagePickerController(imagePickerVC,
                                        animated: true,
                                        select: { (asset: PHAsset) -> Void in
        }, deselect: { (asset: PHAsset) -> Void in
        }, cancel: { (assets: [PHAsset]) -> Void in
        }, finish:
            { (assets: [PHAsset]) -> Void in
                
                // 1. the col view will display selected photos,
                // change cells' alpha to opaque,
                // add spinning activity indicators indicating upload progress
                // 2. if there's a problem with upload, display a user facing error message
                // 3. when upload is complete & successful (json response came back), stop & hide activity indicators, change cells' aipha to clear

                DispatchQueue.main.async {
                    ActivityIndicatorView.sharedInstance.showActivityIndicatorInView(view: self.view)
                }
                
                self.requestOptions.isSynchronous = true
                
                for asset in assets {
                    self.imageManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.default, options: self.requestOptions, resultHandler: { (image, properties) in
                        
                        guard let _image = image, let groupName = self.event?.group, let _eventId = self.event?.eventId else {
                            return
                        }
                    
                        self.meetupAPI.uploadImageData(image: _image, groupName: groupName, eventId: _eventId, completion: { (photosResult) in
                            OperationQueue.main.addOperation {
                                
                                switch photosResult {
                                case .success:
                                    ActivityIndicatorView.sharedInstance.hideActivityIndicatorInView() // rename to hideActivityIndicator 
                                    self.photoGalleryDataSource.assets = assets
                                    self.photoGalleryCollectionView.reloadSections(NSIndexSet(index: 0) as IndexSet)
                                case let .failure(error):
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
//                self.meetupRouter.uploadImageData(image: _image, groupName: "iOSoho", eventId: "232809656") { (photosResult) -> Void in // need a closure here, move collection view code in here, based on the result of the closure
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
