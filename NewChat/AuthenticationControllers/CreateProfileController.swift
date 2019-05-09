//
//  CreateProfileController.swift
//  NewChat
//
//  Created by DuongTrong on 5/9/19.
//  Copyright © 2019 DuongTrong. All rights reserved.
//

import UIKit
import FirebaseAuth
import SDWebImage

class CreateProfileController: UIViewController {

    let createProfileContainerView = CreateProfileContainerView()
    let picker = UIImagePickerController()
    var editLayer: CAShapeLayer!
    var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstraints()
        configurePickerController()
        createProfileContainerView.profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
    }
    
    typealias CompletionHandler = (_ success: Bool) -> Void
    
    func checkIfUserDataExists(completionHandler:@escaping CompletionHandler) {
        
        if Auth.auth().currentUser?.photoURL != nil && Auth.auth().currentUser?.displayName != nil {
            createProfileContainerView.name.text = Auth.auth().currentUser?.displayName
            createProfileContainerView.profileImageView.sd_setImage(with: Auth.auth().currentUser?.photoURL, placeholderImage: nil, options: [ .highPriority, .continueInBackground], completed: { (image, error, cacheType, url) in
                completionHandler(true)
            })
            
        } else if Auth.auth().currentUser?.photoURL == nil && Auth.auth().currentUser?.displayName != nil {
            createProfileContainerView.name.text = Auth.auth().currentUser?.displayName
            completionHandler(true)
        } else {
            completionHandler(true)
        }
    }
    
    fileprivate func setConstraints() {
        view.addSubview(createProfileContainerView)
        createProfileContainerView.translatesAutoresizingMaskIntoConstraints = false
        createProfileContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: navigationController!.navigationBar.frame.height).isActive = true
        createProfileContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        createProfileContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        createProfileContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
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
    
    @objc func rightBarButtonDidTap () {
        
        if createProfileContainerView.name.text == "" {
            createProfileContainerView.name.state
        } else {
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = self.createProfileContainerView.name.text
            
            changeRequest?.commitChanges(completion: { (error) in
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
