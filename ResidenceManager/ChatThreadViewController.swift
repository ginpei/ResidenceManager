//
//  MessageThreadViewController.swift
//  ResidenceManager
//
//  Created by Ginpei on 2017-07-13.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit


class ChatThreadViewController: UIViewController {
    @IBOutlet weak var tempLabel: UILabel!  // TODO
    
    var thread: ChatThread!

    override func viewDidLoad() {
        super.viewDidLoad()

        tempLabel.text = thread.lastMessage?.body
    }

}
