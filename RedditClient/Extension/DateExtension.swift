//
//  DateExtension.swift
//  RedditClient
//
//  Created by MarcoReyes on 26/07/21.
//

import Foundation

// TODO: - add Unit test to ensure correct operation
extension Date {
    func timeElapsed(from input: Date) -> String {
        let interval = self.timeIntervalSince(input)
        let intInterval = Int64(interval)

        guard intInterval > 0 else {
            return "Now"
        }

        guard intInterval / 60 > 60 else {
            return "\(intInterval / 1000) secs. ago"
        }

        guard intInterval / 3600 > 60 else {
            return "\(intInterval / 3600) mins. ago"
        }

        guard intInterval / 86400 > 24 else {
            return "\(intInterval / 86400) hrs. ago"
        }

        guard intInterval / 2592000 > 30 else {
            return "\(intInterval / 2592000) mnths. ago"
        }

        return "years."
    }
}
