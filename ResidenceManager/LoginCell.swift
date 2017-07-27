//
//  LoginCell.swift
//  ResidenceManager
//
//  Created by Masato Miyazawa on 2017-07-26.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit
import Firebase

class LoginCell: UICollectionViewCell {
    
    var viewController: UIViewController!
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = UIColor.yellow
        iv.image = UIImage(named: "vancouver2")
        iv.clipsToBounds = true
        return iv
    }()
    
    let logoimageView: UIImageView = {
        let image = UIImage(named: "logo")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    let emailTextfield: LeftPaddedTextField = {
        let textfield = LeftPaddedTextField()
    //    textfield.placeholder = "Enter email"
        textfield.layer.cornerRadius = 4
        textfield.attributedPlaceholder =
            NSAttributedString(string: "Enter email", attributes: [NSForegroundColorAttributeName: UIColor(red:1, green:1, blue:1, alpha:0.7)])
        textfield.layer.borderColor = UIColor.white.cgColor
        textfield.keyboardType = .emailAddress
        textfield.layer.borderWidth = 1
        
        return textfield
    }()
    
    let passwordTextfield: LeftPaddedTextField = {
        let textfield = LeftPaddedTextField()
        textfield.layer.cornerRadius = 4
   //     textfield.placeholder = "Enter password"
        textfield.attributedPlaceholder = NSAttributedString(string: "Enter password", attributes: [NSForegroundColorAttributeName: UIColor(red:1, green:1, blue:1, alpha:0.7)])
        textfield.layer.borderColor = UIColor.white.cgColor
        textfield.isSecureTextEntry = true
        textfield.layer.borderWidth = 1
        
        return textfield
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red:1.00, green:0.16, blue:0.32, alpha:1.0)
        button.layer.cornerRadius = 4
        button.setTitle("LOGIN", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red:0.33, green:0.78, blue:0.99, alpha:1.0)
        button.layer.cornerRadius = 4
        button.setTitle("REGISTER", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        
        
        return button
    }()
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return true
    }

    func handleLoginRegister() {
//        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
//            handleLogin()
//        }
    }
    
    func handleLogin() {
        guard let email = emailTextfield.text, let password = passwordTextfield.text else {
            print("Form is not valid")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password, completion: {(user: User?, error)in
            
            if error != nil {
                print(error!)
                return
            }
            
            self.goToNext()
            
        })

    }
    
    func goToNext() {
        let nextView = viewController.storyboard?.instantiateViewController(withIdentifier: HomeViewController.identifier) as! HomeViewController
        let nav = UINavigationController(rootViewController: nextView)
        viewController.present(nav, animated: false, completion: nil)
    }
    
    
    func handleRegister() {
        guard let email = emailTextfield.text, let password = passwordTextfield.text else {
            print("Form is not valid")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: {(user: User?, error)in
        
            if error != nil {
                print(error!)
                return
            }

        })
        
        
        print("123")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(logoimageView)
        addSubview(emailTextfield)
        addSubview(passwordTextfield)
        addSubview(loginButton)
        addSubview(registerButton)
        
        _ = imageView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        _ = logoimageView.anchor(centerYAnchor, left: nil, bottom: nil, right: nil, topConstant: -210, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 275, heightConstant: 80)
        logoimageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        _ = emailTextfield.anchor(logoimageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 70, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: 0, heightConstant: 50)
        
        _ = passwordTextfield.anchor(emailTextfield.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: 0, heightConstant: 50)
        
        _ = loginButton.anchor(passwordTextfield.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 15, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: 0, heightConstant: 50)
        
        _ = registerButton.anchor(loginButton.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: 0, heightConstant: 50)

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LeftPaddedTextField: UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
}





