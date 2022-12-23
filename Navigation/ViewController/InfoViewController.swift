//
//  InfoViewController.swift
//  Navigation
//
//  Created by Constantin on 25.11.2022.
//

import UIKit

final class InfoViewController: UIViewController {

    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.setTitle("go", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private func installButton(button: UIButton){
        NSLayoutConstraint.activate([
            self.button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.button.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.button.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Info"
        self.view.backgroundColor = .lightGray
        view.addSubview(self.button)
        installButton(button: button)
    }

    @objc private func buttonAction() {
        let alert = UIAlertController(title: "Info", message: "Message", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { action in print("Нажали кнопку \"Cancel\"")}))
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in print("Нажали кнопку \"OK\"")}))
        self.present(alert, animated: true, completion: nil)
    }
}
