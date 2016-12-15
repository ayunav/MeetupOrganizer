//
//  Event.swift
//  MeetupOrganizer
//
//  Created by Ayuna NYC on 12/8/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import UIKit

class Event
{
    let title: String
    let group: String
    let date: String
    let eventId: String
    
    
    init(title: String, date: String, group: String, eventId: String)
    {
        self.title = title
        self.date = date
        self.group = group
        self.eventId = eventId
    }
}
