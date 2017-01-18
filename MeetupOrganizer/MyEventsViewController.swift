//
//  MyEventsViewController.swift
//  MeetupOrganizer
//
//  Created by Ayuna NYC on 11/29/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import UIKit

class MyEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let CellIdentifier = "EventsTableViewCellIdentifier"

    var events: [Event] = []
    
    var meetupAPI = MeetupAPI()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var eventsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "My Events"
        
        setupTableView()
        fetchEvents(sender: segmentedControl)
    }

    
    func setupTableView() {
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        eventsTableView.register(UINib(nibName: "EventsTableViewCell", bundle: nil), forCellReuseIdentifier: CellIdentifier)
     
        eventsTableView.rowHeight = UITableViewAutomaticDimension
        eventsTableView.estimatedRowHeight = 140
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func fetchEvents(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            getUpcomingEvents()
        case 1:
            getPastEvents()
        default:
            break;
        }
    }
    
    
    func getUpcomingEvents() {
        
        meetupAPI.getUpcomingEvents() { (eventsResult) -> Void in
            DispatchQueue.main.async {
                switch eventsResult {
                case let .success(_events):
                    self.events = _events
                    self.eventsTableView.reloadData()
                case let .failure(error):
                    print("Error fetching meetup events: \(error)")
                }
            }
        }
    }
    
    
    func getPastEvents() {
        
        meetupAPI.getPastEvents() { (eventsResult) -> Void in
            DispatchQueue.main.async {
                switch eventsResult {
                case let .success(_events):
                    self.events = _events
                    self.eventsTableView.reloadData()
                case let .failure(error):
                    print("Error fetching meetup events: \(error)")
                }
            }
        }
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
        
        cell.eventDateLabel.text = event.date
        cell.groupNameLabel.text = event.group
        cell.eventTitleLabel.text = event.name
        cell.eventTimeLabel.text = event.time
        cell.venueLabel.text = event.venue

        return cell
    }

    
    // MARK: - Navigation
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let eventDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "AddPhotosViewController")
            as? AddPhotosViewController
        
        if let selectedIndexPath = eventsTableView.indexPathForSelectedRow?.row {
            
            let event = self.events[selectedIndexPath]
            eventDetailVC?.event = event
        }
        
        self.navigationController?.pushViewController(eventDetailVC!, animated: true)
    }

}
