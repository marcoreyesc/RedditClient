//
//  RedditItemCell.swift
//  RedditClient
//
//  Created by MarcoReyes on 25/07/21.
//

import UIKit

final class RedditItemCell: UITableViewCell {
    let createdLabel: UILabel = {return UILabel()}()
    let authorLabel: UILabel = {return UILabel()}()
    let titleLabel: UILabel = {return UILabel()}()
    let numCommentsLabel: UILabel = {return UILabel()}()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        let stack = UIStackView(arrangedSubviews: [createdLabel, authorLabel, titleLabel, numCommentsLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        contentView.addSubview(stack)
        NSLayoutConstraint.activate(
            [stack.topAnchor.constraint(equalTo: contentView.topAnchor),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)]
        )
    }

    func config(redditChildData: RedditChildData) {
        createdLabel.text = "\(redditChildData.created)"
        authorLabel.text = redditChildData.author
        titleLabel.text = redditChildData.title
        numCommentsLabel.text = "\(redditChildData.numComments)"
    }

    static var reuseID: String {
        return String(describing: self)
    }
}
