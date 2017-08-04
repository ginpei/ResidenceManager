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
    var key = ""
    var houseKey = ""
    var title = ""
    var descriptionText = ""
    var allDay = true
    var startAt = Date()
    
    private var ref: DatabaseReference {
        get {
            if (key.isEmpty) {
                key = HouseEvent.ref.childByAutoId().key
            }
            
            return HouseEvent.ref.child(key)
        }
    }
    
    init() {
    }

    // TODO: remove
    init(title: String) {
        self.title = title
    }
    
    init(key: String, values: [String: Any]) {
        self.key = key
        houseKey = values["houseKey"] as? String ?? ""
        title = values["title"] as? String ?? ""
        descriptionText = values["description"] as? String ?? ""
        allDay = values["allDay"] as? Bool ?? false
        startAt = date(at: values["startAt"]) ?? Date()
    }
    
    func date(at timestamp: Any?) -> Date? {
        let number = timestamp as? Int ?? 0
        let interval = TimeInterval(exactly: number)
        if let interval = interval {
            return Date.init(timeIntervalSince1970: interval)
        }
        else {
            return nil
        }
    }
    
    func save() -> HouseEventResult {
        if (title.isEmpty) {
            return HouseEventResult.emptyTitle
        }
        
        ref.setValue([
            "houseKey": houseKey,
            "title": title,
            "description": descriptionText,
            "allDay": allDay,
            "startAt": startAt.timeIntervalSince1970,
            ])
        
        return HouseEventResult.success([self])
    }
    
    static var ref: DatabaseReference {
        get {
            return Database.database().reference().child("houseEvent")
        }
    }
    
    static func fetchAll(forUser user: RMUser, completionHandler: @escaping (HouseEventResult) -> Void) {
        let query = ref.queryOrdered(byChild: "houseKey").queryEqual(toValue: user.houseKey)
        query.observeSingleEvent(of: .value, with: { (snapshot) in
            if let events = buildEvents(from: snapshot) {
                completionHandler(.success(events))
            }
            else {
                completionHandler(.success([]))
            }
        })
    }
    
    private static func buildEvents(from snapshot: DataSnapshot) -> [HouseEvent]? {
        guard let eventDataList = snapshot.value as? [String: Any] else {
            return nil
        }
        
        var events = [HouseEvent]()
        for (key, value) in eventDataList {
            if let values = value as? [String: Any] {
                events.append(HouseEvent(key: key, values: values))
            }
        }
    
        return events
    }
}

enum HouseEventResult {
    case success([HouseEvent])
    case failure(HouseEventError?)
    case emptyTitle
}

enum HouseEventError: Error {
    case noHouseKey
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
