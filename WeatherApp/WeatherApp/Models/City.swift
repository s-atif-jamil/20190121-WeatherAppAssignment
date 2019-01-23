//
//  City.swift
//  WeatherApp
//
//  Created by Atif Jamil, Syed on 1/21/19.
//  Copyright © 2019 Atif Jamil, Syed. All rights reserved.
//

import Foundation

class City: BaseModel, Codable {
    var name: String = ""
    var weatherInfo: String = ""
    var imageLink: String = ""
    var temprature: Double = 0.0
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var forecast: [ForecastGroup] = []
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case latitude = "latitude"
        case longitude = "longitude"
    }

    
    // MARK: - Initializer
    
    required init(from decoder: Decoder) throws {
        super.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = (try? values.decode(String.self, forKey: .name)) ?? ""
        latitude = (try? values.decode(Double.self, forKey: .latitude)) ?? 0.0
        longitude = (try? values.decode(Double.self, forKey: .longitude)) ?? 0.0
    }
    
    required init(_ name: String, _ latitude: Double, _ longitude: Double) {
        super.init()
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    override init(json: [String : Any]) {
        super.init(json: json)
    }
    
    
    // MARK: - Setter Methods
    
    override func set(from json: [String : Any]) {
        super.set(from: json)
        
        self.name = json["name"] as? String ?? self.name

        if let sys = json["sys"] as? [String:Any], let country = sys["country"] as? String {
            self.name = "\(self.name), \(country)"
        }
        
        if let main = json["main"] as? [String:Any] {
            self.temprature = main["temp"] as? Double ?? self.temprature
        }

        if let coord = json["coord"] as? [String:Any] {
            self.latitude = coord["lat"] as? Double ?? self.latitude
            self.longitude = coord["lon"] as? Double ?? self.longitude
        }
        
        if let weather = json["weather"] as? [[String:Any]] {
            self.weatherInfo = (weather.first?["description"] as? String ?? self.weatherInfo).capitalized
            self.imageLink = "http://openweathermap.org/img/w/\(weather.first?["icon"] as? String ?? "no-image").png"
        }
        
    }
    
    func setForecast(from json:[String:Any]) {
        guard let list = json["list"] as? [[String:Any]] else { return }
        
        var forecastDetails: [ForecastDetail] = []
        for item in list {
            forecastDetails.append(ForecastDetail(json: item))
        }
        
        self.forecast = ForecastGroup.group(by: forecastDetails)
    }
    
}
