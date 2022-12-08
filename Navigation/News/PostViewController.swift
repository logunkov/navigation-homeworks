//
//  PostViewController.swift
//  Navigation
//
//  Created by Constantin on 25.11.2022.
//

import UIKit

class PostViewController: UIViewController {
    var titlePost: String = ""

    private lazy var barButtonItem : UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonAction))

        return barButtonItem
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        self.navigationItem.title = titlePost
        navigationItem.rightBarButtonItem = barButtonItem
    }

    @objc private func buttonAction() {
        let infoViewController = InfoViewController()
        infoViewController.modalPresentationStyle = .popover
        self.navigationController?.pushViewController(infoViewController, animated: true)
    }
}
