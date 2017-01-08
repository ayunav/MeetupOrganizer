//
//  MeetupRouter.swift
//  MeetupOrganizer
//
//  Created by Ayuna NYC on 11/29/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import UIKit


enum QueryItem: String
{
    case rsvp = "yes"
    case page = "20" // number of results to return
    case statusUpcoming = "upcoming"
    case statusPast = "past"
    case scroll = "recent_past"
}


struct MeetupRouter
{
    // MARK: - URL Components
    
    var urlComponents = URLComponents()
    
    init() {
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.meetup.com"
    }
    

    // MARK: - Upload Photos URL
    
    // Documentation: http://www.meetup.com/meetup_api/docs/:urlname/events/:event_id/photos/#upload

    mutating func uploadPhotosURLWithComponents(groupName: String, eventId: String) -> URL {
        
        urlComponents.path = "/\(groupName)/events/\(eventId)/photos"
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
            "scroll" : QueryItem.scroll.rawValue,
            "page" : QueryItem.page.rawValue,
            "rsvp" : QueryItem.rsvp.rawValue
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
        return myEventsURL(parameters: ["status": QueryItem.statusUpcoming.rawValue])
    }
    
    
    mutating func myPastEventsURL() -> URL
    {
        return myEventsURL(parameters: ["status": QueryItem.statusPast.rawValue])
    }
}
