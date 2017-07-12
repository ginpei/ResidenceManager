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
        events.append(contentsOf: [
            HouseEvent(title: "BBQ at House 1"),
            HouseEvent(title: "BBQ at English Bay"),
            HouseEvent(title: "BBQ at Nanaimo Station"),
            ])
        
        // prepare UIs
        eventTableView.dataSource = self
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
