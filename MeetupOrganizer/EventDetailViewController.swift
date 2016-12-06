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
    
    // var photos - what type?
    
    private static let uploadPhotosRequestURL = "https://api.meetup.com/iOSoho/events/235269311/photos" // to Maria Perez at Prolific event

    let photoGalleryDataSource = PhotoGalleryDataSource()

    

    override func viewDidLoad() {
        super.viewDidLoad()

        photoGalleryCollectionView.dataSource = photoGalleryDataSource
        photoGalleryCollectionView.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Actions 
    
    @IBAction func addPhotosButtonTapped(_ sender: UIButton)
    {
        let imagePickerVC = BSImagePickerViewController()

        // start uiimagepicker view controller
        // pick photos to upload

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
            
            
            
            
            
        }, completion:
            
            // display photos in the gallery colView w/spinners indicating success
            
            nil)
        
        
        
    }
    

    func populatePhotoGalleryCollectionView() {
        // should collection view have a separate data source class? 
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
