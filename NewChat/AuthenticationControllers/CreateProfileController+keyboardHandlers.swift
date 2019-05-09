//
//  CreateProfileController+keyboardHandlers.swift
//  NewChat
//
//  Created by DuongTrong on 5/9/19.
//  Copyright © 2019 DuongTrong. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


//extension CreateProfileController {/* keyboard */
//
//  func setupKeyboardObservers() {
//    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//  }
//
//
//  func handleKeyboardWillShow(_ notification: Notification) {
//    let keyboardFrame = ((notification as NSNotification).userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
//    let keyboardDuration = ((notification as NSNotification).userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
//
//    if  createProfileContainerView.bio.isFirstResponder  {
//      createProfileContainerView.frame.origin.y = -keyboardFrame!.height
//    } else {
//       createProfileContainerView.frame.origin.y = 0
//    }
//
//    UIView.animate(withDuration: keyboardDuration!, animations: {
//      self.view.layoutIfNeeded()
//    })
//  }
//
//
//  func handleKeyboardWillHide(_ notification: Notification) {
//    let keyboardDuration = ((notification as NSNotification).userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
//
//
//    createProfileContainerView.frame.origin.y = 0
//
//    UIView.animate(withDuration: keyboardDuration!, animations: {
//      self.view.layoutIfNeeded()
//    })
//  }
//}
