//
//  AboutViewControllerTests.swift
//  SwiftRadio
//
//  Created by Anna-Maria Shkarlinska on 11/06/16.
//  Copyright © 2016 CodeMarket.io. All rights reserved.
//

import XCTest
@testable import SwiftRadio

class AboutViewControllerTests: XCTestCase {
    
    var aboutVC: AboutViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        aboutVC = storyboard.instantiateViewControllerWithIdentifier("about_vc") as! AboutViewController
        let _ = aboutVC.view //calling viewDidLoad()
    }
    
    override func tearDown() {
        self.aboutVC = nil
        super.tearDown()
    }
    
    func testViewExistence() {
        XCTAssertNotNil(aboutVC.view, "View should exist")
    }
}
