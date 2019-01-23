//
//  ForecastGroup.swift
//  WeatherApp
//
//  Created by Atif Jamil, Syed on 1/21/19.
//  Copyright © 2019 Atif Jamil, Syed. All rights reserved.
//

import Foundation

class ForecastGroup: BaseModel {
    var dateInfo: String = ""
    var details: [ForecastDetail] = []

    class func group(by details:[ForecastDetail]) -> [ForecastGroup] {
        var dateInfo = ""
        var group = ForecastGroup()
        var groups: [ForecastGroup] = []

        for detail in details {
            if dateInfo != detail.dateInfo {
                dateInfo = detail.dateInfo
                group = ForecastGroup()
                group.dateInfo = dateInfo
                groups.append(group)
            }
            
            group.details.append(detail)
        }
        
        return groups
    }
    
}
