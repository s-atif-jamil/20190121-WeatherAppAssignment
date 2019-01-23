//
//  AppData.swift
//  WeatherApp
//
//  Created by Atif Jamil, Syed on 1/21/19.
//  Copyright © 2019 Atif Jamil, Syed. All rights reserved.
//

import UIKit

class AppData: NSObject {

    static let shared = AppData()
    var cityList: [City] = []
    var measureSystem: MeasureSystem = MeasureSystem.metric {
        didSet {
            self.saveMeasureSystem()
            NotificationCenter.default.post(name: NSNotification.Name.AppMeasureSytemChanged, object: measureSystem)
        }
    }

    override init() {
        super.init()
        self.loadMeasureSystem()
        self.loadBookmarkCityList()
    }
    
    func loadMeasureSystem() {
        guard let jsonString = UserDefaults.standard.string(forKey: "MeasureSystem") else { return }
        guard let jsonData = jsonString.data(using: .utf8) else { return }
        guard let measureSystem = try? JSONDecoder().decode(MeasureSystem.self, from: jsonData) else { return }
        self.measureSystem = measureSystem
    }
    
    func saveMeasureSystem() {
        guard let jsonData = try? JSONEncoder().encode(measureSystem) else { return }
        guard let jsonString = String(data: jsonData, encoding: .utf8) else { return }
        UserDefaults.standard.setValue(jsonString, forKey: "MeasureSystem")
        UserDefaults.standard.synchronize()
    }
    
    func loadBookmarkCityList() {
        guard let jsonString = UserDefaults.standard.string(forKey: "BookmarkCities") else { return }
        guard let jsonData = jsonString.data(using: .utf8) else { return }
        guard let cities = try? JSONDecoder().decode([City].self, from: jsonData) else { return }
        self.cityList = cities
    }
    
    func saveBookmarkCityList() {
        guard let jsonData = try? JSONEncoder().encode(cityList) else { return }
        guard let jsonString = String(data: jsonData, encoding: .utf8) else { return }
        UserDefaults.standard.setValue(jsonString, forKey: "BookmarkCities")
        UserDefaults.standard.synchronize()
    }

}

struct MeasureSystem: Codable, Equatable {
    var tag: Int = 0
    var rawValue: String = ""
    
    static let metric = MeasureSystem(tag: 0, rawValue: "metric")
    static let imperial = MeasureSystem(tag: 1, rawValue: "imperial")
}

extension NSNotification.Name {
    public static let AppMeasureSytemChanged = NSNotification.Name("AppMeasureSytemChanged")
}
