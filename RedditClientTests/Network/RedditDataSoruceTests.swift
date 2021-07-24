//
//  ReditDataSoruceTests.swift
//  RedditClientUITests
//
//  Created by MarcoReyes on 24/07/21.
//

import XCTest
@testable import RedditClient

class RedditDataSoruceTests: XCTestCase {

    var redditDataSoruce = RedditDataSource()

    override func setUpWithError() throws {
        redditDataSoruce.itemsFromService = { (completion: Callback) in
            completion(.success(tiems: []))
        }
    }

    func testGetItems() throws {
        let expectation = self.expectation(description: "item list")

        var itemList: [RedditItem]?
        redditDataSoruce.itemsFromService { result in
            switch result {
            case .success(let tiems):
                itemList = tiems
            case .failure:
                itemList = nil
            }

//            items = result.
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)

        XCTAssertNil(itemList)
    }
}
