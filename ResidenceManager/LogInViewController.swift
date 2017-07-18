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
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtAuthStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if let user = Auth.auth().currentUser {
            self.txtAuthStatus.text = "Signed In as " + user.email!
        }
        else {
            self.txtAuthStatus.text = "Signed Out"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    Create User button tap
    
    @IBAction func btnCreateUser(_ sender: AnyObject) {
        if let email:String = txtEmail.text, let pass:String = txtPassword.text {
            Auth.auth().createUser(withEmail: email, password: pass) { (user,error) in
                if let error = error {
                    self.txtAuthStatus.text = error.localizedDescription
                }
                if let user = user {
                    self.txtAuthStatus.text = "Signed In as " + user.email!
                    self.txtEmail.text = nil
                    self.txtPassword.text = nil
                }
            }
        }
    }
    
    @IBAction func btnSignedIn(sender: AnyObject) {
        if let email:String = txtEmail.text, let pass:String = txtPassword.text {
            Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
                if let error = error {
                    self.txtAuthStatus.text = error.localizedDescription
                }
                if let user = user {
                    self.txtAuthStatus.text = "Signed in as " + user.email!
                    self.txtEmail.text = nil
                    self.txtPassword.text = nil
                }
            }
        }
    }
    
    @IBAction func btnSignedOut(sender: AnyObject) {
        try! Auth.auth().signOut()
        self.txtAuthStatus.text = "Signed Out"
        self.txtEmail.text = nil
        self.txtPassword.text = nil
        
    }
    
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
}
