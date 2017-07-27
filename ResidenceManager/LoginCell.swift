//
//  LoginCell.swift
//  ResidenceManager
//
//  Created by Masato Miyazawa on 2017-07-26.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit

class LoginCell: UICollectionViewCell {
    
    
    let logoimageView: UIImageView = {
        let image = UIImage(named: "logo")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    let emailTextfield: LeftPaddedTextField = {
        let textfield = LeftPaddedTextField()
        textfield.placeholder = "Enter email"
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        textfield.keyboardType = .emailAddress
        textfield.layer.borderWidth = 1
        
        return textfield
    }()
    
    let passwordTextfield: LeftPaddedTextField = {
        let textfield = LeftPaddedTextField()
        textfield.placeholder = "Enter password"
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        textfield.isSecureTextEntry = true
        textfield.layer.borderWidth = 1
        
        return textfield
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(logoimageView)
        addSubview(emailTextfield)
        addSubview(passwordTextfield)
        addSubview(loginButton)
        
        _ = logoimageView.anchor(centerYAnchor, left: nil, bottom: nil, right: nil, topConstant: -230, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 160, heightConstant: 160)
        logoimageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        _ = emailTextfield.anchor(logoimageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 8, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
        
        _ = passwordTextfield.anchor(emailTextfield.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
        
        _ = loginButton.anchor(passwordTextfield.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
        
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





