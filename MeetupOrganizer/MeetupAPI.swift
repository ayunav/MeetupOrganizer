//
//  MeetupAPI.swift
//  MeetupOrganizer
//
//  Created by Ayuna NYC on 11/29/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import UIKit
import Alamofire


enum EventsResult {
    case success([Event])
    case failure(Error)
}


enum PhotosResult {
    case success()
    case failure(Error)
}


struct MeetupAPI {
    
    var meetupRouter = MeetupRouter()
    
    
    mutating func uploadImageData(image: UIImage, groupName: String, eventId: String, completion: @escaping (PhotosResult) -> Void) {
     
        let url = meetupRouter.uploadPhotosURLWithComponents(groupName: groupName, eventId: eventId)
        
        let imageData = UIImageJPEGRepresentation(image, 0.8)
        
        
        Alamofire.upload(multipartFormData: { multipartFormData in
           
            multipartFormData.append(imageData!, withName: "photo", fileName: "photo.jpeg", mimeType: "image/jpeg")},

                         to: url,
                         
                         encodingCompletion: { encodingResult in
                            
                            switch encodingResult {
                                
                            case .success(let upload, _, _):
                                upload.responseJSON { response in
                                    completion(.success())
                                }
                            case .failure(let encodingError):
                                print(encodingError)
                            }
        })
    }
   
    
    mutating func getUpcomingEvents(completion: @escaping (EventsResult) -> Void) {

        let url = meetupRouter.myUpcomingEventsURL()
        
        
        Alamofire.request(url).responseJSON(completionHandler: { response in
            
            guard let validResponse = response.result.value as? [[String : AnyObject]] else { return }

            let events = validResponse.flatMap(Event.eventFromJsonDict)
            
            if (events.count > 0) {
                completion(EventsResult.success(events))
            } else {
//                completion(EventsResult.Failure(nil))
            }
        })
        
    }

    
    mutating func getPastEvents(completion: @escaping (EventsResult) -> Void) {
        
        let url = meetupRouter.myPastEventsURL()
          
        Alamofire.request(url).responseJSON(completionHandler: { response in
            
            guard let validResponse = response.result.value as? [[String : AnyObject]] else { return }

            let events = validResponse.flatMap(Event.eventFromJsonDict)
            
            if (events.count > 0) {
                completion(EventsResult.success(events))
            } else {
//                completion(EventsResult.Failure(nil))
            }
        })
        
    }
    
}
