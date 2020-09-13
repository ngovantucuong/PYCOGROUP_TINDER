//
//  PYCOGROUP_TINDERTests.swift
//  PYCOGROUP_TINDERTests
//
//  Created by ngovantucuong on 9/10/20.
//  Copyright © 2020 ngovantucuong. All rights reserved.
//

import XCTest
@testable import PYCOGROUP_TINDER

class PYCOGROUP_TINDERTests: XCTestCase {

    var sut: URLSession!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = URLSession(configuration: .default)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
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
    
    func testApiData() {
      let url = URL(string: "https://randomuser.me/api/?results=50")
      let promise = expectation(description: "Status code: 200")
      let dataTask = sut.dataTask(with: url!) { data, response, error in
        if let error = error {
          XCTFail("Error: \(error.localizedDescription)")
          return
        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
            XCTAssertEqual(statusCode, 200)
            promise.fulfill()
        }
      }
      dataTask.resume()
      wait(for: [promise], timeout: 5)
    }

}
