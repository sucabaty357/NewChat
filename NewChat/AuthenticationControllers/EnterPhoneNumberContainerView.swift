//
//  EnterPhoneNumberContainerView.swift
//  NewChat
//
//  Created by DuongTrong on 5/9/19.
//  Copyright © 2019 DuongTrong. All rights reserved.
//

import UIKit

class EnterPhoneNumberContainerView: UIView {

    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.text = "Your phone"
        title.font = UIFont.systemFont(ofSize: 32)
        return title
    }()
    
    let instructions: UILabel = {
        let instructions = UILabel()
        instructions.translatesAutoresizingMaskIntoConstraints = false
        instructions.textAlignment = .center
        instructions.text = "Please confirm your country code\nand enter your phone number."
        instructions.numberOfLines = 2
        instructions.font = UIFont.systemFont(ofSize: 17)
        
        return instructions
    }()
    
    let selectCountry: UIButton = {
        let selectCountry = UIButton()
        selectCountry.translatesAutoresizingMaskIntoConstraints = false
        selectCountry.setBackgroundImage(UIImage(named: "PigeonAuthCountryButton"), for: .normal)
        selectCountry.setBackgroundImage(UIImage(named:"PigeonAuthCountryButtonHighlighted"), for: .highlighted)
        selectCountry.setTitle("Ukraine", for: .normal)
        selectCountry.setTitleColor(.black, for: .normal)
        selectCountry.contentHorizontalAlignment = .left
        selectCountry.contentVerticalAlignment = .center
        selectCountry.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15.0, bottom: 0.0, right: 0.0)
        selectCountry.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        selectCountry.addTarget(self, action: #selector(EnterPhoneNumberController.openCountryCodesList), for: .touchUpInside)
        return selectCountry
    }()
    
    let phoneNumber: UITextField = {
        let phoneNumber = UITextField()
        phoneNumber.text = "(63) 653 64 62"
        phoneNumber.font = UIFont.systemFont(ofSize: 20)
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        phoneNumber.textAlignment = .center
        phoneNumber.keyboardType = .numberPad
        phoneNumber.placeholder = "Phone number"
        phoneNumber.addTarget(self, action: #selector(EnterPhoneNumberController.textFieldDidChange(_:)), for: .editingChanged)
        return phoneNumber
    }()
    
    let backgroundFrame: UIImageView = {
        let backgroundFrame = UIImageView()
        backgroundFrame.translatesAutoresizingMaskIntoConstraints = false
        backgroundFrame.image = UIImage(named: "PigeonAuthPhoneBackground")
        return backgroundFrame
    }()
    
    var countryCode: UILabel = {
        var countryCode = UILabel()
        countryCode.translatesAutoresizingMaskIntoConstraints = false
        countryCode.text = "+380"
        countryCode.textAlignment = .center
        countryCode.font = UIFont.systemFont(ofSize: 20)
        return countryCode
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(title)
        addSubview(instructions)
        addSubview(selectCountry)
        addSubview(countryCode)
        addSubview(phoneNumber)
        addSubview(backgroundFrame)
        
        phoneNumber.delegate = self as UITextFieldDelegate
        
        let countryCodeWidth = deviceScreen.width * 0.26
        
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            title.heightAnchor.constraint(equalToConstant: 70),
            
            instructions.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 0),
            instructions.leadingAnchor.constraint(equalTo: title.leadingAnchor, constant: 0),
            instructions.trailingAnchor.constraint(equalTo: title.trailingAnchor, constant: 0),
            instructions.heightAnchor.constraint(equalToConstant: 45),
            
            selectCountry.topAnchor.constraint(equalTo: topAnchor, constant: 150),
            selectCountry.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            selectCountry.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            selectCountry.heightAnchor.constraint(equalToConstant: 70),
            
            backgroundFrame.topAnchor.constraint(equalTo: selectCountry.bottomAnchor, constant: -8),
            backgroundFrame.leadingAnchor.constraint(equalTo: selectCountry.leadingAnchor, constant: 0),
            backgroundFrame.trailingAnchor.constraint(equalTo: selectCountry.trailingAnchor, constant: 0),
            backgroundFrame.heightAnchor.constraint(equalToConstant: 50),
            
            countryCode.leadingAnchor.constraint(equalTo: backgroundFrame.leadingAnchor, constant: 0),
            countryCode.centerYAnchor.constraint(equalTo: backgroundFrame.centerYAnchor, constant: 0),
            countryCode.widthAnchor.constraint(equalToConstant: countryCodeWidth),
            countryCode.heightAnchor.constraint(equalTo: backgroundFrame.heightAnchor, constant: 0),
            
            phoneNumber.leadingAnchor.constraint(equalTo: countryCode.trailingAnchor, constant: 2),
            phoneNumber.trailingAnchor.constraint(equalTo: backgroundFrame.trailingAnchor, constant: -5),
            phoneNumber.centerYAnchor.constraint(equalTo: backgroundFrame.centerYAnchor, constant: 0),
            phoneNumber.heightAnchor.constraint(equalTo: backgroundFrame.heightAnchor, constant: 0)
        ])
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

}

extension EnterPhoneNumberContainerView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        
        let newLength = text.utf16.count + string.utf16.count - range.length
        return newLength <= 10 // Bool
    }
}
