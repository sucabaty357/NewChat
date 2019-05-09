//
//  CreateProfileController+handlers.swift
//  NewChat
//
//  Created by DuongTrong on 5/9/19.
//  Copyright © 2019 DuongTrong. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import SDWebImage

extension CreateProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        // Image picker in edit mode
        if let imageVC = NSClassFromString("PUUIImageViewController") {
            if viewController.isKind(of: imageVC) {
                addRoundedEditLayer(to: viewController, forCamera: false)
            }
        }
    }
    
    
    @objc func handleSelectProfileImageView() {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Take photo", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Choose photo", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        if createProfileContainerView.profileImageView.image != nil {
            alert.addAction(UIAlertAction(title: "Delete photo", style: .destructive, handler: { _ in
                self.deletePhoto()
            }))
            
        }
        
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func deletePhoto() {
        //need to delete from firebase
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        
        createProfileContainerView.profileImageView.startAnimating()
        changeRequest?.photoURL = nil
        changeRequest?.commitChanges(completion: { (error) in
            if error != nil {
                print(error!.localizedDescription, "errrrrrror")
            } else {
                print("changed successfully")
                self.createProfileContainerView.profileImageView.image = nil
            }
            self.createProfileContainerView.profileImageView.stopAnimating()
        })
    }
    
    func openGallery() {
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    
    func openCamera() {
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            
            picker.sourceType = UIImagePickerController.SourceType.camera
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            createProfileContainerView.profileImageView.image = selectedImage
        }
        
        editLayer.removeFromSuperlayer()
        label.removeFromSuperview()
        dismiss(animated: true, completion: nil)
        createProfileContainerView.profileImageView.startAnimating()
        updateUserProfile()
        
    }
    
    func updateUserProfile() {
        
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        uploadAvatarForUserToFirebaseStorageUsingImage(createProfileContainerView.profileImageView.image!, completion: { (imageURL) in
            
            changeRequest?.photoURL = URL(string: imageURL)
            
            changeRequest?.commitChanges { (error) in
                self.createProfileContainerView.profileImageView.sd_setImage(with: Auth.auth().currentUser?.photoURL, placeholderImage: self.createProfileContainerView.profileImageView.image, options: [.highPriority, .continueInBackground, .progressiveLoad], completed: { (image, error, cacheType, url) in
                    
                    print("load finished")
                })
                
                self.createProfileContainerView.profileImageView.hideActivityIndicator()
            }
        })
    
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            print("canceled picker")
            dismiss(animated: true, completion: nil)
        }
    
    }
}
