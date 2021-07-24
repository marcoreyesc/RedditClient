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
            let item = RedditItem(created: 19,
                                  author: "me",
                                  title: "title",
                                  numComments: 5,
                                  thumbnail: "http")
            completion(.success(items: [item]))
        }
    }

    func testGetItems() throws {
        let expectation = self.expectation(description: "item list")

        var itemList: [RedditItem]?
        redditDataSource.itemsFromService { result in
            switch result {
            case .success(let items):
                itemList = items
            case .failure:
                itemList = nil
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)

        let list = try XCTUnwrap(itemList, "Item list is nil")
        XCTAssert(list.count > 0, "Title list is empty")
    }

    func testGetItems_model() throws {
        let expectation = self.expectation(description: "item list")

        var itemList: [RedditItem]?
        redditDataSource.itemsFromService { result in
            switch result {
            case .success(let items):
                itemList = items
            case .failure:
                itemList = nil
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 3)

        let redditItem = try XCTUnwrap(itemList?.first, "content nil")
        XCTAssert(!redditItem.author.isEmpty , "Author should not be blank")
        XCTAssert(!redditItem.title.isEmpty , "Title should not be blank")
        XCTAssert(!redditItem.thumbnail.isEmpty , "Thumbnail should not be blank")
        XCTAssert(redditItem.created > 0 , "Created should be greater than 0")
    }
}
