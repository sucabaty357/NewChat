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
        delegate = self
        setTabs()
        configureTabBarController()
        
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
    
    fileprivate func setTabs () {
        let contactsController = ContactsController()
        let chatsController = ChatsController()
        let settingsController = SettingsViewControllersContainer()
        
        let contactsTabItem = UITabBarItem(title: contactsController.title, image: #imageLiteral(resourceName: "user"), selectedImage: UIImage(named:"TabIconContacts_Highlighted"))
        let chatsTabItem = UITabBarItem(title: chatsController.title, image: #imageLiteral(resourceName: "chat"), selectedImage: UIImage(named:"TabIconMessages_Highlighted"))
        let settingsTabItem = UITabBarItem(title: settingsController.title, image: #imageLiteral(resourceName: "settings"), selectedImage: UIImage(named:"TabIconSettings_Highlighted"))
        contactsController.tabBarItem = contactsTabItem
        chatsController.tabBarItem = chatsTabItem
        settingsController.tabBarItem = settingsTabItem
        
        let tabBarControllers = [contactsController, chatsController, settingsController]
        setViewControllers(tabBarControllers, animated: false)
        
        // tabBarController?.title = chatsController.title
        // tabBarController?
    }
    
    fileprivate func configureTabBarController() {
        
    }
}

extension GeneralTabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.title = item.title
    }
    
}
