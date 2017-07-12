//
//  ViewController.swift
//  ResidenceManager
//
//  Created by Ginpei on 2017-07-12.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var eventTableView: UITableView!
    
    var events = [HouseEvent]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // prepare data
        prepareEvents()
        
        // prepare UIs
        eventTableView.dataSource = self
    }
    
    func prepareEvents() {
        let store = HouseEventStore()
        store.fetchAll() { (result) in
            self.events.removeAll()
            
            switch result {
            case let .success(events):
                self.events.append(contentsOf: events)
                
            case let .failure(error):
                print("ERROR at prepareEvents", error)
            }
            
            self.eventTableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = events[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeEventTableViewCell.identifier, for: indexPath) as! HomeEventTableViewCell
        cell.event = event
        
        return cell
    }
}
