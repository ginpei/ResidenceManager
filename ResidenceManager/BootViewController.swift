//
//  BootViewController.swift
//  ResidenceManager
//
//  Created by Ginpei on 2017-07-14.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class BootViewController: UIViewController {
    
    static private let idHomeViewController = "home"
    static private let idLoginViewController = "login"
    
    override func viewDidAppear(_ animated: Bool) {
        var nextView: UIViewController!
        if User.isVaridLoginUser() {
            nextView = storyboard?.instantiateViewController(withIdentifier: BootViewController.idHomeViewController) as! HomeViewController
        }
        else {
            nextView = storyboard?.instantiateViewController(withIdentifier: BootViewController.idLoginViewController) as! LogInViewController
        }
        
        let nav = UINavigationController(rootViewController: nextView)
        present(nav, animated: false, completion: nil)
    }
}
