//
//  PHueDemoTests.swift
//  PHueDemoTests
//
//  Created by Liu Jinyu on 9/11/16.
//  Copyright © 2016 Liu Jinyu. All rights reserved.
//

import XCTest
import Alamofire

@testable import PHueDemo

class PHueDemoTests: XCTestCase {
    
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
        
           Alamofire.request(Router.PUTBri(200))
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}