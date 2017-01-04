//
//  MeetupRouter.swift
//  MeetupOrganizer
//
//  Created by Ayuna NYC on 11/29/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import UIKit


enum PhotosResult
{
    case Success()
    case Failure(Error)
}


enum QueryItem: String
{
    case RSVP = "yes"  // rsvp
    case Page = "20"  // results per page
    case StatusUpcoming = "upcoming"
    case StatusPast = "past"
    case Scroll = "recent_past"    
}


struct MeetupRouter
{
    // MARK: - URL
    
    var urlComponents = URLComponents()
    
    init() {
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.meetup.com"
    }
    

    // MARK: - Upload Photos URL
    
    // Documentation: http://www.meetup.com/meetup_api/docs/:urlname/events/:event_id/photos/#upload

    mutating func uploadPhotosURLWithComponents(groupName: String, eventID: String) -> URL {
        
        urlComponents.path = "/\(groupName)/events/\(eventID)/photos"
        let apiKey = URLQueryItem(name: "key", value: MeetupApiKey)
        urlComponents.queryItems = [apiKey]

        return urlComponents.url!
    }

    
    // MARK: - My Events URL
    
    // Documentation: https://www.meetup.com/meetup_api/docs/self/events/
    
    private mutating func myEventsURL(parameters: [String: String]?) -> URL {
       
        urlComponents.path = "/self/events"
        
        let accessToken = UserDefaults.standard.object(forKey: MeetupAccessToken) as! String
        
        var queryItems = [URLQueryItem]()
        
        let baseParams = [
            "access_token" : accessToken,
            "scroll" : QueryItem.Scroll.rawValue,
            "page" : QueryItem.Page.rawValue,
            "rsvp" : QueryItem.RSVP.rawValue
        ]
        
        for (key, value) in baseParams {
            let queryItem = URLQueryItem(name: key, value: value)
            queryItems.append(queryItem)
        }
        
        if let extraParams = parameters {
            for (key, value) in extraParams {
                let queryItem = URLQueryItem(name: key, value: value)
                queryItems.append(queryItem)
            }
        }
        
        urlComponents.queryItems = queryItems
        
        return urlComponents.url!
    }
    
    
    mutating func myUpcomingEventsURL() -> URL
    {
        return myEventsURL(parameters: ["status": QueryItem.StatusUpcoming.rawValue])
    }
    
    
    mutating func myPastEventsURL() -> URL
    {
        return myEventsURL(parameters: ["status": QueryItem.StatusPast.rawValue])
    }
}
