//
//  EventListViewController.swift
//  ResidenceManager
//
//  Created by Ginpei on 2017-07-27.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class EventListViewController: UIViewController {
    @IBOutlet weak var eventTableView: UITableView!
    
    var delegate: EventListViewControllerDelegate?
    var events: [HouseEvent]!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination

        if let vc = destination as? EventDetailViewController {
            let indexPath = eventTableView.indexPathForSelectedRow!
            let event = events[indexPath.row]
            vc.event = event
        }
        else if let nav = destination as? UINavigationController, let vc = nav.viewControllers[0] as? EventEditViewController {
            vc.event = HouseEvent()
            vc.onSave = { (event) in
                self.events.append(event)
                self.eventTableView.reloadData()
                self.delegate?.eventListView(self, updatedEvents: self.events)
            }
        }
    }
}

extension EventListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = events[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier, for: indexPath)
        if let cell = cell as? EventTableViewCell {
            cell.event = event
        }
        
        return cell
    }
}

extension EventListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventTableView.deselectRow(at: indexPath, animated: true)
    }
}

protocol EventListViewControllerDelegate {
    func eventListView(_ eventListViewController: EventListViewController, updatedEvents events: [HouseEvent]) -> Void
}
