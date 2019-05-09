//
//  OnboardingController.swift
//  NewChat
//
//  Created by DuongTrong on 5/9/19.
//  Copyright © 2019 DuongTrong. All rights reserved.
//

import UIKit

class OnboardingController: UIViewController {
    
    let onboardingContainerView = OnboardingContainerView(frame: CGRect(x: 0, y: 0, width: deviceScreen.width , height: deviceScreen.height))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(onboardingContainerView)
        
    }
    
    @objc func startMessagingDidTap() {
        print("tapped")
        let destination = EnterPhoneNumberController()
        navigationController?.pushViewController(destination, animated: true)
    }

}
