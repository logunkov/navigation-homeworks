//
//  PostViewController.swift
//  Navigation
//
//  Created by Constantin on 25.11.2022.
//

import UIKit

final class PostViewController: UIViewController {
    let titlePost: String = "Post"

    private lazy var barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buttonAction))

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.navigationItem.title = titlePost
        navigationItem.rightBarButtonItem = barButtonItem
    }

    @objc private func buttonAction() {
        let infoViewController = InfoViewController()
        infoViewController.modalPresentationStyle = .popover
        self.navigationController?.pushViewController(infoViewController, animated: true)
    }
}
