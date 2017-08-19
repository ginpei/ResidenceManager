//
//  NewMessageTableViewController.swift
//  ResidenceManager
//
//  Created by Luis Alfredo Ramirez on 2017-08-15.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit
import Firebase

class NewMessageTableViewController: UITableViewController {
    
    let cellId = "cellId"
    let users = [RMUser]()
    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        cell.textLabel?.text = "Some Text"
        return cell
    }
    
    // TODO rename since this is NOT only fetching
    func fetchUser() {
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            if let values = snapshot.value as? [String: Any] {
                let user = RMUser(key: snapshot.key, values: values)
//                user.setValuesForKeys(dictionary)
                print(user.name, user.email)
            }
            
            
            print("User found")
            print(snapshot)} , withCancel: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        fetchUser()
    }

}
