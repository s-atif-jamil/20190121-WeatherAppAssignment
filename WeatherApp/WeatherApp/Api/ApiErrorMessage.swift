//
//  ApiErrorMessage.swift
//  WeatherApp
//
//  Created by Atif Jamil, Syed on 1/19/19.
//  Copyright © 2019 Atif Jamil, Syed. All rights reserved.
//

import UIKit

enum ApiErrorMessage: String {
    case generalError = "Oops! something wrong"
    case parsingError = "Json could not be parsed"
    case timeout = "Please try again"
}

extension NSError {
    convenience init(apiError: ApiErrorMessage) {
        self.init(domain: "ApiError", code: apiError.hashValue, userInfo: [NSLocalizedDescriptionKey : apiError.rawValue])
    }
}
