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
    
    // https://api.meetup.com/self/events?access_token=2cda10581aa8515ff6395cebcb01572b&photo-host=public&scroll=recent_past&page=20&rsvp=yes&status=upcoming // the right link upcoming events for myself
    
    mutating func getMyEventsURL() -> URL {
        
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
    

    
    // GET Event's Photos URL 
    let getEventsPhotosURLRequest = "https://api.meetup.com/iOSoho/events/235269311/photos?&sign=true&photo-host=public&page=20&fields=self"
    
    // returns an array of dictionaries
    // each dictionary contains: https://api.meetup.com/iOSoho/events/235269311/photos?photo-host=public&page=20&sig_id=136388792&fields=self&sig=cab57496b1a0feac30138e37029d9f5e8ea3a3e2
    //        / id: 456316179,
    //    highres_link: "http://photos1.meetupstatic.com/photos/event/3/f/3/3/highres_456316179.jpeg",
    //    photo_link: "http://photos1.meetupstatic.com/photos/event/3/f/3/3/600_456316179.jpeg",
    //    thumb_link: "http://photos1.meetupstatic.com/photos/event/3/f/3/3/thumb_456316179.jpeg",
    //    type: "event",
    //    base_url: "http://photos1.meetupstatic.com",
    //    link: "https://www.meetup.com/iOSoho/photos/27444613/456316179/", and other params
}
