//
//  Meetup.swift
//  MeetupOrganizer
//
//  Created by Ayuna NYC on 11/29/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import UIKit

class Meetup
{
    let urlName: String
    
    init(name: String)
    {
        self.urlName = name
    }
        
    var events: [Event]?
    
    weak var user: User? 
}
