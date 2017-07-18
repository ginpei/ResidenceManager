//
//  Event.swift
//  ResidenceManager
//
//  Created by Ginpei on 2017-07-12.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import Foundation
import Firebase

class HouseEvent {
    var title: String
    
    init() {
        title = ""
    }
    
    init(title: String) {
        self.title = title
    }
}

enum HouseEventResult {
    case success([HouseEvent])
    case failure(Error?)
}

class HouseEventStore {
    func fetchAll(completionHandler: @escaping (HouseEventResult) -> Void) {
        // dummy
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
            let result = HouseEventResult.success([
                HouseEvent(title: "BBQ at House 1"),
                HouseEvent(title: "BBQ at English Bay"),
                HouseEvent(title: "BBQ at Nanaimo Station"),
                ])
            completionHandler(result)
        }
    }
}
