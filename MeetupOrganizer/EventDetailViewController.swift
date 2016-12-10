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
import Alamofire

class EventDetailViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var photoGalleryCollectionView: UICollectionView!
    let photoGalleryDataSource = PhotoGalleryDataSource()
    
    let manager = PHImageManager.default()
    let deliveryOptions = PHImageRequestOptionsDeliveryMode.opportunistic
    let requestOptions = PHImageRequestOptions()

    
    //var photos: [UIImage] = []
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

                                            self.requestOptions.isSynchronous = true
                                            
                                            self.manager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.default, options: self.requestOptions, resultHandler: { (image, properties) in
                                       
                                                guard let _image = image else { return }
                                                self.uploadDataFor(image: _image)
                                            })
        }, deselect: { (asset: PHAsset) -> Void in
            // User deselected an assets.
            // Do something, cancel upload?
        }, cancel: { (assets: [PHAsset]) -> Void in
            // User cancelled. And this where the assets currently selected.
        }, finish: { (assets: [PHAsset]) -> Void in
            // User finished with these assets
            self.photoGalleryDataSource.assets = assets

            // display spinners indicating progress/success in the gallery colView cells

            OperationQueue.main.addOperation
            {
                self.photoGalleryCollectionView.reloadSections(NSIndexSet(index: 0) as IndexSet)
            }

        }, completion: nil)
    }
    
    
    
    func uploadDataFor(image: UIImage)
    {
        let imageData = UIImageJPEGRepresentation(image, 80) // compression quality?
        
        let url = URL(string: "https://api.meetup.com/iOSoho/events/233132048/photos?key=4131436d16334b6c5f3c2b4630685a29") // gemma barlow event
        
        Alamofire.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imageData!, withName: "photo", fileName: "photo.jpeg", mimeType: "image/jpeg")
        },
            to: url!,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
        })
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
