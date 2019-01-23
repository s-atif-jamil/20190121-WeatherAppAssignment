//
//  AppError.swift
//  WeatherApp
//
//  Created by Atif Jamil, Syed on 1/21/19.
//  Copyright © 2019 Atif Jamil, Syed. All rights reserved.
//

import UIKit

enum AppError: String {
    case generalError = "Oops! something wrong"
    case parsingError = "Json could not be parsed"
    case timeoutError = "Please try again"
    case locationError = "Failed to get current locaiton"
    case cityNotFound = "City not found"
}

extension NSError {
    
    /// Convenience initializer which create Error based on AppError
    ///
    /// - Parameter appError: Put error localized description based on
    ///                       AppError raw value
    convenience init(appError: AppError) {
        self.init(domain: "AppError", code: appError.hashValue, userInfo: [NSLocalizedDescriptionKey : appError.rawValue])
    }
}
