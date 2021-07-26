//
//  RedditListView.swift
//  RedditClient
//
//  Created by MarcoReyes on 25/07/21.
//

import UIKit

class RedditListView: UIView {
    var tableView: UITableView
    let refreshControl = UIRefreshControl() // test making this weak

    lazy var dismissAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("Dismiss All", for: .normal)
        button.addTarget(self, action: #selector(didPressDismissAllButton), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .gray
        return button
    }()

    init (frame: CGRect, dataSource: UITableViewDataSource, refreshControl: UIRefreshControl) {
        tableView = UITableView()
        super.init(frame: frame)
        tableView.register(RedditItemCell.self, forCellReuseIdentifier: RedditItemCell.reuseID)
        tableView.dataSource = dataSource
        tableView.refreshControl = refreshControl
        backgroundColor = .white
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // TODO: - chnage this to call view controller in order to delete data soruce
    @objc func didPressDismissAllButton() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
            self.tableView.alpha = 0.0
            self.tableView.transform = .identity
        })
    }

    private func setupView() {
        tableView.estimatedRowHeight = 88
        tableView.rowHeight = 160
        tableView.separatorColor = .lightGray
        addSubview(tableView)
        addSubview(dismissAllButton)
        NSLayoutConstraint.activate(
            dismissAllButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor) +
            tableView.anchor(top: topAnchor, leading: leadingAnchor, bottom: dismissAllButton.topAnchor, trailing: trailingAnchor)
        )
    }

    func reload() {
        tableView.reloadData()
    }

    func indexPathOfButton(_ button: UIButton) -> IndexPath? {
        let point = button.convert(CGPoint.zero, to: tableView)
        guard let indexPath = tableView.indexPathForRow(at: point) else { return nil }
        return indexPath
    }

    func removeCell(ofButton button: UIButton) {
        guard let indexPath = indexPathOfButton(button) else {return}
        
        tableView.beginUpdates()
        tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .left)
        tableView.endUpdates()
    }
}
