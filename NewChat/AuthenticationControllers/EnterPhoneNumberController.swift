//
//  EnterPhoneNumberController.swift
//  NewChat
//
//  Created by DuongTrong on 5/9/19.
//  Copyright © 2019 DuongTrong. All rights reserved.
//

import UIKit
import FirebaseAuth

class EnterPhoneNumberController: UIViewController {

    let phoneNumberContainerView = EnterPhoneNumberContainerView()
    let countries = Country().countries
    var isVerificationSent = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        configureNavigationBar()
        setConstraints()
        setCountry()
    }
    
    
    fileprivate func setCountry() {
        for country in countries {
            if  country["code"] == countryCode {
                phoneNumberContainerView.countryCode.text = country["dial_code"]
                phoneNumberContainerView.selectCountry.setTitle(country["name"], for: .normal)
            }
        }
    }
    
    fileprivate func setConstraints() {
        view.addSubview(phoneNumberContainerView)
        phoneNumberContainerView.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: navigationController!.navigationBar.frame.height).isActive = true
        phoneNumberContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        phoneNumberContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        phoneNumberContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
    fileprivate func configureNavigationBar () {
        let rightBarButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(rightBarButtonDidTap))
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    
    @objc func openCountryCodesList() {
        let picker = SelectCountryCodeController()
        picker.delegate = self as? CountryPickerDelegate
        navigationController?.pushViewController(picker, animated: true)
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        setRightBarButtonStatus()
    }
    
    func setRightBarButtonStatus() {
        if phoneNumberContainerView.phoneNumber.text!.characters.count < 9 || phoneNumberContainerView.countryCode.text == " - " {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    @objc func rightBarButtonDidTap () {
        let destination = EnterVerificationCodeController()
        destination.enterVerificationContainerView.titleNumber.text = phoneNumberContainerView.countryCode.text! + phoneNumberContainerView.phoneNumber.text!
        navigationController?.pushViewController(destination, animated: true)
        if !isVerificationSent {
            let phoneNumberForVerification = phoneNumberContainerView.countryCode.text! + phoneNumberContainerView.phoneNumber.text!
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumberForVerification, uiDelegate: <#AuthUIDelegate?#>) { (verificationID, error) in
                if let error = error {
                    print(error.localizedDescription)
                    //  self.showMessagePrompt(error.localizedDescription)
                    return
                }
                
                print("verification sent")
                self.isVerificationSent = true
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                
                // Sign in using the verificationID and the code sent to the user
                // ...
            }
        } else {
            print("verification has already been sent once")
        }
        
    }
}

/*
 PhoneAuthProvider.provider().verifyPhoneNumber("+380636536462") { (verificationID, error) in
 if let error = error {
 print(error.localizedDescription)

        navigationController?.pushViewController(destination, animated: true)
    }
    

}

extension EnterPhoneNumberController: CountryPickerDelegate {
    
    func countryPicker(_ picker: SelectCountryCodeController, didSelectCountryWithName name: String, code: String, dialCode: String) {
        phoneNumberContainerView.selectCountry.setTitle(name, for: .normal)
        phoneNumberContainerView.countryCode.text = dialCode
        setRightBarButtonStatus()
        picker.navigationController?.popViewController(animated: true)
    }
*/
