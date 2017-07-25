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
    
    case success(Firebase.User?)  // not nil: logged in, nil: NOT logged in
    
    case failure(Error?)  // error
}

class UserStore {
    static func ensureVaridUser(completionHandler: @escaping (UserVaridationResult) -> Void) {
        let result = UserVaridationResult.success(Auth.auth().currentUser)
        completionHandler(result)
    }
}
