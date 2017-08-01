//
//  EventEditViewController.swift
//  ResidenceManager
//
//  Created by Ginpei on 2017-08-01.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class EventEditViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    
    var event: HouseEvent!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let e = event {
            titleTextField.text = e.title
        }
        else {
            print("WARNING wrong navigation")
            exit()
        }
    }
    
    private func exit() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func save(_ sender: Any) {
        exit()
    }
}
