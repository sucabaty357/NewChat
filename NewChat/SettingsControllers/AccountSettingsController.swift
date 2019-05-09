//
//  AccountSettingsController.swift
//  NewChat
//
//  Created by DuongTrong on 5/9/19.
//  Copyright © 2019 DuongTrong. All rights reserved.
//

import UIKit
import FirebaseAuth

class AccountSettingsController: UIViewController {
    
    let accountSettingsTableView: UITableView = UITableView(frame: CGRect.zero, style: .grouped)
    
    let accountSettingsCellId = "userProfileCell"

    var firstSection = [( icon: UIImage(named: "Notification") , title: "Notifications and sounds", controller: SettingsController() as Any ),
                        ( icon: UIImage(named: "ChangeNumber") , title: "Change number", controller: SettingsController() as Any)]
    
    
    var secondSection = [/* ( icon: UIImage(named: "language") , title: "Язык", controller: nil), */
        ( icon: UIImage(named: "Storage") , title: "Data and storage", controller: StorageTableViewController()),
        ( icon: UIImage(named: "Logout") , title: "Log out", controller: nil)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        view.backgroundColor = UIColor.white
        view.addSubview(accountSettingsTableView)
        
        accountSettingsTableView.delegate = self
        accountSettingsTableView.dataSource = self
        accountSettingsTableView.backgroundColor = UIColor.white
        accountSettingsTableView.separatorStyle = .none
        accountSettingsTableView.isScrollEnabled = false
        accountSettingsTableView.register(AccountSettingsTableViewCell.self, forCellReuseIdentifier: accountSettingsCellId)
        setConstraints()
    }
    
    
    fileprivate func setConstraints() {
        accountSettingsTableView.translatesAutoresizingMaskIntoConstraints = false
        accountSettingsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        accountSettingsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        accountSettingsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        accountSettingsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    
    func logoutButtonTapped () {
        
        
        self.tabBarController?.selectedIndex = tabs.chats.rawValue
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        let destination = OnboardingController()
        
        let newNavigationController = UINavigationController(rootViewController: destination)
        newNavigationController.navigationBar.backgroundColor = .white
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = UIColor.white
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        newNavigationController.modalTransitionStyle = .coverVertical
        
        self.present(newNavigationController, animated: true, completion: nil)
        
    }
    
}

extension AccountSettingsController: UIScrollViewDelegate {}
extension AccountSettingsController: UITableViewDelegate {}


extension AccountSettingsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = accountSettingsTableView.dequeueReusableCell(withIdentifier: accountSettingsCellId, for: indexPath) as! AccountSettingsTableViewCell
        
        if indexPath.section == 0 {
            
            cell.icon.image = firstSection[indexPath.row].icon
            cell.title.text = firstSection[indexPath.row].title
        }
        
        if indexPath.section == 1 {
            
            cell.icon.image = secondSection[indexPath.row].icon
            cell.title.text = secondSection[indexPath.row].title
            
            if indexPath.row == secondSection.count - 1 {
                cell.accessoryType = .none
                
            }
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            
            let destination = firstSection[indexPath.row].controller//MessagesController()
            
            self.navigationController?.pushViewController(destination as! UIViewController, animated: true)
        }
        
        if indexPath.section == 1 {
            
            let destination = secondSection[indexPath.row].controller//MessagesController()
            
            if destination != nil {
                self.navigationController?.pushViewController(destination!  , animated: true)
            }
            
            if indexPath.row == secondSection.count - 1 {
                logoutButtonTapped()
                
            }
        }
        
        accountSettingsTableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return firstSection.count
        }
        if section == 1 {
            return secondSection.count
        } else {
            
            return 0
        }
    }
}
