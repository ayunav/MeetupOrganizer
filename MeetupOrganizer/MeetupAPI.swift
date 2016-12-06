//
//  MeetupAPI.swift
//  MeetupOrganizer
//
//  Created by Ayuna NYC on 11/29/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import Foundation

struct MeetupAPI
{
    private static let host = "https://api.meetup.com"
    private static let apiKey = "4131436d16334b6c5f3c2b4630685a29"
    private static let events = "/2/events"
    private static let member_id = "136388792"  // member_id
    private static let rsvp = "yes"  // rsvp
    private static let page = "15"  // results per page
    private static let status = "upcoming"  // past also? comma delimited?

    
    // MARK: - Upload Photos 
    
    // http://www.meetup.com/meetup_api/docs/:urlname/events/:event_id/photos/#upload
    
    // POST /:urlname/events/:event_id/photos
    
    // url request: baseURLString + /iOSoho/events/235269311/photos
    
    // Host: api.meetup.com

    // A valid path parameter value for :urlname and :event_id is required
    
    // Maria Perez at Prolific event -> urlname: iOSoho event_id: 235269311
    
    private static let uploadPhotosRequestURL = "https://api.meetup.com/iOSoho/events/235269311/photos" // to Maria Perez at Prolific event

    
    func uploadPhotosURL() {
        // construct url with headers and api key 
        
        // Authentication credentials should be omitted from the request body and be sent via HTTP Authorization header or as query string parameters
    }
    
    func uploadPhotos() {
        // session 
        // upload task
        // send multi-form data 
        
        
        
    }
    
    
    /* This method expects an HTTP POST containing a Content-Type of multipart/form-data. Only the photo parameter, which represents the photo being uploaded, is required.
     
     Uploaded photos are fed into a separate photo staging process and may not be immediately available for display. To receive responses for photos that are immediately displayable, send the await request parameter with a value of true.
     
     A maximum of 500 photos are allowed for a given event.
     
     Authentication credentials should be omitted from the request body and be sent via HTTP Authorization header or as query string parameters
     
     */

    
    
    

    // events for a member
    let requestURLString = "https://api.meetup.com/2/events?member_id=136388792&offset=0&format=json&limited_events=False&rsvp=yes&photo-host=public&page=20&fields=photo_count%2C+photo_sample&order=time&status=past&desc=true&sig_id=136388792&sig=5bc8b8547ee90e05ff7647d0ddff569156260edd"
    
    // get authenticated member id
    // pull events of an authenticated member -> events array 
    // dispaly events 
    // event detail vc 
    // upload photos
    
    
    // to get events photos 
    
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
    
    
    // POST PHOTOS POST /:urlname/events/:event_id/photos

    
    
    

    
    // construct URL to make API requests 
    
    // validate JSON response
    
    // pass to the Store to convert into Meetup objects ? 
    // OR convert into meetup projects , pass to the store the array of objects if validation is successful
    
}
