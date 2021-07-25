//
//  RedditListView.swift
//  RedditClient
//
//  Created by MarcoReyes on 25/07/21.
//

import UIKit

class RedditListView: UIView {
    var tableView: UITableView

    init (frame: CGRect, dataSource: UITableViewDataSource) {
        tableView = UITableView()
        super.init(frame: frame)
        tableView.register(RedditItemCell.self, forCellReuseIdentifier: RedditItemCell.reuseID)
        tableView.dataSource = dataSource
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        tableView.estimatedRowHeight = 88
        tableView.rowHeight = UITableView.automaticDimension

        tableView.separatorColor = .lightGray
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                tableView.topAnchor.constraint(equalTo: topAnchor),
                tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: bottomAnchor)]
        )
    }

    func reload() {
        tableView.reloadData()
    }
}
