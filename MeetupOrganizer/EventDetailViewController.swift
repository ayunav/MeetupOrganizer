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

    var meetupAPIManager = MeetupAPI()
    
    let client = Client()
    
    var activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0))
    
    
//    private func addActivityIndicatorView() {
//        let cols = 4
//        let cellWidth = Int(self.view.frame.width / CGFloat(cols))
//        let xCenter = Int(view.frame.width / 2)
//        let yCenter = Int(view.frame.height / 2)
//        let frame = CGRect(x: xCenter, y: yCenter, width: cellWidth, height: cellWidth)
//        //        let meetupRedColor = // add later TODO
//        
//        self.activityIndicatorView = NVActivityIndicatorView(frame: frame, type: .ballGridPulse, color: UIColor.red, padding: 0)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        let cols = 4
//        let cellWidth = Int(view.frame.width / CGFloat(cols))
//        let xCenter = Int(view.frame.width / 2)
//        let yCenter = Int(view.frame.height / 2)
//        let frame = CGRect(x: xCenter, y: yCenter, width: cellWidth, height: cellWidth)
//        //        let meetupRedColor = // add later TODO
//        
//        self.activityIndicatorView = NVActivityIndicatorView(frame: frame, type: .ballGridPulse, color: UIColor.red, padding: 0)
//        
//        super.init(coder: aDecoder)
//    }
    
    
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoGalleryCollectionView.dataSource = photoGalleryDataSource
        photoGalleryCollectionView.delegate = self
    }

    
    // MARK: - Actions
    
    @IBAction func addPhotosButtonTapped(_ sender: UIButton)
    {
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
                    let cols = 4
                    let cellWidth = Int(self.view.frame.width / CGFloat(cols))
                    let xCenter = Int(self.view.frame.width / 2)
                    let x = Int(xCenter - cellWidth / 2)
                    let yCenter = Int(self.view.frame.height / 2)
                    let y = Int(yCenter - cellWidth / 2)
                    let frame = CGRect(x: x, y: y, width: cellWidth, height: cellWidth)
                    let meetupRedColor = UIColor(red:0.93, green:0.11, blue:0.25, alpha:1.0) // HEX# ed1c40 http://uicolor.xyz/ this is amazing! :)
                    
                    self.activityIndicatorView = NVActivityIndicatorView(frame: frame, type: .ballGridPulse, color: meetupRedColor, padding: 0)
                    self.view.addSubview(self.activityIndicatorView)
                    self.activityIndicatorView.startAnimating()
                }
                
                self.requestOptions.isSynchronous = true
                
                for asset in assets {
                    self.imageManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.default, options: self.requestOptions, resultHandler: { (image, properties) in
                        
                        guard let _image = image else { return }
                        
                        self.client.uploadImageData(image: _image, groupName: "iOSoho", eventID: "233132048", completion: { (photosResult) in
                            OperationQueue.main.addOperation {
                                
                                switch photosResult {
                                case .Success:
                                    self.activityIndicatorView.stopAnimating()
                                    self.photoGalleryDataSource.assets = assets
                                    self.photoGalleryCollectionView.reloadSections(NSIndexSet(index: 0) as IndexSet)
                                case let .Failure(error):
                                    print("Error fetching recent photos: \(error)")
                                }
                            }
                        })
                    })
                }
        }, completion: nil)
    }
    
    
}

//protocol PreparedUploadDelegate {
//    func preparedUpload(preparedUpload: PreparedUpload, didStartLoadingCellAtIndexPath: IndexPath)
//    func preparedUpload(preparedUpload: PreparedUpload, didFinishLoadingCellAtIndexPath: IndexPath)
//    // TODO error handling delegate method
//}
//
//struct PreparedUpload {
//    func imageAtIndexPath(indexPath: IndexPath) -> UIImage? {
//        return nil // TODO
//    }
//    
//    var delegate: PreparedUploadDelegate?
//    
//    let assets: [PHAsset]
//    init(assets: [PHAsset]) {
//        self.assets = assets
//        for (i, asset) in assets.enumerated() {
//            self.delegate?.preparedUpload(preparedUpload: self, didStartLoadingCellAtIndexPath: IndexPath(row: i, section: 0)
//            self.imageManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.default, options: self.requestOptions, resultHandler: { (image, properties) in
//                
//                guard let _image = image else { return }
//                // 45 sec request duration, very long
//                self.meetupAPIManager.uploadImageData(image: _image, groupName: "iOSoho", eventID: "232809656") { (photosResult) -> Void in // need a closure here, move collection view code in here, based on the result of the closure
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
//                }
//    }
//}
