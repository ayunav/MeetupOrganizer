//
//  EventsTableViewCell.swift
//  MeetupOrganizer
//
//  Created by Ayuna NYC on 12/16/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell
{
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    
    
    

    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
