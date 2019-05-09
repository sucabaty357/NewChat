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
import Firebase

extension UserProfileContainerView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        
        if userProfileContainerView.profileImageView.image != nil {
            alert.addAction(UIAlertAction(title: "Delete photo", style: .destructive, handler: { _ in
                self.deletePhoto()
            }))
            
        }
        
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func deletePhoto() {
        //need to delete from firebase
        userProfileContainerView.profileImageView.showActivityIndicator()
        
        let userPhotoURL = UserDefaults.standard.string(forKey: "userPhotoURL")
        
        let imageRef = Storage.storage().reference(forURL: userPhotoURL!)
        
        imageRef.delete { (error) in
            print("error removig image from firebse storage")
        }
        
        print("removing completed begining removing URLS")
        
        let userReference = Database.database().reference().child("users").child(Auth.auth().currentUser!.uid)
        userReference.updateChildValues(["photoURL" : ""], withCompletionBlock: { (error, referene) in
            if error != nil {
                print("error deleting url from firebase")
            }
            self.userProfileContainerView.profileImageView.image = nil
            UserDefaults.standard.set("", forKey: "userPhotoURL")
            self.userProfileContainerView.profileImageView.hideActivityIndicator()
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
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            self.userProfileContainerView.profileImageView.image = selectedImage
            updateUserProfile(with:  self.userProfileContainerView.profileImageView.image!)
        }
        
        editLayer.removeFromSuperlayer()
        label.removeFromSuperview()
        dismiss(animated: true, completion: nil)
        userProfileContainerView.profileImageView.startAnimating()
        
    }
    
    func updateUserProfile(with image: UIImage) {
        uploadAvatarForUserToFirebaseStorageUsingImage(image, completion: { (imageURL) in
            self.userProfileContainerView.profileImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: image, options: [.highPriority, .continueInBackground, .progressiveDownload], completed: { (image, error, cacheType, url) in
                
                let reference = Database.database().reference().child("users").child(Auth.auth().currentUser!.uid)
                reference.updateChildValues(["photoURL" : String(describing: url!)], withCompletionBlock: { (error, ref) in
                    UserDefaults.standard.set(String(describing: url!), forKey: "userPhotoURL")
                    self.userProfileContainerView.profileImageView.hideActivityIndicator()
                })
            })
        })
    
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            print("canceled picker")
            dismiss(animated: true, completion: nil)
        }
    
    }
}
