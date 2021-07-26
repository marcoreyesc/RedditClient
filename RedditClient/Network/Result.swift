//
//  Result.swift
//  RedditClient
//
//  Created by MarcoReyes on 26/07/21.
//

import UIKit

enum Result {
    case success(items: RedditRoot)
    case failure(error: Error?)
}

enum ImageResult {
    case success(image: UIImage?)
    case failure(error: Error?)
}

enum NetworkError: Error {
    case deserializationError
    case dataIsNil
    case modelClassNotAvailable
}

typealias Callback = (Result) -> Void
typealias ImageCallback = (ImageResult) -> Void
