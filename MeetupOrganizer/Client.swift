//
//  Client.swift
//  MeetupOrganizer
//
//  Created by Ayuna NYC on 11/29/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import UIKit
import Alamofire

class Client
{
    
    // make the API Call with the URL from API Manager class 
    // let api manager validate json repsonse, get array of objects from the API manager
    // pass to tvc to display in completion closure 


    var meetupAPI = MeetupAPI() // do i need a property here? struct vs class ?
    
    
    func uploadImageData(image: UIImage, groupName: String, eventID: String, completion: @escaping (PhotosResult) -> Void) // ? // add a completion block parameter
    {
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        
        guard let url = meetupAPI.uploadPhotosURLWithComponents(groupName: groupName, eventID: eventID) else { return }
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imageData!, withName: "photo", fileName: "photo.jpeg", mimeType: "image/jpeg")
            },
            to: url,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                            // pass completion to eventdetailvc ,
                            completion(.Success())
                            debugPrint(response)
                        }
                    case .failure(let encodingError):
                        print(encodingError)
                    }
            }
        )
    }
    
    
    func getEvents()
    {
        let url = meetupAPI.getEventsURL()
        
        Alamofire.request(url).responseJSON(completionHandler: { response in
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        })
    }
    
    
    


}
