//
//  ChatMessage.swift
//  ResidenceManager
//
//  Created by Ginpei on 2017-07-13.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import Foundation
import Firebase

class ChatMessage {
    let body: String
    
    init() {
        body = ""
    }
    
    init(body: String) {
        self.body = body
    }
}
