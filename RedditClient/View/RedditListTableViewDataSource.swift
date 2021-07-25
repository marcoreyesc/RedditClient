//
//  RedditListTableViewDataSource.swift
//  RedditClient
//
//  Created by MarcoReyes on 25/07/21.
//

import UIKit

final class RedditListTableViewDataSource: NSObject, UITableViewDataSource {
    weak var redditListView: RedditListView?

    var redditChildDataList: [RedditChild] = [] {
        didSet {
            redditListView?.reload()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return redditChildDataList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RedditItemCell.reuseID, for: indexPath) as? RedditItemCell else {
            fatalError("Unable to parse CartViewCell")
        }

        cell.config(redditChildData: redditChildDataList[indexPath.row].data)
        return cell
    }
}

