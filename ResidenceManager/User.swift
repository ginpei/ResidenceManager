//
//  User.swift
//  ResidenceManager
//
//  Created by Ginpei on 2017-07-14.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import Foundation

class User {
    var manager = false
    var name = ""
    
    static private var _loginUser: User?
    static var loginUser: User? {
        get {
            return _loginUser
        }
        set(v) {
            print("Logged in", v as Any)
            _loginUser = v
        }
    }
    
    static func isVaridLoginUser() -> Bool {
        return true
    }
}
