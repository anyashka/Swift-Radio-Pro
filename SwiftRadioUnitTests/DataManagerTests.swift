//
//  DataManagerTests.swift
//  SwiftRadio
//
//  Created by Anna-Maria Shkarlinska on 08/06/16.
//  Copyright © 2016 CodeMarket.io. All rights reserved.
//

import XCTest


@testable import SwiftRadio

class DataManagerTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        //  This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGetStationDataWithSuccess() {
        let expectation = expectationWithDescription("GET Station Data With Success")
        DataManager.getDataFromFileWithSuccess() { data in
            
            XCTAssertNotNil(data, "data should be nil")
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(10) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testDataFromFileWithSuccess(){
        DataManager.getDataFromFileWithSuccess(){ data in
            let testBundle = NSBundle.mainBundle()
            let filePath = testBundle.pathForResource("stations", ofType:"json")
            XCTAssertNotNil(filePath, "Local file shouldn't be nil")
           // XCTAssertNotNil(data, "data should be nil")
            if let dataFromFile = NSData(contentsOfFile: filePath!){
                XCTAssertEqual(dataFromFile, data)
            } else {
                XCTFail("There was no data in the file")
            }
        }
        
    }
    
    func testGetTrackDataWithSuccess() {
        DataManager.getTrackDataWithSuccess("google.com"){ data in
            XCTFail()
        }
    }
    
    func testLoadDataFromURL(){
        let URL = NSURL(string: "http://nshipster.com/")!
        let expectation = expectationWithDescription("Load data from \(URL)")
        let _ = DataManager.loadDataFromURL(URL) { data, error in
            XCTAssertNotNil(data, "data should not be nil")
            XCTAssertNil(error, "error should be nil")
            // Use NSURLSession to get data from an NSURL
            let expectation = self.expectationWithDescription("GET \(URL)")
            let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
            let session = NSURLSession(configuration: sessionConfig)
            let loadDataTask = session.dataTaskWithURL(URL){ data, response, error in

            if let HTTPResponse = response as? NSHTTPURLResponse,
                responseURL = HTTPResponse.URL,
                MIMEType = HTTPResponse.MIMEType
            {
                XCTAssertEqual(responseURL.absoluteString, URL.absoluteString, "HTTP response URL should be equal to original URL")
                XCTAssertEqual(HTTPResponse.statusCode, 200, "HTTP response status code should be 200")
                XCTAssertEqual(MIMEType, "text/html", "HTTP response content type should be text/html")
            } else {
                XCTFail("Response was not NSHTTPURLResponse")
            }
            }
            expectation.fulfill()
        
        
        loadDataTask.resume()
        self.waitForExpectationsWithTimeout(loadDataTask.originalRequest!.timeoutInterval) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        loadDataTask.cancel()
            }
            
    }
        expectation.fulfill()

    waitForExpectationsWithTimeout(10) { error in
        if let error = error {
            print("Error: \(error.localizedDescription)")
        }
      }
    }
}