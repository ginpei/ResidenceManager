//
//  LogInViewController.swift
//  ResidenceManager
//
//  Created by Ginpei on 2017-07-14.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {
    static private let idHomeViewController = "home"
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var txtAuthStatus: UILabel!
    @IBOutlet weak var txtName: UITextField!
    
    @IBAction func loginRegisterSegmentedC(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            registerButton.isHidden = true
            loginButton.isHidden = false
            txtName.isHidden = true
            
        } else if sender.selectedSegmentIndex == 1 {
            loginButton.isHidden = true
            registerButton.isHidden = false
            txtName.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButton.isHidden = true
        txtName.isHidden = true
        
        view.backgroundColor = UIColor(red: 218/255, green: 58/255, blue: 50/255, alpha: 1)
        
        if let users = Auth.auth().currentUser {
            self.txtAuthStatus.text = "Signed In as " + users.email!
        }
        else {
            self.txtAuthStatus.text = "Welcome!"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    Create User button tap
    
    func goToNext() {
        var nextView: UIViewController!
        
        nextView = storyboard?.instantiateViewController(withIdentifier: LogInViewController.idHomeViewController) as! HomeViewController
        
        let nav = UINavigationController(rootViewController: nextView)
        present(nav, animated: false, completion: nil)
    }
    
    
    @IBAction func btnCreateUser(_ sender: AnyObject) {
        print("New user register")
        
        if let username: String = txtName.text, let email:String = txtEmail.text, let pass:String = txtPassword.text {
            Auth.auth().createUser(withEmail: email, password: pass) { (newUser: User?,error) in
                if let error = error {
                    print(error.localizedDescription)
                    self.txtAuthStatus.text = error.localizedDescription
                    return
                }
                
                guard let uid = newUser?.uid else {
                    return
                }
                
                let ref = Database.database().reference(fromURL: "https://residencemanager-2fee0.firebaseio.com/")
                let usersRefer = ref.child("users").child(uid)
                let values = ["Name": username, "Email": email]
                usersRefer.updateChildValues(values, withCompletionBlock: { (err, ref) in
                    if err != nil{
                        print(err!)
                        return
                    }
                    print("User saved succesfully into Firebase db")
                    print("Signed in as " + username)
                    self.goToNext()
                })             
//                if let users = newUser {
//                    self.txtAuthStatus.text = "Signed In as " + users.email!
//                    self.goToNext()
//                }
            }
        }
    }
    
    
    @IBAction func btnSignedIn(sender: AnyObject) {
        if loginButton.isHidden == false {
            
            if let email:String = txtEmail.text, let pass:String = txtPassword.text {
                Auth.auth().signIn(withEmail: email, password: pass) { (existingUser: User?, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        self.txtAuthStatus.text = error.localizedDescription
                        return
                    }
                    
                    if let users = existingUser {
                        
                        print("signing in as" + users.email!)
                        self.txtAuthStatus.text = "Signed in as "
                        self.txtEmail.text = nil
                        self.txtPassword.text = nil
                        self.goToNext()
                    }
                }
            }
        } else if loginButton.isHidden == true{
            
            print("button Login is hidden")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //                Change bar color
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }
}
