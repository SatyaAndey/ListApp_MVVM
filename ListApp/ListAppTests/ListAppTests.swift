//
//  ListAppTests.swift
//  ListAppTests
//
//  Created by Satya on 12/11/20.
//  Copyright © 2020 Satya. All rights reserved.
//

import XCTest
@testable import ListApp

class ListAppTests: XCTestCase {
    var sut: ListController!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = ListController()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // Test case for Api servie with different request and success and failure handling
    
    func testApiCallWithProperRequest() {
        // we have to check with different urls and offline and online conditions
        //Given
        let request = List.APIList.Request(url: BASE_URL)
        let promise = expectation(description: "API List Items fetched successfully")
        
        //When
        sut.listViewModel.fetchApiItmsList(request) { (response) in
        }
        
        // then
        sut.listViewModel.apiResponseCompletionhandler = { (response) in
            if response?.success == 1 {
                promise.fulfill()
            } else {
                XCTFail("Error: \(response?.errorMessage ?? "")")
            }

        }
        wait(for: [promise], timeout: 10)
    }
    
    
    // Test case for Network reachability
    
    func testNetworkReachability() {
        //Given
        let utility = Utility.sharedInstance
        
        //When
        let isReachable = utility.isNetworkReachable
        
        //Then
        XCTAssertEqual(isReachable, true, NO_NETWORK_MESSAGE)

    }
    

    
}
