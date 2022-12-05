//
//  InfoViewController.swift
//  Navigation
//
//  Created by Constantin on 25.11.2022.
//

import UIKit

class InfoViewController: UIViewController {

    private lazy var button: UIButton = {
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
        self.button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
        self.button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        view.addSubview(self.button)
        installButton(button: button)
    }

    @objc private func buttonAction() {
        let alert = UIAlertController(title: "Info", message: "Message", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { action in
                                        print("Нажали кнопку \"Cancel\"")}))
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                                        print("Нажали кнопку \"OK\"")}))
        self.present(alert, animated: true, completion: nil)
    }
}
