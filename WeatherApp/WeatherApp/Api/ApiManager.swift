//
//  ApiManager.swift
//  WeatherApp
//
//  Created by Atif Jamil, Syed on 1/19/19.
//  Copyright © 2019 Atif Jamil, Syed. All rights reserved.
//

import UIKit
import CoreLocation

/// Manage the api request and return the result or error in callback
class ApiManager {

    static let session = URLSession.shared
    
    /// Base url of Weather Api
    static var weatherApiUrl: String = "http://api.openweathermap.org"
    
    /// Weather Api App Id
    static let weatherAppId = "c6e381d8c7ff98f0fee43775817cf6ad"
    
    /// AccessToken is not using in this application. But for larger app it set and use in headers
    static var accessToken: String = ""
    
    
    /// Requests today forcast api by city coordinates. On the sucess it try to parse json
    /// and set into given city model and finally callback to either city or error
    ///
    /// - Parameter callback: Its contain either city model means everything is
    ///                       sucess or error means its fails either in requesting or parsing
    static func requestTodayForcast(city: City, _ callback: @escaping (City?, Error?) -> Void) {
        
        let urlLink = """
        \(weatherApiUrl)/data/2.5/weather?\
        appid=\(weatherAppId)&\
        lat=\(city.latitude)&\
        lon=\(city.longitude)&\
        units=\(AppData.shared.measureSystem.rawValue)
        """
        
        var request = URLRequest(url: URL(string: urlLink)!, cachePolicy: .reloadIgnoringCacheData)
        request.httpMethod = "GET"
        session.dataTask(with: request) { (data, response, error) in

            guard error == nil else {
                DispatchQueue.main.async { callback(nil, error) }
                return
            }

            guard let json = (try? JSONSerialization.jsonObject(with: data ?? Data(), options: [])) as? [String:Any] else {
                DispatchQueue.main.async { callback(nil, NSError(appError: .parsingError)) }
                return
            }

            city.set(from: json)
            DispatchQueue.main.async {
                callback(city, nil)
            }

        }.resume()
    }

    
    /// Requests today forcast api by string query. On the sucess it try to parse json
    /// and initialize city model with that json and finally callback to either city or error
    ///
    /// - Parameter callback: Its contain either city model means everything is
    ///                       sucess or error means its fails either in requesting or parsing
    static func requestTodayForcast(query: String, _ callback: @escaping (City?, Error?) -> Void) {
        
        let urlLink = """
            \(weatherApiUrl)/data/2.5/weather?\
            appid=\(weatherAppId)&\
            q=\(query)&\
            units=\(AppData.shared.measureSystem.rawValue)
            """.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        var request = URLRequest(url: URL(string: urlLink)!, cachePolicy: .reloadIgnoringCacheData)
        request.httpMethod = "GET"
        session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                DispatchQueue.main.async { callback(nil, error) }
                return
            }
            
            guard let json = (try? JSONSerialization.jsonObject(with: data ?? Data(), options: [])) as? [String:Any] else {
                DispatchQueue.main.async { callback(nil, NSError(appError: .parsingError)) }
                return
            }
            
            guard json["cod"] as? String ?? "" != "404" else {
                DispatchQueue.main.async { callback(nil, NSError(appError: .cityNotFound)) }
                return
            }
            
            let city = City(json: json)
            DispatchQueue.main.async {
                callback(city, nil)
            }
            
            }.resume()
    }
    

    /// Requests five days forcast api by give city. On the sucess it try to parse json
    /// and set forcast of city model and finally callback to either city or error
    ///
    /// - Parameter callback: Its contain either city model with updated 5 days forcast
    ///                       or error means its fails either in requesting or parsing
    static func request5DaysForcast(city: City, _ callback: @escaping (City?, Error?) -> Void) {
        
        let urlLink = """
        \(weatherApiUrl)/data/2.5/forecast?\
        appid=\(weatherAppId)&\
        lat=\(city.latitude)&\
        lon=\(city.longitude)&\
        units=\(AppData.shared.measureSystem.rawValue)
        """

        var request = URLRequest(url: URL(string: urlLink)!, cachePolicy: .reloadIgnoringCacheData)
        request.httpMethod = "GET"
        session.dataTask(with: request) { (data, response, error) in

            guard error == nil else {
                DispatchQueue.main.async { callback(nil, error) }
                return
            }

            guard let json = (try? JSONSerialization.jsonObject(with: data ?? Data(), options: [])) as? [String:Any] else {
                DispatchQueue.main.async { callback(nil, NSError(appError: .parsingError)) }
                return
            }

            city.setForecast(from: json)
            DispatchQueue.main.async {
                callback(city, nil)
            }

        }.resume()
    }
    
}
