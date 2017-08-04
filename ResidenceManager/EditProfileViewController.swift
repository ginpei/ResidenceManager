//
//  EditProfileViewController.swift
//  ResidenceManager
//
//  Created by Luis Alfredo Ramirez on 2017-08-03.
//  Copyright © 2017 Ginpei. All rights reserved.
//

import UIKit
import Firebase

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePicked: UIImageView!
    
    @IBAction func openCameraButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func openLibraryButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        let imageData = UIImagePNGRepresentation(imagePicked.image!)
        let compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
        
        let saveAlert = UIAlertController(title: "Sweet!", message: "Your image has been saved to Photo Library!", preferredStyle: .alert)
        saveAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(saveAlert, animated: true, completion: nil)
    }
    
    var callback: ((UIImage?) -> Void)?
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePicked.contentMode = .scaleToFill
            imagePicked.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
        
        goBack()
    }
    
    func goBack() {
        
        callback?(imagePicked.image)
        dismiss(animated: true, completion: nil)
    }
    
//    func retrieveUser(){
//        
//        Database.database().reference().child("user").observe(.childAdded){ (snapshot:DataSnapshot) in
//            print(Thread.isMainThread)
//            if let dict = snapshot.value as? [String: Any] {
//                let userNameText = dict["username"] as! String
//                let profileImageUrl = dict["profileImageUrl"] as! String
//                let user = Users(userIdText: userNameText, imageUrlText: profileImageUrl)
//                self.user.append(user)
//            }
//            
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
