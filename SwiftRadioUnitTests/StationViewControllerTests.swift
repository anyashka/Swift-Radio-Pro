//
//  StationViewControllerTests.swift
//  SwiftRadio
//
//  Created by Anna-Maria Shkarlinska on 09/06/16.
//  Copyright © 2016 CodeMarket.io. All rights reserved.
//

import XCTest
@testable import SwiftRadio


class StationViewControllerTests: XCTestCase {

    var stationVC: StationsViewController!

    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        stationVC = storyboard.instantiateViewControllerWithIdentifier("stations_vc") as! StationsViewController
        let _ = stationVC.view //calling viewDidLoad()
    }
    
    override func tearDown() {
        self.stationVC = nil
        super.tearDown()
    }

    func testViewExistence() {
        XCTAssertNotNil(stationVC.view, "View should exist")
    }
    
    func testThatTableViewLoads() {
        XCTAssertNotNil(stationVC.tableView)
    }
    
    func testThatViewConformsToUISearchResultsUpdatingProtocol() {
         XCTAssert(stationVC.conformsToProtocol(UISearchResultsUpdating), "View should conform to UISearchResultsUpdating protocol")
    }
    
    func testSetupPullToRefresh() {
        let refreshControll = stationVC.refreshControl
        
        XCTAssert(refreshControll.allTargets().count == 1, "Refresh Controll should have one target")
        XCTAssertNotNil(refreshControll, "Refresh Controll shouldn't be nil")
        XCTAssert(stationVC.tableView.subviews.contains(refreshControll), "Table View did add Refresh Controll as a subview")
    }
    
    func testCreateNowPlayingAnimation() {
        let animation = stationVC.nowPlayingAnimationImageView
        let expectedAnimationDuration = 0.7
       XCTAssertNotNil(animation.animationImages, "Image View should have animation images")
        XCTAssertEqual(animation.animationDuration, expectedAnimationDuration, "Animation duration should be 0.7")
    }
    
    func testCreateNowPlayingBarButton() {
        let button = stationVC.navigationItem.rightBarButtonItem
        if stationVC.firstTime == false {
            let expectedButtonImage = UIImage(named: "btn-nowPlaying")
            XCTAssertNotNil(button, "Right bar button item should exist in Navigation Bar")
            XCTAssertEqual(button?.image, expectedButtonImage, "Image should be properly assigned to button")
        }
    }

    //MARK: TableView Tests
    
    func testParentViewHasTableViewSubview() {
        let subviews = stationVC.view.subviews
        XCTAssert(subviews.contains(stationVC.tableView), "View should have a table view as a subview")
    }
    
    func testThatViewConformsToUITableViewDataSource() {
        XCTAssert(stationVC.conformsToProtocol(UITableViewDataSource), "View should conform to UITableView datasource protocol")
    }
    
    
    func testTableViewDataSource() {
        XCTAssertNotNil(stationVC.tableView.dataSource, "Table View datasource shouldn't be nil")
    }
    
    func testTableViewIsConnectedToDelegate() {
        XCTAssertNotNil(stationVC.tableView.delegate, "Table delegate shouldn't be nil")
    }

    
    func testNumberOfSectionsInTableView() {
        let expectedNumberOfSections = 1
        XCTAssertEqual(stationVC.tableView.numberOfSections, expectedNumberOfSections, "Table View should have \(expectedNumberOfSections) sections")
    }
    
    func testHeightForRowAtIndexPath() {
        let expectedHeight = CGFloat(88)
        let actualHeight = stationVC.tableView.rowHeight
        XCTAssertEqual(actualHeight, expectedHeight, "Height of the row shoud be \(expectedHeight)")
    }
    
    func testCellForRowAtIndexPath() {
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        let cell = stationVC.tableView.cellForRowAtIndexPath(indexPath)
        stationVC.stations.removeAll()
        XCTAssertEqual(cell?.reuseIdentifier, "NothingFound")
        stationVC.stations.append(RadioStation(name: "Name", streamURL: "http://radio1190.colorado.edu:8000/high.mp3",
            imageURL: "",
            desc: "KVCU - Boulder, CO"))
        XCTAssertEqual(cell?.reuseIdentifier, "StationCell")
    }
    
}
