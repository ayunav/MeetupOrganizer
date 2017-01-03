//
//  EventsTableViewController.swift
//  MeetupOrganizer
//
//  Created by Ayuna NYC on 11/29/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//


// make request for user's meetups' current and upcoming events that a user has rsvp'ed YES to.
// Sort by date. Current is displayed first.

// v2: button for past events



import UIKit

class EventsTableViewController: UITableViewController {
    
    private let CellIdentifier = "EventsTableViewCellIdentifier"

    var events: [Event] = []
    
    var meetupAPI = MeetupAPI()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        meetupAPI.getEvents() { (eventsResult) -> Void in
            OperationQueue.main.addOperation {
                switch eventsResult {
                case let .Success(_events):
                    self.events = _events
                    self.tableView.reloadData()
                case let .Failure(error):
                    print("Error fetching meetup events: \(error)")
                }
            }
        }
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as! EventsTableViewCell

        let event = events[indexPath.row]
        
        cell.eventTitleLabel.text = event.title
        cell.eventDateLabel.text = String(event.date)

        return cell
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowEventDetailVCSegueIdentifier" {
        
            let eventDetailVC = segue.destination as! EventDetailViewController
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow?.row {
            
                let event = self.events[selectedIndexPath]
                eventDetailVC.event = event
            }
        }
    }
    
}
