//
//  DateFormatter.swift
//  WeatherApp
//
//  Created by Atif Jamil, Syed on 1/22/19.
//  Copyright © 2019 Atif Jamil, Syed. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    /// convenience initializer to create Date Fromatter with format string
    ///
    /// - Parameters:
    ///   - format: date format string
    ///   - zone: Optional Time zone of date formatter
    convenience init(_ format: String, _ zone: String? = nil) {
        self.init()
        self.dateFormat = format
        if let zone = zone {
            self.timeZone = TimeZone(identifier: zone)
        }
    }
}
