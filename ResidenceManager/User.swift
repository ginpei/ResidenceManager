//
//  User.swift
//  ResidenceManager
//
//  Created by Ginpei on 2017-07-14.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import Foundation
import Firebase

class User {
    var manager = false
    var name = ""
    
    static var loginUser: User?
    
    init(manager: Bool, name: String) {
        self.manager = manager
        self.name = name
    }
}

enum UserVaridationResult {
    
    case success(User?)  // not nil: logged in, nil: NOT logged in
    
    case failure(Error?)  // error
}

class UserStore {
    static func ensureVaridUser(completionHandler: @escaping (UserVaridationResult) -> Void) {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
            User.loginUser = User(manager: true, name: "Justin Trudeau")
//            let result = UserVaridationResult.success(User.loginUser)
            let result = UserVaridationResult.success(nil)
//            let result = UserVaridationResult.failure(nil)
            completionHandler(result)
        }
    }
}
