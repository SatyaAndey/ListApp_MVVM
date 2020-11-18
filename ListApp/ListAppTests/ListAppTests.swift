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
        wait(for: [promise], timeout: 5)
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
    
    
    
    // Test case for loading modle from local json file.
    
    func testLoadModelFromLocalData() {
        // Given
        var dataModel = List.APIList.Response()
        if let jsonPath = Bundle(for: self.classForCoder).path(forResource: "facts", ofType: "json") {
            if let data = NSData(contentsOfFile: jsonPath) {
                do {
                    if let stringResponse =  String(data: data as Data, encoding: .ascii)  {
                        if let dataLocal = stringResponse.data(using: .utf8) {
                            dataModel =  try JSONDecoder().decode( List.APIList.Response.self, from: dataLocal as Data)
                        }
                    }
                    
                } catch _ {
                    
                }
            }
        }
        
        // When
        
        let records = dataModel.rows
        
        // Then
        XCTAssertEqual(records?.count ?? 0, 14, "There is a issue while mapping data to given model")
    }
    
    
    // Test case for test ListControllerViewModel and ListControllerTablevieDataSource with local json data.
    
    func testViewModelAndTableviewDataSource() {
        // Given
        var dataModel = List.APIList.Response()
        if let jsonPath = Bundle(for: self.classForCoder).path(forResource: "facts", ofType: "json") {
            if let data = NSData(contentsOfFile: jsonPath) {
                do {
                    if let stringResponse =  String(data: data as Data, encoding: .ascii)  {
                        if let dataLocal = stringResponse.data(using: .utf8) {
                            dataModel =  try JSONDecoder().decode( List.APIList.Response.self, from: dataLocal as Data)
                        }
                    }
                    
                } catch _ {
                    
                }
            }
        }
        
        
        //When
        let viewModel = ListControllerViewModel()
        viewModel.viewModel = dataModel.rows ?? [List.APIList.ViewModel]()
        
        // then
        let dataSource = ListControllerTableViewDataSource()
        dataSource.listItems = viewModel.viewModel
        let tableView = UITableView()
        tableView.dataSource = dataSource
        XCTAssert(tableView.numberOfRows(inSection: 0) > 0, "There are no cells in Tableview")
    }
    
    
}
