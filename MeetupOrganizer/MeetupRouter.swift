//
//  MeetupRouter.swift
//  MeetupOrganizer
//
//  Created by Ayuna NYC on 11/29/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import UIKit

// construct URL to make API requests
// validate JSON response
// pass to the Store to convert into Meetup objects ?
// OR convert into meetup projects , pass to the store the array of objects if validation is successful

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
        let apiKey = URLQueryItem(name: "key", value: MeetupApiKey)
        urlComponents.queryItems = [apiKey]
    }
    

    // MARK: - Upload Photos URL
    
    // Documentation: http://www.meetup.com/meetup_api/docs/:urlname/events/:event_id/photos/#upload

    mutating func uploadPhotosURLWithComponents(groupName: String, eventID: String) -> URL {
        
        urlComponents.path = "/\(groupName)/events/\(eventID)/photos"
        return urlComponents.url!
    }

    
    // MARK: - My Events URL
    
    // Documentation: https://www.meetup.com/meetup_api/docs/self/events/
        
    mutating func getUpcomingEventsURL() -> URL {
        
        urlComponents.path = "/self/events"
        
        let accessToken = UserDefaults.standard.object(forKey: MeetupAccessToken) as! String
        
        let params = [
            "access_token" : accessToken,
            "scroll" : QueryItem.Scroll.rawValue,
            "page" : QueryItem.Page.rawValue,
            "rsvp" : QueryItem.RSVP.rawValue,
            "status" : QueryItem.StatusUpcoming.rawValue
        ]
        
        for (key, value) in params {
            let queryItem = URLQueryItem(name: key, value: value)
            urlComponents.queryItems?.append(queryItem)
        }

        return urlComponents.url!
    }
    
    mutating func getPastEventsURL() -> URL {
        
        urlComponents.path = "/self/events"
        
        let accessToken = UserDefaults.standard.object(forKey: MeetupAccessToken) as! String
        
        let params = [
            "access_token" : accessToken,
            "scroll" : QueryItem.Scroll.rawValue,
            "page" : QueryItem.Page.rawValue,
            "rsvp" : QueryItem.RSVP.rawValue,
            "status" : QueryItem.StatusPast.rawValue
        ]
        
        for (key, value) in params {
            let queryItem = URLQueryItem(name: key, value: value)
            urlComponents.queryItems?.append(queryItem)
        }
        
        return urlComponents.url!
    }
}
