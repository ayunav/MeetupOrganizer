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
    case eventId = "id"
    case group = "group"
    case groupUrlName = "urlname"
    case name = "name"
    case time = "time"
    case venue = "venue"
}


class Event
{
    let date: String
    let eventId: String
    let group: String
    let name: String
    let time: String
    let venue: String
    
    init(date: String, eventId: String, group: String, name: String, time: String, venue: String)
    {
        self.date = date
        self.eventId = eventId
        self.group = group
        self.name = name
        self.time = time
        self.venue = venue
    }
    
    
    private static let dateFormatter = DateFormatter()
    
    
    // class function
    static func eventFromJsonDict(json: [String: AnyObject]) -> Event?
    {
        guard let name = json[EventFields.name.rawValue] as? String,
            let time = json[EventFields.time.rawValue] as? Int,
            let eventId = json[EventFields.eventId.rawValue] as? String,
            let groupName = json[EventFields.group.rawValue]?[EventFields.groupUrlName.rawValue] as? String,
            let venue = json[EventFields.venue.rawValue]?[EventFields.name.rawValue] as? String
        else { return nil }

        let dateLabelString = dateFormatter.dateLabelStringFrom(time: time)
        let timeLabelString = dateFormatter.timeLabelStringFrom(time: time)
        
        return Event(date: dateLabelString, eventId: eventId, group: groupName, name: name, time: timeLabelString, venue: venue)
    }
    
}


// MARK: - Date Formatter

extension DateFormatter {

    // Meetup API - event time: UTC start time of the event, in milliseconds since the epoch
    
    static let dateLabelFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter
    }()
    
    
    static let timeLabelFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter
    }()

    
    func dateLabelStringFrom(time: Int) -> String {
        let epochTime = TimeInterval(Double(time))/1000
        let date = Date(timeIntervalSince1970: epochTime)
        return DateFormatter.dateLabelFormatter.string(from: date)
    }

    
    func timeLabelStringFrom(time: Int) -> String {
        let epochTime = TimeInterval(Double(time))/1000
        let date = Date(timeIntervalSince1970: epochTime)
        return DateFormatter.timeLabelFormatter.string(from: date)
    }

}
