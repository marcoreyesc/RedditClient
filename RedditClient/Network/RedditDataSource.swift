//
//  RedditDataSource.swift
//  RedditClient
//
//  Created by MarcoReyes on 24/07/21.
//

import Foundation

enum Result {
    case success(tiems: [RedditItem])
    case failure(error: Error)
}

typealias Callback = (Result) -> Void

final class RedditDataSource {


    func getItems(completion: Callback) {

    }
}
