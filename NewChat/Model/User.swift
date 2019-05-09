//
//  User.swift
//  NewChat
//
//  Created by Thinh Nguyen on 5/9/19.
//  Copyright © 2019 DuongTrong. All rights reserved.
//

import UIKit

class User: NSObject {

    var id: String?
    var name: String?
    var photoURL: String?
    var phoneNumber: String?
    
    init(dictionary: [String: AnyObject]) {
        self.id = dictionary["id"] as? String
        self.name = dictionary["name"] as? String
        self.photoURL = dictionary["photoURL"] as? String
        self.phoneNumber = dictionary["phoneNumber"] as? String
        
    }
}
