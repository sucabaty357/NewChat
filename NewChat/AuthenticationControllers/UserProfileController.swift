//
//  UserProfileController.swift
//  NewChat
//
//  Created by Thinh Nguyen on 5/9/19.
//  Copyright © 2019 DuongTrong. All rights reserved.
//

import UIKit

class UserProfileController: UIViewController {

    let userProfileContainerView = UserProfileContainerView()
    let picker = UIImagePickerController()
    var editLayer: CAShapeLayer!
    var label: UILabel!
    typealias CompletionHandler = (_ success: Bool) -> Void
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(userProfileContainerView)
        userProfileContainerView.frame = view.bounds
        
        configureNavigationBar()
        configurePickerController()
        userProfileContainerView.profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
    }
    
    
    fileprivate func configurePickerController() {
        picker.delegate = self
        navigationController?.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(pictureCaptured), name: NSNotification.Name(rawValue: "_UIImagePickerControllerUserDidCaptureItem"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pictureRejected), name: NSNotification.Name(rawValue: "_UIImagePickerControllerUserDidRejectItem"), object: nil)
    }
    
    
    fileprivate func configureNavigationBar () {
        let rightBarButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(rightBarButtonDidTap))
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.title = "Profile"
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


extension UserProfileController { /* setting user data to database and to private data  */ /* firebase */
    
    func updateUserData() {
        
        ARSLineProgress.ars_showOnView(self.view)
        let userReference = Database.database().reference().child("users").child(Auth.auth().currentUser!.uid)
        userReference.updateChildValues(["name" : userProfileContainerView.name.text! ,
                                         "phoneNumber" : userProfileContainerView.phone.text! ]) { (error, reference) in
                                            
                                            UserDefaults.standard.set(self.userProfileContainerView.name.text!, forKey: "userName")
                                            UserDefaults.standard.set(self.userProfileContainerView.phone.text!, forKey: "userPhoneNumber")
                                            ARSLineProgress.hide()
                                            
                                            self.dismiss(animated: true, completion: nil)
        }
    }
}


extension UserProfileController {  /* only during authentication */
    
    func rightBarButtonDidTap () {
        
        if userProfileContainerView.name.text?.characters.count == 0 ||
            userProfileContainerView.name.text!.trimmingCharacters(in: .whitespaces).isEmpty {
            userProfileContainerView.name.shake()
        } else {
            updateUserData()
        }
    }
    
    
    func checkIfUserDataExists(completionHandler: @escaping CompletionHandler) {
        
        let nameReference = Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("name")
        nameReference.observe(.value, with: { (snapshot) in
            if snapshot.exists() {
                self.userProfileContainerView.name.text = (snapshot.value as! String)
                
            }
        })
        
        
        let photoReference = Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("photoURL")
        photoReference.observe(.value, with: { (snapshot) in
            
            if snapshot.exists() {
                
                let urlString:String = snapshot.value as! String
                self.userProfileContainerView.profileImageView.sd_setImage(with:  URL(string: urlString) , placeholderImage: nil, options: [ .highPriority, .continueInBackground, .progressiveDownload], completed: { (image, error, cacheType, url) in
                    UserDefaults.standard.set(URL(string: urlString), forKey: "userPhotoURL")
                    
                    completionHandler(true)
                })
            } else {
                completionHandler(true)
            }
            
        })
    }
}
