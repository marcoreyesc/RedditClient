//
//  RedditItemCell.swift
//  RedditClient
//
//  Created by MarcoReyes on 25/07/21.
//

import UIKit

protocol RedditItemCellDelegate: class {
    func didPressDeleteButton(sender: RedditItemCell)
}

final class RedditItemCell: UITableViewCell {
    let createdLabel: UILabel = UILabel.defaultLabel(size: FontSize.big)

    let authorLabel: UILabel = UILabel.defaultLabel(size: FontSize.big)

    let titleLabel: UILabel = {
        let label = UILabel.defaultLabel(size: FontSize.medium)
        label.numberOfLines = 0
        return label
    }()

    let numCommentsLabel: UILabel = {
        return UILabel.defaultLabel(size: FontSize.medium)
    }()

    private lazy var dotView: UIView = {
        let dotView = UIView(frame: .zero)
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

    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.red, for: .normal)
        button.setTitle("Dismiss Post", for: .normal)
        button.setImage(.remove, for: .normal)
        button.addTarget(self, action: #selector(didPressDeleteButton), for: .touchUpInside)
        return button
    }()

    weak var delegate: RedditItemCellDelegate?

    @objc func didPressDeleteButton() {
        delegate?.didPressDeleteButton(sender: self)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        createdLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        let topHorizontalStackView = UIStackView(arrangedSubviews: [dotView, authorLabel, createdLabel])
        topHorizontalStackView.spacing = ViewSpace.medium
        topHorizontalStackView.alignment = .top
        let centerHorizontalStackView = UIStackView(arrangedSubviews: [thumbnailView, titleLabel])
        centerHorizontalStackView.spacing = ViewSpace.medium
        let bottomStackView = UIStackView(arrangedSubviews: [deleteButton, UIView(), numCommentsLabel])
        let stack = UIStackView(arrangedSubviews: [topHorizontalStackView, centerHorizontalStackView, bottomStackView])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = ViewSpace.big
        contentView.addSubview(stack)
        NSLayoutConstraint.activate(
            stack.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor,
                         bottom: nil, trailing: contentView.trailingAnchor,
                         padding: UIEdgeInsets(top: ViewSpace.big, left: ViewSpace.medium, bottom: 0, right: ViewSpace.medium)) +
            dotView.setSize(CGSize(width: 10, height: 10)) +
            thumbnailView.setSize(CGSize(width: 64, height: 64))
        )
        NSLayoutConstraint.activate(
        [topHorizontalStackView.widthAnchor.constraint(equalTo: stack.widthAnchor)] +
        [centerHorizontalStackView.widthAnchor.constraint(equalTo: stack.widthAnchor)] +
        [bottomStackView.widthAnchor.constraint(equalTo: stack.widthAnchor)])
    }

    func config(redditChildData: RedditChildData) {
        let createdDate = Date(timeIntervalSince1970: TimeInterval(redditChildData.created))
        createdLabel.text = Date().timeElapsed(from: createdDate)
        authorLabel.text = redditChildData.author
        titleLabel.text = redditChildData.title
        numCommentsLabel.text = "\(redditChildData.numComments)"
    }

    func displayImage(_ image: UIImage?) {
        thumbnailView.image = image
    }

    static var reuseID: String {
        return String(describing: self)
    }

    override func prepareForReuse() {
        createdLabel.text = nil
        authorLabel.text = nil
        titleLabel.text = nil
        thumbnailView.image = nil
    }

    func setState(viewed: Bool) {
        DispatchQueue.main.async {
            self.dotView.alpha = viewed ? 0.0 : 1.0
            self.dotView.transform = .identity
        }
    }
}
