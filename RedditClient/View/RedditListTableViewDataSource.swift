//
//  RedditListTableViewDataSource.swift
//  RedditClient
//
//  Created by MarcoReyes on 25/07/21.
//

import UIKit

final class RedditListTableViewDataSource: NSObject, UITableViewDataSource {
    weak var redditListView: RedditListView?

    var remoteDataSource = RedditDataSource()

    var removingItem = false
    private var redditChildDataList: [RedditChild] = [] {
        didSet {
            if !removingItem {
                redditListView?.reload()
            }
        }
    }

    func appendChildren(_ data: [RedditChild]) {
        redditChildDataList.append(contentsOf: data)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return redditChildDataList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RedditItemCell.reuseID, for: indexPath) as? RedditItemCell else {
            fatalError("Unable to parse CartViewCell")
        }

        cell.config(redditChildData: redditChildDataList[indexPath.row].data)
        downLoadImage(tableView,
                      url: redditChildDataList[indexPath.row].data.thumbnail,
                      inIndexPath: indexPath)
        cell.delegate = self
        return cell
    }

    // TODO: - Change default Images from view did load
    // TODO: - Add some cache system for images
    func downLoadImage(_ tableView: UITableView, url: String, inIndexPath indexPath: IndexPath) {
        remoteDataSource.imageFromService(url) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let image):
                self.displayImage(tableView, image: image, indexPath: indexPath)
            case .failure:
                self.displayImage(tableView, image: UIImage.add, indexPath: indexPath)
            }
        }
    }

    func displayImage(_ tableView: UITableView, image: UIImage?, indexPath: IndexPath) {
        DispatchQueue.main.async {
            if let cell = tableView.cellForRow(at: indexPath) as? RedditItemCell {
                cell.displayImage(image)
            }
        }
    }
}

extension RedditListTableViewDataSource: RedditItemCellDelegate {
    func didPressDeleteButton(sender: RedditItemCell) {
        guard let indexPath = redditListView?.indexPathOfButton(sender.deleteButton) else {
            return
        }
        removingItem = true
        redditChildDataList.remove(at: indexPath.row)
        removingItem = false
        redditListView?.removeCell(ofButton: sender.deleteButton)
    }
}
