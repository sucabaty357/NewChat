//
//  Country.swift
//  NewChat
//
//  Created by DuongTrong on 5/9/19.
//  Copyright © 2019 DuongTrong. All rights reserved.
//

import UIKit

class Country: NSObject {
    
    var countries = [[String : String]]()
    
    override init() {
        super.init()
        
        fetchCountries()
    }
    
    func fetchCountries () {
        let path = Bundle.main.path(forResource: "CallingCodes", ofType: "plist")!
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil)
        countries = plist as! [[String : String]]
    }
}
