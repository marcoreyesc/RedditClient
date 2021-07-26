//
//  RedditLitViewController.swift
//  RedditClient
//
//  Created by MarcoReyes on 25/07/21.
//

import UIKit

final class RedditLitViewController: UIViewController {
    let redditDataSource: RedditDataSource
    let redditListTableViewDataSource: RedditListTableViewDataSource
    let refreshControl = UIRefreshControl()

    lazy var redditListView: RedditListView = {
        let redditListView = RedditListView(frame: .zero, dataSource: redditListTableViewDataSource, refreshControl: refreshControl)
        redditListTableViewDataSource.redditListView = redditListView

        return redditListView
    }()

    init(redditDataSource: RedditDataSource = RedditDataSource(),
         redditListTableViewDataSource: RedditListTableViewDataSource = RedditListTableViewDataSource()) {
        self.redditDataSource = redditDataSource
        self.redditListTableViewDataSource = redditListTableViewDataSource
        super.init(nibName: nil, bundle: nil)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(didPull), for: .valueChanged)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadView() {
        view = redditListView
    }

    private func loadRedditChildren(completion: (() -> Void)? = nil) {
        redditDataSource.itemsFromService { [unowned self] result in
            defer {
                completion?()
            }

            switch result {
            case .success(let redditRoot):
                self.redditListTableViewDataSource.appendChildren(redditRoot.data.children)
            case .failure(let error):
                presentAlert(withTitle: "Error", message: error?.localizedDescription ?? "")
                break
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadRedditChildren()
    }

    @objc func didPull() {
        loadRedditChildren() { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }
}
