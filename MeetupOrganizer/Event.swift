//
//  Event.swift
//  MeetupOrganizer
//
//  Created by Ayuna NYC on 12/8/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import UIKit

enum EventFields: String
{
    case Title = "name"
    case EventId = "id"
    case Date = "time"
    case Group = "group"
    case GroupUrlName = "urlname"
    case Venue = "venue"
}


class Event
{
    let date: Int
    let eventId: String
    let group: String
//    let time: String
    let title: String
    let venue: String
    
    init(title: String, date: Int, group: String, eventId: String, venue: String)
    {
        self.title = title
        self.date = date
        self.group = group
        self.eventId = eventId
        self.venue = venue
    }
    
    
    // class function
    static func eventFromJsonDict(json: [String: AnyObject]) -> Event?
    {
        guard let title = json[EventFields.Title.rawValue] as? String,
            let date = json[EventFields.Date.rawValue] as? Int,
            let eventId = json[EventFields.EventId.rawValue] as? String,
            let group = json[EventFields.Group.rawValue] as? [String: AnyObject],
            let groupName = group[EventFields.GroupUrlName.rawValue] as? String,
            let venue = json[EventFields.Venue.rawValue]?[EventFields.Title.rawValue] as? String else { return nil }
        
        return Event(title: title, date: date, group: groupName, eventId: eventId, venue: venue)
    }

    
}
