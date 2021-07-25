//
//  Paginator.swift
//  RedditClient
//
//  Created by MarcoReyes on 25/07/21.
//

import Foundation

final class Paginator {
    var after, before: String?

    var query: String {
        var queryString = ""
        if let after = after {
            queryString.append("&after=\(after)")
        }
        if let before = before {
            queryString.append("&before=\(before)")
        }
        return queryString
    }
}
