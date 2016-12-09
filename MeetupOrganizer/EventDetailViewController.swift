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

class EventDetailViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var photoGalleryCollectionView: UICollectionView!
    let photoGalleryDataSource = PhotoGalleryDataSource()

    //var photos: [UIImage] = []
    //let meetup = Meetup(name: "iOSoho")
    private static let uploadPhotosRequestURL = "https://api.meetup.com/iOSoho/events/235269311/photos" // to Maria Perez at Prolific event

    
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

                                            // get photo multi part data
                                            // construct and start url request to post photos to meetup server, pass photo data to the request
        }, deselect: { (asset: PHAsset) -> Void in
            // User deselected an assets.
            // Do something, cancel upload?
        }, cancel: { (assets: [PHAsset]) -> Void in
            // User cancelled. And this where the assets currently selected.
        }, finish: { (assets: [PHAsset]) -> Void in
            // User finished with these assets
            
            // 1. Display photos in the photoGalleryCollectionView
            OperationQueue.main.addOperation
            {
                self.photoGalleryCollectionView.reloadSections(NSIndexSet(index: 0) as IndexSet)
            }

        }, completion:
            
            // display spinners indicating progress/success in the gallery colView cells
            
            nil)
        
        
        
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
