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
    
    private func alertEmptyTitle() {
        let title = "Event"
        let message = "Title is required."
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func exit() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func save(_ sender: Any) {
        event.title = titleTextField.text!
        switch event.save() {
        case .success:
            exit()
        case .emptyTitle:
            alertEmptyTitle()
        case let .failure(error):
            print("ERROR", error as Any)
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        exit()
    }
}
