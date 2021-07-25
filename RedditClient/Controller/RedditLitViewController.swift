//
//  RedditLitViewController.swift
//  RedditClient
//
//  Created by MarcoReyes on 25/07/21.
//

import UIKit

final class RedditLitViewController: UIViewController {
    let redditDataSource: RedditDataSource
    let redditListTableViewDataSource: RedditListTableViewDataSource

    lazy var redditListView: RedditListView = {
        let redditListView = RedditListView(frame: .zero, dataSource: redditListTableViewDataSource)
        redditListTableViewDataSource.redditListView = redditListView
        return redditListView
    }()

    init(redditDataSource: RedditDataSource = RedditDataSource(),
         redditListTableViewDataSource: RedditListTableViewDataSource = RedditListTableViewDataSource()) {
        self.redditDataSource = redditDataSource
        self.redditListTableViewDataSource = redditListTableViewDataSource
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadView() {
        view = redditListView
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        redditDataSource.itemsFromService { [unowned self] result in
            switch result {
            case .success(let redditRoot):
                self.redditListTableViewDataSource.redditChildDataList = redditRoot.data.children
            case .failure(let error):
                presentAlert(withTitle: "Error", message: error?.localizedDescription ?? "")
                break
            }
        }
    }
}


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
