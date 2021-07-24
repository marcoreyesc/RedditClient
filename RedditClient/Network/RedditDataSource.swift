//
//  RedditDataSource.swift
//  RedditClient
//
//  Created by MarcoReyes on 24/07/21.
//

import Foundation

enum Result {
    case success(items: [RedditItem])
    case failure(error: Error)
}

typealias Callback = (Result) -> Void

final class RedditDataSource {

    var itemsFromService: (_ completion: Callback) -> Void = { (completion: Callback) in

    }
}
