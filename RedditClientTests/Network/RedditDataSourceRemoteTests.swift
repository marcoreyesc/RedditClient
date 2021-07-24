//
//  RedditDataSourceRemoteTests.swift
//  RedditClientTests
//
//  Created by MarcoReyes on 24/07/21.
//

import XCTest
@testable import RedditClient

// TODO: - Extract this class to another target to have a separation between unit testing and fuctional testing
class RedditDataSourceRemoteTests: XCTestCase {

    var redditDataSource = RedditDataSource()

    func testGetItems() throws {
        let expectation = self.expectation(description: "item list")

        var root: RedditRoot?
        redditDataSource.itemsFromService { result in
            switch result {
            case .success(let redditRoot):
                root = redditRoot
            case .failure:
                root = nil
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)

        let item = try XCTUnwrap(root, "Item list is nil")
        XCTAssert(item.data.children.count > 0, "Title list is empty")
    }

    // TODO: - extract a model validator to dont repat assertion code
    func testGetItems_model() throws {
        let expectation = self.expectation(description: "item list")

        var root: RedditRoot?
        redditDataSource.itemsFromService { result in
            switch result {
            case .success(let redditRoot):
                root = redditRoot
            case .failure:
                root = nil
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 3)

        let item = try XCTUnwrap(root, "Item list is nil")

        let redditItem = try XCTUnwrap(item.data.children.first, "content nil")
        XCTAssert(!redditItem.data.author.isEmpty , "Author should not be blank")
        XCTAssert(!redditItem.data.title.isEmpty , "Title should not be blank")
        XCTAssert(!redditItem.data.thumbnail.isEmpty , "Thumbnail should not be blank")
        XCTAssert(redditItem.data.created > 0 , "Created should be greater than 0")
    }
}
