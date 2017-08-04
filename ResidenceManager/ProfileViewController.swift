//
//  ProfileViewController.swift
//  ResidenceManager
//
//  Created by Ginpei on 2017-07-14.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit


class ProfileViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var images = [UIImage]()
    
    
    var user: RMUser!

    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        print("Hello Louis!!!!!!")
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        present(vc, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? EditProfileViewController {
            vc.imagePicked.image = profileImageView.image
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = user.name
        
        let editImageGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        profileImageView.addGestureRecognizer(editImageGesture)
        profileImageView.isUserInteractionEnabled = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
