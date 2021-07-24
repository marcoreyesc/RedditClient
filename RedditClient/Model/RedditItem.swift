//
//  RedditItem.swift
//  RedditClient
//
//  Created by MarcoReyes on 24/07/21.
//

import Foundation


struct RedditItem: Codable {
    var created: Double
    var author: String
    var title: String
    var numComments: Int
    var thumbnail: String
}
