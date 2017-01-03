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

class EventsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let CellIdentifier = "EventsTableViewCellIdentifier"

    var events: [Event] = []
    
    var meetupAPI = MeetupAPI()
    
    var eventsTableView: UITableView = UITableView()
    
    override func loadView() {
        super.loadView()
        
        // initialize segmented control
        let items = ["Upcoming", "Past"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0

        // set the segmented control frame
        let frame = UIScreen.main.bounds
        // 10% of the height of the screen
        segmentedControl.frame = CGRect(x: frame.minX + 10, y: (self.navigationController?.navigationBar.frame.height)! + 10, width: frame.width - 50, height: frame.height * 0.05)

        // style segmented control (optional)
        // add later
        segmentedControl.layer.cornerRadius = 5.0  // Don't let background bleed
        segmentedControl.backgroundColor = UIColor.white
        segmentedControl.tintColor = MeetupRedColor
        
        // add target action method
        segmentedControl.addTarget(self, action: Selector(("fetchEvents:")), for: .valueChanged)
        
        self.view.addSubview(segmentedControl)

        // set events table view fram
        eventsTableView.frame = CGRect(x: frame.minX + 10, y: segmentedControl.frame.minY + segmentedControl.frame.height + 10, width: frame.width, height: frame.height - segmentedControl.frame.height - 20)

        self.view.addSubview(eventsTableView)
    }
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.title = "My Events"
        
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        
        eventsTableView.register(EventsTableViewCell.self, forCellReuseIdentifier: CellIdentifier)
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
                    self.eventsTableView.reloadData()
                case let .Failure(error):
                    print("Error fetching meetup events: \(error)")
                }
            }
        }
    }
    
    
    func getPastEvents()
    {
        print("\nPast Events segmented control was tapped!!!!!!")
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as! EventsTableViewCell

        let event = events[indexPath.row]
        
        cell.eventTitleLabel.text = event.title
        cell.eventDateLabel.text = String(event.date)

        return cell
    }

    
    // MARK: - Navigation

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if segue.identifier == "ShowEventDetailVCSegueIdentifier" {
//        
//            let eventDetailVC = segue.destination as! AddPhotosViewController
//            
//            if let selectedIndexPath = eventsTableView.indexPathForSelectedRow?.row {
//            
//                let event = self.events[selectedIndexPath]
//                eventDetailVC.event = event
//            }
//        }
//    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let eventDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "AddPhotosViewController")
            as? AddPhotosViewController
        
        if let selectedIndexPath = eventsTableView.indexPathForSelectedRow?.row {
            
            let event = self.events[selectedIndexPath]
            eventDetailVC?.event = event
        }
       
        self.navigationController?.pushViewController(eventDetailVC!, animated: true)
    }
}
