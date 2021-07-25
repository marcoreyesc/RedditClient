//
//  RedditDataSource.swift
//  RedditClient
//
//  Created by MarcoReyes on 24/07/21.
//

import Foundation

enum Result {
    case success(items: RedditRoot)
    case failure(error: Error?)
}

enum NetworkError: Error {
    case deserializationError
    case dataIsNil
    case modelClassNotAvailable
}

typealias Callback = (Result) -> Void

final class RedditDataSource {

    var dataTask: URLSessionDataTask?
    let defaultSession = URLSession(configuration: .default)

    lazy var itemsFromService: (_ completion: @escaping Callback) -> Void = { [weak self] (completion: @escaping Callback) in
        guard let self = self else {
            return
        }
        self.dataTask?.cancel()
        guard var urlComponents = URLComponents(string: "https://www.reddit.com/top.json") else {
            return
        }

        urlComponents.query = "limit=2"

        guard let url = urlComponents.url else {
            return
        }

        self.dataTask = self.defaultSession.RedditListTask(with: url) { [weak self] (redditRoot, response, error) in
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

            DispatchQueue.main.async {
                completion(.success(items: redditRoot))

            }
        }

        self.dataTask?.resume()
    }
}

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completionHandler(nil, response, error)
                return
            }
            guard let data = data else {
                completionHandler(nil, response, NetworkError.dataIsNil)
                return
            }

            guard let decoded = try? JSONDecoder().decode(T.self, from: data) else {
                completionHandler(nil, response, NetworkError.deserializationError)
                return
            }

            completionHandler(decoded, response, nil)
        }
    }

    func RedditListTask(with url: URL, completionHandler: @escaping (RedditRoot?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
