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


enum PhotosResult
{
    case success()
    case failure(Error)
}


struct MeetupAPI {
    
    // make the API Call with the URL from API Manager class 
    // let api manager validate json repsonse, get array of objects from the API manager
    // pass to tvc to display in completion closure 

    var meetupRouter = MeetupRouter()
    
    
    mutating func uploadImageData(image: UIImage, groupName: String, eventID: String, completion: @escaping (PhotosResult) -> Void)
    {
        let imageData = UIImageJPEGRepresentation(image, 0.9)
        
        let url = meetupRouter.uploadPhotosURLWithComponents(groupName: groupName, eventID: eventID)
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imageData!, withName: "photo", fileName: "photo.jpeg", mimeType: "image/jpeg")
        },
            to: url,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        // passing completion to EventDetailVC
                        completion(.success())
                        debugPrint(response)
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

            
            // pass EventsResult enum .Success
            
            //            let result = self.eventsFromJSON(eventsJSON: validResponse)
            let events = validResponse.flatMap(Event.eventFromJsonDict)
            //
            //        var events = [Event]()
            //
            //        for eventDict in eventsJSON {
            //            if let event = (json: eventDict) {
            //                events.append(event)
            //            }
            //
            //        }
            //            return
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

    
    func eventsFromJSON(eventsJSON: [[String : AnyObject]]) -> EventsResult {
        
        let events = eventsJSON.flatMap(Event.eventFromJsonDict)
        //
        //        var events = [Event]()
        //
        //        for eventDict in eventsJSON {
        //            if let event = (json: eventDict) {
        //                events.append(event)
        //            }
        //
        //        }
        return EventsResult.success(events)
    }


}
