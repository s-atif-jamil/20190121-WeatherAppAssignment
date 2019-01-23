//
//  BaseModel.swift
//  WeatherApp
//
//  Created by Atif Jamil, Syed on 1/21/19.
//  Copyright © 2019 Atif Jamil, Syed. All rights reserved.
//

import Foundation

class BaseModel: NSObject {

    override init() {
        super.init()
    }
    
    init(json: [String:Any] ) {
        super.init()
        self.set(from: json)
    }
    
    func set(from json: [String:Any]) {
    }
    
}
