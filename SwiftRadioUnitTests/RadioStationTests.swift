//
//  StationsViewController.swift
//  SwiftRadio
//
//  Created by Anna-Maria Shkarlinska on 08/06/16.
//  Copyright © 2016 CodeMarket.io. All rights reserved.
//

import XCTest

@testable import SwiftRadio

class RadioStationTests: XCTestCase {
    
    func testParseStation() {
        let data =
           [
            "name": "Radio 1190",
            "streamURL": "http://radio1190.colorado.edu:8000/high.mp3",
            "imageURL": "",
            "desc": "KVCU - Boulder, CO",
            "longDesc": "Radio 1190 is the bomb."
            ]
        let json = JSON(data)
        let parsedStation = RadioStation.parseStation(json)
        XCTAssert(parsedStation.isMemberOfClass(RadioStation), "Parse Station method should return RadioStation object")
        XCTAssertEqual(parsedStation.stationName, data["name"], "Parsed station name should be equal with data name")
    }
}