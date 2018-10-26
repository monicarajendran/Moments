//
//  MomentsTests.swift
//  MomentsTests
//
//  Created by Monica on 08/06/18.
//  Copyright © 2018 user. All rights reserved.
//

import XCTest

class MomentsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    } 
    
    func test_toDate() {
        
        let fridayOct = Int64(1540548940).toDate
        XCTAssert(fridayOct == Date(timeIntervalSince1970: TimeInterval(1540548940)))
    }
    
}
