//
//  RedditDataSourceTests.swift
//  RedditClientUITests
//
//  Created by MarcoReyes on 24/07/21.
//

import XCTest
@testable import RedditClient

class RedditDataSourceTests: XCTestCase {

    var redditDataSource = RedditDataSource()

    override func setUpWithError() throws {
        redditDataSource.itemsFromService = { (completion: Callback) in
            let redditChildData = RedditChildData(created: 19, author: "me", title: "title",
                                  createdUTC: 5, ups: 0, numComments: 0,
                                  thumbnail: "http", mediaEmbed: MediaEmbed())
            let redditChild = RedditChild(kind: "ss", data: redditChildData)

            let redditRootData = RedditRootData(children: [redditChild],
                                                after: "sas",
                                                before: "ssd")
            let redditRoot = RedditRoot(kind: "ss", data: redditRootData)
            completion(.success(items: redditRoot))
        }
    }

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
