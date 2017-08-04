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
    
    let indexOfDateTableViewCell = IndexPath(row: 1, section: 1)
    let indexOfDateSelectTableViewCell = IndexPath(row: 2, section: 1)
    let indexOfDateTimeTableViewCell = IndexPath(row: 3, section: 1)
    let indexOfDateTimeSelectTableViewCell = IndexPath(row: 4, section: 1)
    let dateFormatter = DateFormatter()
    
    var event: HouseEvent!
    var onSave: ((HouseEvent) -> Void)?
    
    private var selectingDate = false
    private var selectingDateTime = false

    override func viewDidLoad() {
        super.viewDidLoad()

        if event != nil {
            updateScreen()
        }
        else {
            print("WARNING wrong navigation")
            exit()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let patterns = [
            [indexOfDateTableViewCell, { !self.alldaySwitch.isOn }],
            [indexOfDateSelectTableViewCell, { !self.selectingDate }],
            [indexOfDateTimeTableViewCell, { self.alldaySwitch.isOn }],
            [indexOfDateTimeSelectTableViewCell, { !self.selectingDateTime }],
            ]
        
        for p in patterns {
            let i = p[0] as! IndexPath
            if (indexPath.row == i.row && indexPath.section == i.section) {
                let f = p[1] as! () -> Bool
                if f() {
                    print("Hide!", i.row, i.section)
                    return 0
                }
                else {
                    break
                }
            }
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath)
        if cell == dateTableViewCell {
            selectingDate = !selectingDate
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        else if cell == dateTimeTableViewCell {
            selectingDateTime = !selectingDateTime
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    private func alertEmptyTitle() {
        let title = "Event"
        let message = "Title is required."
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func updateScreen() {
        titleTextField.text = event.title
        descriptionTextField.text = event.descriptionText
        alldaySwitch.isOn = event.allDay
        datePicker.setDate(event.startAt, animated: false)
        updateDateValueLabel()
        dateTimePicker.setDate(event.startAt, animated: false)
        updateDateTimeValueLabel()
    }
    
    private func updateDateValueLabel() {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateLabel.text = dateFormatter.string(from: datePicker.date)
    }
    
    private func updateDateTimeValueLabel() {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateTimeLabel.text = dateFormatter.string(from: dateTimePicker.date)
    }
    
    private func updateEvent() {
        event.houseKey = RMUser.current!.houseKey
        event.title = titleTextField.text!
        event.descriptionText = descriptionTextField.text!
        
        event.allDay = alldaySwitch.isOn
        if alldaySwitch.isOn {
            event.startAt = datePicker.date
        }
        else {
            event.startAt = dateTimePicker.date
        }
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
        selectingDate = false
        selectingDateTime = false
        tableView.reloadData()
    }
    
    @IBAction func datePicker_valueChanged(_ sender: UIDatePicker) {
        updateDateValueLabel()
    }
    
    @IBAction func dateTimePicker_valueChanged(_ sender: UIDatePicker) {
        updateDateTimeValueLabel()
    }
}
