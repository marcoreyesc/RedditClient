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

    init (frame: CGRect, dataSource: UITableViewDataSource, refreshControl: UIRefreshControl) {
        tableView = UITableView()
        super.init(frame: frame)
        tableView.register(RedditItemCell.self, forCellReuseIdentifier: RedditItemCell.reuseID)
        tableView.dataSource = dataSource
        tableView.refreshControl = refreshControl
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        tableView.estimatedRowHeight = 88
        tableView.rowHeight = 160
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
