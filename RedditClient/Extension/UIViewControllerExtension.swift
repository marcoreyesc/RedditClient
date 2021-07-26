//
//  UIViewControllerExtension.swift
//  RedditClient
//
//  Created by MarcoReyes on 26/07/21.
//

import UIKit

extension UIViewController {
    func presentAlert(withTitle title: String, message: String,
                      okButtonTitle: String = "Ok",
                      okHandler: ((UIAlertAction) -> Void)? = nil) {
        DispatchQueue.main.async {
            let alertController = self.createAlertController(withTitle: title, message: message,
                                                             okButtonTitle: okButtonTitle,
                                                             okHandler: okHandler)
            self.present(alertController, animated: true, completion: nil)
        }
    }

    func createAlertController(withTitle title: String, message: String, okButtonTitle: String = "Ok",
                               okHandler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {

        let alertController = UIAlertController(title: title, message: message,preferredStyle: .alert)
        let OKAction = UIAlertAction(title: okButtonTitle, style: .default, handler: okHandler)
        alertController.addAction(OKAction)
        return alertController

    }
}
