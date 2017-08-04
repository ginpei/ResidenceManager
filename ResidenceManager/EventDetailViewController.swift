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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if event.deleted {
            dismiss(animated: true, completion: nil)
        }
        
        updateScreen()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination
        
        if let nav = vc as? UINavigationController, let vc = nav.viewControllers[0] as? EventEditViewController {
            vc.event = event
        }
    }
    
    private func updateScreen() {
        if event == nil {
            print("WARNING wrong navigation")
            return
        }
        
        title = event.title
        titleLabel.text = event.title
    }
}
