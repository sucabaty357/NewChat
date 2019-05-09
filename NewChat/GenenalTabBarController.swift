//
//  GenenalTabBarController.swift
//  NewChat
//
//  Created by DuongTrong on 5/9/19.
//  Copyright © 2019 DuongTrong. All rights reserved.
//

import UIKit
import FirebaseAuth


enum tabs: Int {
    case contacts = 0
    case chats = 1
    case settings = 2
    
}

class GeneralTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    var onboardingAlreadyPresented = false
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        if  !onboardingAlreadyPresented {
//            // presentOnboardingIfNeeded()
//            onboardingAlreadyPresented = true
//        }
//    }
    
//    fileprivate func presentOnboardingIfNeeded () {
//        if Auth.auth().currentUser == nil {
//            let destination = OnboardingController()
//            let newNavigationController = UINavigationController(rootViewController: destination)
//            //  navigationController.navigationBar.isHidden = true
//            UINavigationBar.appearance().shadowImage = UIImage()
//            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
//            self.modalPresentationStyle = .overCurrentContext
//
//            self.present(newNavigationController, animated: false, completion: nil)
//        }
//    }
}
