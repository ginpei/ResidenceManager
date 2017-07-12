//
//  HomeEventTableViewCell.swift
//  ResidenceManager
//
//  Created by Ginpei on 2017-07-12.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class HomeEventTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "HomeEventTableViewCell"
    
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
