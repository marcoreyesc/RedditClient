//
//  RedditItemViewController.swift
//  RedditClient
//
//  Created by MarcoReyes on 26/07/21.
//

import UIKit

class RedditItemDetailViewController: UIViewController {
    let redditItemDetailView: RedditItemDetailView

    init(redditChildData: RedditChildData, thumbnailImage: UIImage?) {
        self.redditItemDetailView = RedditItemDetailView(frame: .zero, redditChildData: redditChildData, thumbnailImage: thumbnailImage)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = redditItemDetailView
    }
}
