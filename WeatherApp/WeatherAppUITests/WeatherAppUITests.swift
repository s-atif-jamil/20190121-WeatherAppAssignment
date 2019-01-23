//
//  WeatherAppUITests.swift
//  WeatherAppUITests
//
//  Created by Atif Jamil, Syed on 1/19/19.
//  Copyright © 2019 Atif Jamil, Syed. All rights reserved.
//

import XCTest

class WeatherAppUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDeleteAllBookmarkCities() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let weatherappHomeviewNavigationBar = app.navigationBars["WeatherApp.HomeView"]
        weatherappHomeviewNavigationBar.children(matching: .button).element(boundBy: 2).tap()
        
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.buttons["Delete all Cities"].tap()
        app.alerts["Confirm"].buttons["Yes"].tap()
        elementsQuery.buttons["Metric (celsius, meter/sec) "].tap()
        app.navigationBars["Settings"].children(matching: .button).element.tap()
    }

}
