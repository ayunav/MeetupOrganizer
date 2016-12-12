//
//  User.swift
//  MeetupOrganizer
//
//  Created by Ayuna NYC on 12/8/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import Foundation

class User
{
    var id: String
    
    init(id: String)
    {
        self.id = id
    }
    
    var meetup: Meetup?
}
