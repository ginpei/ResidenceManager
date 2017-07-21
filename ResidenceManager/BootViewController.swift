//
//  BootViewController.swift
//  ResidenceManager
//
//  Created by Ginpei on 2017-07-14.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit
import Firebase

class BootViewController: UIViewController {

    static private let idHomeViewController = "home"
    static private let idLoginViewController = "login"
    
    override func viewDidAppear(_ animated: Bool) {
        UserStore.ensureVaridUser() { result in
            
            switch result {
            case let .success(user):
                self.goToNext(user)
            case let .failure(error):
                // TODO show error detail to user; e.g. network error
                print("ERROR", error as Any)
            }
        }
    }
    
    func goToNext(_ user: Firebase.User?) {
        var nextView: UIViewController!
        
        if user != nil {
            nextView = storyboard?.instantiateViewController(withIdentifier: BootViewController.idHomeViewController) as! HomeViewController
        }
        else {
            nextView = storyboard?.instantiateViewController(withIdentifier: BootViewController.idLoginViewController) as! LogInViewController
        }
        let nav = UINavigationController(rootViewController: nextView)
        present(nav, animated: false, completion: nil)
    }
}
