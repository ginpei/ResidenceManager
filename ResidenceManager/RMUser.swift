//
//  User.swift
//  ResidenceManager
//
//  Created by Ginpei on 2017-07-14.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import Foundation
import Firebase


// the name User conflicts with Firebase's class
class RMUser {
    var manager = false
    var key = ""
    var houseKey = ""
    var name = ""
    var email = ""
    
    
    static var loginUser: User?
    
    init(manager: Bool, name: String) {
        self.manager = manager
        self.name = name
    }
    
    init(key: String, values: [String: Any]) {
        self.key = key
        name = values["name"] as? String ?? ""
        email = values["email"] as? String ?? ""
        houseKey = values["houseKey"] as? String ?? ""
    }
    
    private static var _current: RMUser?
    static var current: RMUser? {
        get {
            return _current
        }
    }
    
    static var ref: DatabaseReference {
        get {
            return Database.database().reference().child("users")
        }
    }
    
    static func updateCurrent(completionHandler: @escaping (RMUser?) -> Void) {
        _current = nil
        
        guard let key = Auth.auth().currentUser?.uid else {
            completionHandler(nil)
            return
        }
        
        find(key: key) { (result) in
            switch result {
            case let .success(user):
                _current = user
                
                completionHandler(user)
            default:
                completionHandler(nil)
            }
        }
    }
    
    static func find(key: String, completionHandler: @escaping (RMUserFindResult) -> Void) {
        ref.child(key).observeSingleEvent(of: .value, with: { (snapshot) in
            var result: RMUserFindResult!
            if let v = snapshot.value as? [String:Any] {
                result = RMUserFindResult.success(RMUser(key: key, values: v))
                print(snapshot)
              
            }
            else {
                result = RMUserFindResult.notFound
            }
            
            completionHandler(result)
        })
    }
}

enum RMUserFindResult {
    case success(RMUser)
    case notFound
    case error(Error?)
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
