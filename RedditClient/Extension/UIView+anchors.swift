//
//  UIView+anchors.swift
//  RedditClient
//
//  Created by MarcoReyes on 25/07/21.
//

import UIKit

public extension UIView {
    
    func fillSuperview(padding: UIEdgeInsets) -> [NSLayoutConstraint] {
        var bottomAnchor = superview?.bottomAnchor
        var topAnchor = superview?.topAnchor
        if #available(iOS 11.0, *) {
            bottomAnchor = superview?.safeAreaLayoutGuide.bottomAnchor
            topAnchor = superview?.safeAreaLayoutGuide.topAnchor
        }
        
        return anchor(top: topAnchor, leading: superview?.leadingAnchor,
                      bottom: bottomAnchor, trailing: superview?.trailingAnchor,
                      padding: padding)
    }
    
    func fillSuperview() -> [NSLayoutConstraint] {
        return (fillSuperview(padding: .zero))
    }
    
    func anchorSize(to view: UIView) -> [NSLayoutConstraint] {
        return [
            widthAnchor.constraint(equalTo: view.widthAnchor),
            heightAnchor.constraint(equalTo: view.heightAnchor)
        ]
    }
    
    func anchorLeadTrail(to view: UIView,  constant c: CGFloat? = 0.0) -> [NSLayoutConstraint] {
        return [
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: c ?? 0.0),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: c ?? 0.0)
        ]
    }
    
    func anchorLeadTrailOnSuperView(constant c: CGFloat? = 0.0) -> [NSLayoutConstraint] {
        guard let superview = superview else {
            return []
        }
        return anchorLeadTrail(to: superview, constant: c)
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = []
        
        if let top = top {
            constraints.append(topAnchor.constraint(equalTo: top, constant: padding.top))
        }
        
        if let leading = leading {
            constraints.append(leadingAnchor.constraint(equalTo: leading, constant: padding.left))
        }
        
        if let bottom = bottom {
            constraints.append(bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom))
        }
        
        if let trailing = trailing {
            constraints.append(trailingAnchor.constraint(equalTo: trailing, constant: -padding.right))
        }
        
        if size.width != 0 {
            constraints.append(widthAnchor.constraint(equalToConstant: size.width))
        }
        
        if size.height != 0 {
            constraints.append(heightAnchor.constraint(equalToConstant: size.height))
        }
        
        return constraints
    }
    
    func setSize(_ size: CGSize) -> [NSLayoutConstraint] {
        return [self.widthAnchor.constraint(equalToConstant: size.width),
                self.heightAnchor.constraint(equalToConstant: size.height)]
    }
    
    func centerInView(_ view: UIView) -> [NSLayoutConstraint] {
        return [self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                self.centerYAnchor.constraint(equalTo: view.centerYAnchor)]
    }
    
    func centerInSuperView() -> [NSLayoutConstraint] {
        guard let view = self.superview else {
            return []
        }
        
        return centerInView(view)
    }
}

