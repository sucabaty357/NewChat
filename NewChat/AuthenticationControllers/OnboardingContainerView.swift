//
//  OnboardingContainerView.swift
//  NewChat
//
//  Created by DuongTrong on 5/9/19.
//  Copyright © 2019 DuongTrong. All rights reserved.
//

import UIKit

class OnboardingContainerView: UIView {

    let logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        return logoImageView
    }()
    
    let welcomeTitle: UILabel = {
        let welcomeTitle = UILabel()
        welcomeTitle.translatesAutoresizingMaskIntoConstraints = false
        welcomeTitle.text = "Welcome to iChat"
        welcomeTitle.font = UIFont.systemFont(ofSize: 20)
        welcomeTitle.textAlignment = .center
        return welcomeTitle
    }()
    
    let startMessaging: UIButton = {
        let startMessaging = UIButton()
        startMessaging.translatesAutoresizingMaskIntoConstraints = false
        startMessaging.setTitle("Start messaging", for: .normal)
        startMessaging.setTitleColor(PigeonPalette.pigeonPaletteBlue, for: .normal)
        startMessaging.titleLabel?.backgroundColor = PigeonPalette.pigeonPaletteControllerBackground
        startMessaging.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        startMessaging.addTarget(self, action: #selector(OnboardingController.startMessagingDidTap), for: .touchUpInside)
        return startMessaging
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(logoImageView)
        addSubview(welcomeTitle)
        addSubview(startMessaging)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            logoImageView.heightAnchor.constraint(equalToConstant: deviceScreen.width),
            
            startMessaging.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            startMessaging.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            startMessaging.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            startMessaging.heightAnchor.constraint(equalToConstant: 50),
            
            welcomeTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            welcomeTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            welcomeTitle.heightAnchor.constraint(equalToConstant: 50),
            welcomeTitle.bottomAnchor.constraint(equalTo: startMessaging.topAnchor, constant: -10)
            ])
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

}
