//
//  LogInViewController.swift
//  Navigation
//
//  Created by Constantin on 08.12.2022.
//

import UIKit

class LogInViewController: UIViewController {

    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    var textFieldLogin: UITextField = {
        let textField = UITextField()
        textField.text = ""
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.tintColor = UIColor.blue
        textField.autocapitalizationType = .none
        textField.textAlignment = .left
        textField.placeholder = " Email of phone"
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    var textFieldPassword: UITextField = {
        let textField = UITextField()
        textField.text = ""
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.tintColor = UIColor.blue
        textField.autocapitalizationType = .none
        textField.textAlignment = .left
        textField.isSecureTextEntry = true
        textField.placeholder = " Password"
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    var button: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: UIControl.State.normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        if button.isSelected || button.isHighlighted || !button.isEnabled{
            button.alpha = 0.8
        } else {
            button.alpha = 1
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var scrollView: UIScrollView = {
//        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 1000, height: 1000))
        let scrollView = UIScrollView()
        scrollView.keyboardDismissMode = .interactive
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true

        self.view.backgroundColor = .white
        self.scrollView.addSubview(imageView)
        self.scrollView.addSubview(textFieldLogin)
        self.scrollView.addSubview(textFieldPassword)
        self.scrollView.addSubview(button)
        self.view.addSubview(scrollView)

        installConstrains()

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.touch))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        scrollView.addGestureRecognizer(recognizer)
    }

    private func installConstrains() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 320),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),

            textFieldLogin.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 120),
            textFieldLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textFieldLogin.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textFieldLogin.heightAnchor.constraint(equalToConstant: 50),

            textFieldPassword.topAnchor.constraint(equalTo: textFieldLogin.bottomAnchor),
            textFieldPassword.leadingAnchor.constraint(equalTo: textFieldLogin.leadingAnchor),
            textFieldPassword.trailingAnchor.constraint(equalTo: textFieldLogin.trailingAnchor),
            textFieldPassword.heightAnchor.constraint(equalTo: textFieldLogin.heightAnchor),

            button.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 16),
            button.leadingAnchor.constraint(equalTo: textFieldLogin.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: textFieldLogin.trailingAnchor),
            button.heightAnchor.constraint(equalTo: textFieldLogin.heightAnchor),

            scrollView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
            scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
//            scrollView.widthAnchor.constraint(equalToConstant: 1000),
//            scrollView.heightAnchor.constraint(equalToConstant: 1000),
            scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            scrollView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),


        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeKeyboardEvents()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    func subscribeKeyboardEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    @objc func kbWillShow(_ notification: Notification) {
        guard let kbFrameSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height - self.view.safeAreaInsets.bottom + 20, right: 0)
    }

    @objc func kbWillHide() {
        scrollView.contentInset = .zero
    }

    @objc private func statusTextChanged() {
        subscribeKeyboardEvents()
    }

    @objc func touch() {
           self.view.endEditing(true)
    }

    @objc private func buttonAction() {
        let profileViewController = ProfileViewController()
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
}
