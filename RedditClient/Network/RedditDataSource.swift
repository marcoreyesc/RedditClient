//
//  RedditDataSource.swift
//  RedditClient
//
//  Created by MarcoReyes on 24/07/21.
//

import Foundation
import UIKit

final class RedditDataSource {

    var dataTask: URLSessionDataTask?
    var downaloadDataTask: URLSessionDownloadTask?

    let defaultSession = URLSession(configuration: .default)
    let limit = 2

    //making an option paginator to allaw us requests without page requeriment
    private let paginator: Paginator?

    init(paginator: Paginator? = Paginator()) {
        self.paginator = paginator
    }

    lazy var itemsFromService: (_ completion: @escaping Callback) -> Void = { [weak self] (completion: @escaping Callback) in
        guard let self = self else {
            return
        }
        self.dataTask?.cancel()
        guard var urlComponents = URLComponents(string: "https://www.reddit.com/top.json") else {
            return
        }

        urlComponents.query = "limit=\(self.limit)\(self.paginator?.query ?? "")"
        guard let url = urlComponents.url else {
            return
        }

        self.dataTask = self.defaultSession.redditListTask(with: url) { [weak self] (redditRoot, response, error) in
            defer {
                self?.dataTask = nil
            }

            guard error == nil else {
                completion(.failure(error: error))
                return
            }

            guard let redditRoot = redditRoot else {
                completion(.failure(error: NetworkError.modelClassNotAvailable))
                return
            }

            self?.paginator?.after = redditRoot.data.after
            self?.paginator?.before = redditRoot.data.before
            DispatchQueue.main.async {
                completion(.success(items: redditRoot))
            }
        }

        self.dataTask?.resume()
    }

    lazy var imageFromService: (_ urlString: String, _ completion: @escaping ImageCallback) -> Void = { [weak self] (urlString: String, completion: @escaping ImageCallback) in
        guard let self = self else {
            return
        }
        self.downaloadDataTask?.cancel()
        guard var urlComponents = URLComponents(string: urlString) else {
            return
        }
        guard let url = urlComponents.url else {
            return
        }
        self.downaloadDataTask = self.defaultSession.imageTask(with: url) { [weak self] (image, error) in
            defer {
                self?.downaloadDataTask = nil
            }
            guard error == nil else {
                completion(.failure(error: error))
                return
            }

            DispatchQueue.main.async {
                completion(.success(image: image))
            }
        }
    }
}
