//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Atif Jamil, Syed on 1/19/19.
//  Copyright © 2019 Atif Jamil, Syed. All rights reserved.
//

import XCTest
import CoreLocation
@testable import WeatherApp

class WeatherAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

 
    // Test London current weather forecst by coordinate.
    // Expecation:  Error must be nil
    //              City name must be "London, GB"
    func testLondonCurrentWeather() {
        // Define an expectation
        let apiExpectation = XCTestExpectation(description: "Test current Weather of London")

        let city = City("<Fill from Api>", 51.51, -0.13)

        // Calling Api
        ApiManager.requestTodayForcast(city: city) { (city, error) in
            XCTAssertNil(error)
            XCTAssertTrue(city?.name == "London, GB")
            apiExpectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled
        wait(for: [apiExpectation], timeout: 60.0)
    }


    // Test London current weather forecst by string.
    // Expecation:  Error must be nil
    //              City name must be "London, GB"
    func testLondonCurrentWeatherByString() {
        // Define an expectation
        let apiExpectation = XCTestExpectation(description: "Test current Weather of London")
        
        // Calling Api
        ApiManager.requestTodayForcast(query: "London") { (city, error) in
            XCTAssertNil(error)
            XCTAssertTrue(city?.name == "London, GB")
            apiExpectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled
        wait(for: [apiExpectation], timeout: 60.0)
    }
    

    // Test London 5 days weather forecst.
    // Expecation:  Error must be nil
    //              City forecast group count must be 5
    func testLondonForecastWeather() {
        // Define an expectation
        let apiExpectation = XCTestExpectation(description: "Test current Weather of London")
        
        let city = City("London, GB", 51.51, -0.13)

        // Calling Api
        ApiManager.request5DaysForcast(city: city) { (city, error) in
            XCTAssertNil(error)
            XCTAssertTrue(city?.forecast.count == 5)
            apiExpectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled
        wait(for: [apiExpectation], timeout: 60.0)
    }

}
