//
//  DateFormatter.swift
//  MeetupOrganizer
//
//  Created by Ayuna NYC on 1/8/17.
//  Copyright © 2017 Ayuna NYC. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let shortDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        return dateFormatter
    }()
    
    
    static let twelveHourTimeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter
    }()
    
    
    // Meetup API: time - UTC start time of the event, in milliseconds since epoch
    
    func dateAndTimeFrom(time: Int) -> (String, String)
    {
        let seconds = TimeInterval(Double(time))/1000
        let date = Date(timeIntervalSince1970: seconds)
        
        let eventDate = DateFormatter.shortDateFormatter.string(from: date)
        let eventTime = DateFormatter.twelveHourTimeFormatter.string(from: date)
        
        return (eventDate, eventTime)
    }

}
