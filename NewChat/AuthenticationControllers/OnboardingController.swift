//
//  OnboardingController.swift
//  NewChat
//
//  Created by DuongTrong on 5/9/19.
//  Copyright © 2019 DuongTrong. All rights reserved.
//

import UIKit

class OnboardingController: UIViewController {
    
    let onboardingContainerView = OnboardingContainerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(onboardingContainerView)
        onboardingContainerView.frame = view.bounds
        
    }
    
    @objc func startMessagingDidTap() {
        print("tapped")
        let destination = EnterPhoneNumberController()
        navigationController?.pushViewController(destination, animated: true)
    }

}
