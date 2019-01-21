//
//  ApiManager.swift
//  WeatherApp
//
//  Created by Atif Jamil, Syed on 1/19/19.
//  Copyright © 2019 Atif Jamil, Syed. All rights reserved.
//

import UIKit

/// Manage the api request and return the result or error in callback
class ApiManager {

    /// Base url of Weather Api
    static let weatherApiUrl = "​http://api.openweathermap.org/data/2.5"
    
    /// Weather Api App Id
    static let weatherAppId = "c6e381d8c7ff98f0fee4377"
    
    /// AccessToken is not using in this application. But for larger app it set and use in headers
    static var accessToken: String = ""
    
}
