//
//  SwiftRadioUITests.swift
//  SwiftRadioUITests
//
//  Created by Jonah Stiennon on 12/3/15.
//  Copyright © 2015 CodeMarket.io. All rights reserved.
//

import XCTest

class SwiftRadioUITests: XCTestCase {
    
    let app = XCUIApplication()
    let stations = XCUIApplication().cells
    let hamburgerMenu = XCUIApplication().navigationBars["Swift Radio"].buttons["icon hamburger"]
    let pauseButton = XCUIApplication().buttons["btn pause"]
    let playButton = XCUIApplication().buttons["btn play"]
    let volume = XCUIApplication().sliders.elementBoundByIndex(0)
    
    override func setUp() {
        super.setUp()
        
        // This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        XCUIApplication().launch()

        // wait for the main view to load
        self.expectationForPredicate(
            NSPredicate(format: "self.count > 0"),
            evaluatedWithObject: stations,
            handler: nil)
        self.waitForExpectationsWithTimeout(10.0, handler: nil)
        
    }
    
    override func tearDown() {
   
        super.tearDown()
    }
    
    func assertStationsPresent() {
        let numStations:UInt = 4
        XCTAssertEqual(stations.count, numStations)
        
        let texts = stations.staticTexts.count
        XCTAssertEqual(texts, numStations * 2)
    }
    
    func assertHamburgerContent() {
        XCTAssertTrue(app.staticTexts["Created by: Matthew Fecher"].exists)
    }
    
    func assertAboutContent() {
        XCTAssertTrue(app.buttons["email me"].exists)
        XCTAssertTrue(app.buttons["matthewfecher.com"].exists)
    }
    
    func assertPaused() {
        XCTAssertFalse(pauseButton.enabled)
        XCTAssertTrue(playButton.enabled)
        XCTAssertTrue(app.staticTexts["Station Paused..."].exists);
    }
    
    func assertPlaying() {
        XCTAssertTrue(pauseButton.enabled)
        XCTAssertFalse(playButton.enabled)
        XCTAssertFalse(app.staticTexts["Station Paused..."].exists);
    }
    
    func assertStationOnMenu(stationName:String) {
        let button = app.buttons["nowPlaying"];
        if let value:String = button.label {
            XCTAssertTrue(value.containsString(stationName))
        } else {
            XCTAssertTrue(false)
        }
    }
    
    func assertStationInfo() {
        let textView = app.textViews.elementBoundByIndex(0)
        if let value = textView.value {
            XCTAssertGreaterThan(value.length, 10)
        } else {
            XCTAssertTrue(false)
        }
    }
    
    func waitForStationToLoad() {
        self.expectationForPredicate(
            NSPredicate(format: "exists == 0"),
            evaluatedWithObject: app.staticTexts["Loading Station..."],
            handler: nil)
        self.waitForExpectationsWithTimeout(25.0, handler: nil)

    }
    
    func testMainStationsView() {
        assertStationsPresent()
        
        hamburgerMenu.tap()
        assertHamburgerContent()
        app.buttons["About"].tap()
        assertAboutContent()
        app.buttons["Okay"].tap()
        app.buttons["btn close"].tap()
        assertStationsPresent()
        
        let firstStation = stations.elementBoundByIndex(0)
        let stationName:String = firstStation.childrenMatchingType(.StaticText).elementBoundByIndex(0).label
        assertStationOnMenu("Choose")
        firstStation.tap()
        waitForStationToLoad();
        
        pauseButton.tap()
        assertPaused()
        playButton.tap()
        assertPlaying()
        app.navigationBars["Sub Pop Radio"].buttons["Back"].tap()
        assertStationOnMenu(stationName)
        app.navigationBars["Swift Radio"].buttons["btn nowPlaying"].tap()
        waitForStationToLoad()
        volume.adjustToNormalizedSliderPosition(0.2)
        volume.adjustToNormalizedSliderPosition(0.8)
        volume.adjustToNormalizedSliderPosition(0.5)
        app.buttons["More Info"].tap()
        assertStationInfo()
        app.buttons["Okay"].tap()
        app.buttons["logo"].tap()
        assertAboutContent()
        app.buttons["email me"].tap()
        app.navigationBars["From Swift Radio App"].buttons["Cancel"].tap()
        app.buttons["Okay"].tap()

        app.navigationBars["Sub Pop Radio"].buttons["Back"].tap()

        
        app.tables.staticTexts["Sounds of the 80s"].swipeDown()
        app.otherElements.containingType(.NavigationBar, identifier:"Swift Radio").childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Table).element.tap()
        app.navigationBars["Swift Radio"].buttons["icon hamburger"].tap()
 
        let searchSearchField = app.tables.searchFields["Search"]
        searchSearchField.tap()
        app.searchFields["Search"]
        
        let element = app.otherElements.containingType(.NavigationBar, identifier:"Swift Radio").childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).elementBoundByIndex(1)
        element.tap()
        app.navigationBars["Spaceland Radio"].childrenMatchingType(.Button).elementBoundByIndex(0).tap()
        
        let searchSearchField2 = app.searchFields["Search"]
        searchSearchField2.buttons["Clear text"].tap()
        searchSearchField2.tap()
        app.searchFields["Search"]
        let cancelButton = app.buttons["Cancel"]
        cancelButton.tap()
        searchSearchField.tap()
        element.tap()
        cancelButton.tap()
        

    }
    
}
