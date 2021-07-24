//
//  ReditDataSoruceTests.swift
//  RedditClientUITests
//
//  Created by MarcoReyes on 24/07/21.
//

import XCTest


class RedditDataSoruceTests: XCTestCase {

    var redditDataSoruce = RedditDataSource()

    func testGetItems() throws {
        let expectation = self.expectation(description: "item list")

        let itemList = redditDataSoruce.getItems() {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)

        XCTAssertNil(itemList)
    }
}
