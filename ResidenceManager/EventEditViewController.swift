//
//  EventEditViewController.swift
//  ResidenceManager
//
//  Created by Ginpei on 2017-08-01.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class EventEditViewController: UITableViewController {
    @IBOutlet weak var titleTextField: UITextField!
    
    static let identifier = "EventEditViewController"
    
    var event: HouseEvent!
    var onSave: ((HouseEvent) -> Void)?

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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
        event.houseKey = RMUser.current!.houseKey
        
        switch event.save() {
        case .success:
            self.onSave?(self.event)
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
