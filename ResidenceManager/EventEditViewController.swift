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
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var alldaySwitch: UISwitch!
    @IBOutlet weak var dateTableViewCell: UITableViewCell!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateSelectTableViewCell: UITableViewCell!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateTimeTableViewCell: UITableViewCell!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var dateTimeSelectTableViewCell: UITableViewCell!
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    
    static let identifier = "EventEditViewController"
    
    let dateFormatter = DateFormatter()
    
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
        
        let cell = tableView.cellForRow(at: indexPath)
        if cell == dateTableViewCell {
            dateSelectTableViewCell.isHidden = !dateSelectTableViewCell.isHidden
        }
        else if cell == dateTimeTableViewCell {
            dateTimeSelectTableViewCell.isHidden = !dateTimeSelectTableViewCell.isHidden
        }
    }
    
    private func alertEmptyTitle() {
        let title = "Event"
        let message = "Title is required."
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func updateEvent() {
        event.houseKey = RMUser.current!.houseKey
        event.title = titleTextField.text!
        //        event.descriptionText = descriptionTextField.text!
    }
    
    private func exit() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func save(_ sender: Any) {
        updateEvent()
        
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
    
    @IBAction func alldaySwitch_valueChanged(_ sender: UISwitch) {
        let allDay = sender.isOn
        dateTableViewCell.isHidden = !allDay
        dateTimeTableViewCell.isHidden = allDay
    }
    
    @IBAction func datePicker_valueChanged(_ sender: UIDatePicker) {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateLabel.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func dateTimePicker_valueChanged(_ sender: UIDatePicker) {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateTimeLabel.text = dateFormatter.string(from: sender.date)
    }
}
