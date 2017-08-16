//
//  MessageThreadViewController.swift
//  ResidenceManager
//
//  Created by Ginpei on 2017-07-13.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit
import Firebase


class ChatThreadViewController: UIViewController {
    @IBOutlet weak var tempLabel: UILabel!  // TODO
    
    var thread: ChatThread!

    func handleNewMessage() {
        let newMessageController = NewMessageTableViewController()
        let navController = UINavigationController(rootViewController: newMessageController)
        present(navController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let newMessageImage = UIImage(named: "edit")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: newMessageImage, style: .plain, target: self, action: #selector(handleNewMessage))
        
        tempLabel.text = thread.lastMessage?.body
        

    }

}
