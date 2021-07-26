//
//  RedditItemCell.swift
//  RedditClient
//
//  Created by MarcoReyes on 25/07/21.
//

import UIKit

final class RedditItemCell: UITableViewCell {
    let createdLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(14)
        return label
    }()

    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(16)
        return label
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(16)
        return label
    }()
    let numCommentsLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(14)
        return label
    }()

    lazy var dotView: UIView = {
        let dotView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        dotView.layer.cornerRadius = 5;
        dotView.layer.masksToBounds = true;
        dotView.backgroundColor = .blue
        return dotView
    }()

    let thumbnailView: UIImageView = {
        let thumbnailView = UIImageView(frame: CGRect(x: 0, y: 0, width: 58, height: 58))
        thumbnailView.backgroundColor = .red
        return thumbnailView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        let topHorizontalStackView = UIStackView(arrangedSubviews: [dotView, authorLabel, createdLabel])
        topHorizontalStackView.spacing = 8
        topHorizontalStackView.alignment = .top

        let centerHorizontalStackView = UIStackView(arrangedSubviews: [thumbnailView, titleLabel])
        centerHorizontalStackView.spacing = 8

        let stack = UIStackView(arrangedSubviews: [topHorizontalStackView, centerHorizontalStackView, numCommentsLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 16

        contentView.addSubview(stack)
        NSLayoutConstraint.activate(
            stack.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor,
                         bottom: nil, trailing: contentView.trailingAnchor,
                         padding: UIEdgeInsets(top: 16, left: 8, bottom: 0, right: 8))
        )
        NSLayoutConstraint.activate(dotView.setSize(CGSize(width: 10, height: 10)))
        NSLayoutConstraint.activate(thumbnailView.setSize(CGSize(width: 64, height: 64)))
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
