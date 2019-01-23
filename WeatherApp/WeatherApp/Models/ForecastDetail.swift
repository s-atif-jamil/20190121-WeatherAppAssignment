//
//  ForecastDetail.swift
//  WeatherApp
//
//  Created by Atif Jamil, Syed on 1/21/19.
//  Copyright © 2019 Atif Jamil, Syed. All rights reserved.
//

import Foundation

class ForecastDetail: BaseModel {
    var temprature: Double = 0.0
    var humidity: Double = 0.0
    var dateInfo: String = ""
    var timeInfo: String = ""
    var weatherInfo: String = ""
    var rainInfo: String = ""
    var windInfo: String = ""
    var imageLink: String = ""
    
    override func set(from json: [String:Any]) {
        super.set(from: json)
        
        if let main = json["main"] as? [String:Any] {
            self.temprature = main["temp"] as? Double ?? self.temprature
            self.humidity = main["humidity"] as? Double ?? self.humidity
        }
        
        if let weather = json["weather"] as? [[String:Any]] {
            self.weatherInfo = (weather.first?["description"] as? String ?? self.weatherInfo).capitalized
            self.imageLink = "http://openweathermap.org/img/w/\(weather.first?["icon"] as? String ?? "no-image").png"
        }
        
        if let rain = json["rain"] as? [String:Any] {
            self.rainInfo = String(format: "Rain: %.3f mm", rain["3h"] as? Double ?? 0.0)
        } else if let rain = json["snow"] as? [String:Any] {
            self.rainInfo = String(format: "Snow: %.3f mm", rain["3h"] as? Double ?? 0.0)
        } else {
            self.rainInfo = "Rain: --"
        }
        
        if let wind = json["wind"] as? [String:Any] {
            let unit = (AppData.shared.measureSystem == MeasureSystem.metric ? "meter/sec" : "miles/hour")
            self.windInfo = String(format: "Wind: %.2f %@", wind["speed"] as? Double ?? 0.0, unit)
        }
        
        if let timeInterval = json["dt"] as? Double {
            let datetime = Date(timeIntervalSince1970: timeInterval)
            self.dateInfo = DateFormatter("EEEE, dd MMMM, yyyy", "UTC").string(from: datetime)
            self.timeInfo = DateFormatter("h:mm a", "UTC").string(from: datetime)
        }
    }

}
