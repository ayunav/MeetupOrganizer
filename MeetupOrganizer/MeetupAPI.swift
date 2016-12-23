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
    case Success([Event])
    case Failure(Error)
}


struct MeetupAPI {
    
    // make the API Call with the URL from API Manager class 
    // let api manager validate json repsonse, get array of objects from the API manager
    // pass to tvc to display in completion closure 

    var meetupRouter = MeetupRouter()
    
    
    mutating func uploadImageData(image: UIImage, groupName: String, eventID: String, completion: @escaping (PhotosResult) -> Void)
    {
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        
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
                        completion(.Success())
                        debugPrint(response)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
        })
    }
    
    
    
    mutating func getEvents(completion: @escaping (EventsResult) -> Void) {

        let url = meetupRouter.getMyEventsURL()
        
        Alamofire.request(url).responseJSON(completionHandler: { response in
            
            guard let validResponse = response.result.value as? [[String : AnyObject]] else { return }
//            print("JSON: \(validResponse)")
            
            
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
                completion(EventsResult.Success(events))
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
        return EventsResult.Success(events)
    }


}
