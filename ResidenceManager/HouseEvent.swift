//
//  Event.swift
//  ResidenceManager
//
//  Created by Ginpei on 2017-07-12.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import Foundation

class HouseEvent {
    var title: String
    
    init() {
        title = ""
    }
    
    init(title: String) {
        self.title = title
    }
}

//enum HouseEventResult {
//    case success([HouseEvent])
//    case failure(Error?)
//}
//
//class HouseEventStore {
//    func fetchAll(completionHandler: @escaping (HouseEventResult) -> Void) {
//    }
//}
