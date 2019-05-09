//
//  Public.swift
//  NewChat
//
//  Created by DuongTrong on 5/9/19.
//  Copyright © 2019 DuongTrong. All rights reserved.
//

import UIKit
import FirebaseStorage
import ObjectiveC
import Foundation

public extension UIView {
    
    func shake(count : Float? = nil,for duration : TimeInterval? = nil,withTranslation translation : Float? = nil) {
        
        // You can change these values, so that you won't have to write a long function
        let defaultRepeatCount = 3
        let defaultTotalDuration = 0.1
        let defaultTranslation = -8
        
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        
        animation.repeatCount = count ?? Float(defaultRepeatCount)
        animation.duration = (duration ?? defaultTotalDuration)/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.byValue = translation ?? defaultTranslation
        layer.add(animation, forKey: "shake")
        
    }
}

func uploadAvatarForUserToFirebaseStorageUsingImage(_ image: UIImage, completion: @escaping (_ imageUrl: String) -> ()) {
    let imageName = UUID().uuidString
    let ref = Storage.storage().reference().child("message_images").child(imageName)
    
    if let uploadData = image.jpegData(compressionQuality: 0.2) {
        ref.putData(uploadData, metadata: nil, completion: { (metadata, error) in
            
            if error == nil, metadata != nil {
                ref.downloadURL { url, error in
                    completion((error?.localizedDescription)!)
                }
            } else {
                completion((error?.localizedDescription)!)
            }
        })
    }
}

private var activityIndicatorAssociationKey: UInt8 = 0



let backgroundView: UIView = {
    let backgroundView = UIView()
    backgroundView.backgroundColor = UIColor.black
    backgroundView.alpha = 0.8
    backgroundView.layer.cornerRadius = 0
    backgroundView.layer.masksToBounds = true
    return backgroundView
}()


extension UIImageView {
    var activityIndicator: UIActivityIndicatorView! {
        get {
            return objc_getAssociatedObject(self, &activityIndicatorAssociationKey) as? UIActivityIndicatorView
        }
        set(newValue) {
            objc_setAssociatedObject(self, &activityIndicatorAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    
    func showActivityIndicator() {
        self.activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.frame = CGRect(x:0.0, y:0.0, width: 40.0, height:40.0);
        self.activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        self.activityIndicator.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2);
        self.activityIndicator.autoresizingMask = [.flexibleLeftMargin , .flexibleRightMargin , .flexibleTopMargin , .flexibleBottomMargin]
        self.activityIndicator.isUserInteractionEnabled = false
        
        backgroundView.frame = CGRect(origin: self.activityIndicator.frame.origin, size: CGSize(width: 100, height: 100))// = image?.size
        backgroundView.center = self.activityIndicator.center
        
        print(self.activityIndicator.frame.size)
        // if self.activityIndicator == nil {
        
        OperationQueue.main.addOperation({ () -> Void in
            self.addSubview(backgroundView)
            self.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
        })
        // } else {
        //  self.activityIndicator.startAnimating()
        //print("not nillll")
        // }
    }
    
    
    func hideActivityIndicator() {
        OperationQueue.main.addOperation({ () -> Void in
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
            backgroundView.removeFromSuperview()
        })
    }
}
