//
//  RedditItemDetail.swift
//  RedditClient
//
//  Created by MarcoReyes on 26/07/21.
//

import UIKit

class RedditItemDetailView: UIView {
    let redditChildData: RedditChildData

    let authorLabel: UILabel = {
        let label = UILabel.defaultLabel(size: FontSize.big)
        label.textAlignment = .left
        return label
    }()
    let titleLabel: UILabel = {
        let label = UILabel.defaultLabel(size: FontSize.big)
        label.textAlignment = .left
        return label
    }()

    let thumbnailImage: UIImage?

    let thumbnailView: UIImageView = {
        let thumbnailView = UIImageView(frame: CGRect(x: 0, y: 0, width: 116, height: 116))
        thumbnailView.backgroundColor = .red
        thumbnailView.backgroundColor = .white
        return thumbnailView
    }()

    init (frame: CGRect, redditChildData: RedditChildData, thumbnailImage: UIImage?) {
        self.redditChildData = redditChildData
        self.thumbnailImage = thumbnailImage
        super.init(frame: frame)
        setupView()
        config(redditChildData: self.redditChildData)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(redditChildData: RedditChildData) {
        authorLabel.text = redditChildData.author
        titleLabel.text = redditChildData.title
        thumbnailView.image = thumbnailImage
    }

    func setupView() {
        let imageStackView = UIStackView(arrangedSubviews: [thumbnailView])
        imageStackView.axis = .vertical
        imageStackView.alignment = .center

        let stackView = UIStackView(arrangedSubviews:
                                        [authorLabel, imageStackView, titleLabel, UIView()])
        stackView.axis = .vertical
        
        addSubview(stackView)
        NSLayoutConstraint.activate(
            stackView.fillSuperview(padding: UIEdgeInsets(top: ViewSpace.big, left: ViewSpace.big, bottom: ViewSpace.big, right: ViewSpace.big)) +
            thumbnailView.setSize(CGSize(width: 116, height: 116))
        )
    }
}

