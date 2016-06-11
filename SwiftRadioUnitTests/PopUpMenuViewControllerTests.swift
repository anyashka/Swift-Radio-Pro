//
//  PopUpMenuViewControllerTests.swift
//  SwiftRadio
//
//  Created by Anna-Maria Shkarlinska on 09/06/16.
//  Copyright © 2016 CodeMarket.io. All rights reserved.
//

import XCTest
@testable import SwiftRadio

class PopUpMenuViewControllerTests: XCTestCase {

    var popUpVC: PopUpMenuViewController!
    
    override func setUp() {
        super.setUp()
        
        //Setting up tests
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
    popUpVC = storyboard.instantiateViewControllerWithIdentifier("menu_vc") as! PopUpMenuViewController
        let _ = popUpVC.view
        
    }
    
    override func tearDown() {
        // This method is called after the invocation of each test method in the class.
        super.tearDown()
    }


    func testControllerView() {
         XCTAssertNotNil(popUpVC.view,"View should exist")
         XCTAssert(popUpVC.modalPresentationStyle == .Custom, "Modal Presentation style should be custom")
    }
    
    func testPopUpViewExists() {
         XCTAssertNotNil(popUpVC.popupView,"Alert view should exist")
    }
    
    func testBackgroundView() {
        XCTAssertNotNil(popUpVC.backgroundView,"Background view should exist")
        XCTAssert(popUpVC.backgroundView.userInteractionEnabled, "User Interaction should be enabled on background view")
        XCTAssert(popUpVC.backgroundView.gestureRecognizers?.count == 1, "Background View should have one gesture recognizer")
    }
    
}
