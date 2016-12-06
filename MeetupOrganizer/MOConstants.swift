//
//  MOConstants.swift
//  MeetupOrganizer
//
//  Created by Ayuna NYC on 12/6/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import Foundation

enum Method: String {
    case Books = "/books"
    case DeleteAll = "/clean"
}

struct MOConstants
{
    private static let meetupAPIHostURL = "https://api.meetup.com" // maybe shouldn't be private (?) if used elsewhere
    private static let apiKey = "4131436d16334b6c5f3c2b4630685a29"
    //private static let events = "/2/events"
    private static let member_id = "136388792"  // member_id
    private static let rsvp = "yes"  // rsvp
    private static let page = "15"  // results per page
    private static let status = "upcoming"  // past also? comma delimited?

    // ? need? can just use a constant
    private static func baseURL() -> String {
        return MOConstants.meetupAPIHostURL
    }    
}
