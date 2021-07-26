//
//  RedditRoot.swift
//  RedditClient
//
//  Created by MarcoReyes on 24/07/21.
//

import Foundation

// MARK: - RedditRoot
struct RedditRoot: Codable {
    let kind: String
    let data: RedditRootData
}

// MARK: - RedditRootData
struct RedditRootData: Codable {
    let children: [RedditChild]
    let after: String?
    let before: String?
}

// MARK: - Child
struct RedditChild: Codable {
    let kind: String
    let data: RedditChildData
}

// MARK: - ChildData
struct RedditChildData: Codable {
    let created: Double
    let author: String
    let title: String
    let createdUTC, ups, numComments: Int
    let thumbnail: String
    let mediaEmbed: MediaEmbed

    enum CodingKeys: String, CodingKey {
        case mediaEmbed = "media_embed"
        case author
        case thumbnail
        case created
        case title
        case createdUTC = "created_utc"
        case ups
        case numComments = "num_comments"
    }
}

// MARK: - MediaEmbed
struct MediaEmbed: Codable {
}
