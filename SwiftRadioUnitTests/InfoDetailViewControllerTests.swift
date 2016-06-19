//
//  InfoDetailViewControllerTests.swift
//  SwiftRadio
//
//  Created by Anna-Maria Shkarlinska on 09/06/16.
//  Copyright © 2016 CodeMarket.io. All rights reserved.
//
//
import XCTest
@testable import SwiftRadio

class InfoDetailViewControllerTests: XCTestCase {

    var infoVC: InfoDetailViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        infoVC = storyboard.instantiateViewControllerWithIdentifier("info_vc") as! InfoDetailViewController
        let _ = infoVC.view //calling viewDidLoad()
    }
    
    override func tearDown() {
        //  This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testControllerViewExists() {
        XCTAssertNotNil(infoVC.view,"View should exist")
    }
}
