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
    
    
    
    override func loadView() {
        super.loadView()
        
        // initialize segmented control
        let items = ["Upcoming", "Past"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        
        // set the frame 
        let frame = UIScreen.main.bounds
        // 10% of the height of the screen
        segmentedControl.frame = CGRect(x: frame.minX + 10, y: frame.minY + 50, width: frame.width - 50, height: frame.height * 0.1)
        
        // style segmented control (optional)
            // add later
        
        
        // add target action method 
        segmentedControl.addTarget(self, action: Selector(("fetchEvents:")), for: .valueChanged)
        
        self.view.addSubview(segmentedControl)
    }
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func fetchEvents(sender: UISegmentedControl)
    {
        switch sender.selectedSegmentIndex {
        case 1:
            getPastEvents()
        default:
            getUpcomingEvents()
        }
    }
    
    
    // for now
    func getUpcomingEvents()
    {
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
    
    
    func getPastEvents()
    {
        
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
