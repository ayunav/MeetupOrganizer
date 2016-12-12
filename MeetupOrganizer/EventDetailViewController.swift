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


// display placeholder image in the gallery collection view? 

class EventDetailViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var photoGalleryCollectionView: UICollectionView!
    let photoGalleryDataSource = PhotoGalleryDataSource()
    
    let imageManager = PHImageManager.default()
    let deliveryOptions = PHImageRequestOptionsDeliveryMode.opportunistic
    let requestOptions = PHImageRequestOptions()

    var meetupAPIManager = MeetupAPI()
    
    
//    var photos: [UIImage] = []
    //let meetup = Meetup(name: "iOSoho")
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad()
    {
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
        }, finish: { (assets: [PHAsset]) -> Void in
            
            // 1. the col view will display selected photos, 
            // change cells' alpha to opaque,
            // add spinning activity indicators indicating upload progress
            
            // 2. if there's a problem with upload, display a user facing error message
            // 3. when upload is complete & successful (json response came back), stop & hide activity indicators, change cells' aipha to clear
            
            self.requestOptions.isSynchronous = true
            for asset in assets {
                self.imageManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.default, options: self.requestOptions, resultHandler: { (image, properties) in
                    
                    guard let _image = image else { return }
                    self.meetupAPIManager.uploadImageData(image: _image, groupName: "iOSoho", eventID: "232809656")
                    // 45 sec request duration, very long
                })
            }
            
            
            self.photoGalleryDataSource.assets = assets
            
            // display spinners indicating progress/success in the gallery colView cells
            
            OperationQueue.main.addOperation
            {
                self.photoGalleryCollectionView.reloadSections(NSIndexSet(index: 0) as IndexSet)
            }
        }, completion: nil)
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
