//
//  HomeMessageTableViewCell.swift
//  ResidenceManager
//
//  Created by Ginpei on 2017-07-13.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class HomeMessageTableViewCell: UITableViewCell {
    @IBOutlet weak var bodyLabel: UILabel!
    
    static let identifier = "HomeMessageTableViewCell"
    static let idSeeAllCell = "HomeMessageTableViewSeeAllCell"
static let detailSegueIdentifier = "showChatThread"
    
    private var _thread: ChatThread?
    var thread: ChatThread? {
        get {
            return _thread
        }
        set(v) {
            _thread = v
            if bodyLabel != nil {
                bodyLabel.text = v?.lastMessage?.body
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
