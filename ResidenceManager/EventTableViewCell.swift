//
//  EventTableViewCell.swift
//  ResidenceManager
//
//  Created by Ginpei on 2017-08-01.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "EventTableViewCell"
    
    private var _event: HouseEvent?
    var event: HouseEvent? {
        get {
            return _event
        }
        set(v) {
            _event = v
            if titleLabel != nil {
                titleLabel.text = v?.title
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
