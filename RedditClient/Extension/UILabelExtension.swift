//
//  UILabelExtension.swift
//  RedditClient
//
//  Created by MarcoReyes on 25/07/21.
//

import UIKit

extension UILabel {
    static func defaultLabel(size: CGFloat) -> UILabel {
        let label = UILabel()
        label.font = label.font.withSize(size)
        return label
    }
}

