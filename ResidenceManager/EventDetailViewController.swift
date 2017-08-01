//
//  EventDetailViewController.swift
//  ResidenceManager
//
//  Created by Ginpei on 2017-07-12.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    var event: HouseEvent!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let e = event {
            title = e.title
            titleLabel.text = e.title
        }
        else {
            print("WARNING wrong navigation")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination
        
        if let vc = vc as? EventEditViewController {
            vc.event = event
        }
    }
}
