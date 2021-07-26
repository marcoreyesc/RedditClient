//
//  URLSessionExtension.swift
//  RedditClient
//
//  Created by MarcoReyes on 26/07/21.
//

import UIKit

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

    func imageTask(with url: URL, completion: @escaping (UIImage?, Error?)->Void) -> URLSessionDownloadTask? {
            let task = URLSession.shared.downloadTask(with: url) { (path, response, error) in
                guard error == nil else {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                    return
                }
                guard let url = path, let data = try? Data(contentsOf: url) else {
                    DispatchQueue.main.async {
                        completion(nil, nil)
                    }
                    return
                }

                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    completion(image, nil)
                }
            }
            task.resume()
            return task
        }

    func redditListTask(with url: URL, completionHandler: @escaping (RedditRoot?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
