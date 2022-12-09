//
//  LogInViewController.swift
//  Navigation
//
//  Created by Constantin on 08.12.2022.
//

import UIKit

class LogInViewController: UIViewController {

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var textFieldLogin: UITextField = {
        let textField = UITextField()
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        textField.leftViewMode = .always
        textField.leftView = spacerView
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
        textField.placeholder = "Email of phone"
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var textFieldPassword: UITextField = {
        let textField = UITextField()
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        textField.leftViewMode = .always
        textField.leftView = spacerView
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
        textField.placeholder = "Password"
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var button: UIButton = {
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

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1000)
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
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120),
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),

            textFieldLogin.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 120),
            textFieldLogin.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textFieldLogin.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            textFieldLogin.heightAnchor.constraint(equalToConstant: 50),

            textFieldPassword.topAnchor.constraint(equalTo: textFieldLogin.bottomAnchor),
            textFieldPassword.leadingAnchor.constraint(equalTo: textFieldLogin.leadingAnchor),
            textFieldPassword.trailingAnchor.constraint(equalTo: textFieldLogin.trailingAnchor),
            textFieldPassword.heightAnchor.constraint(equalTo: textFieldLogin.heightAnchor),

            button.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 16),
            button.leadingAnchor.constraint(equalTo: textFieldLogin.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: textFieldLogin.trailingAnchor),
            button.heightAnchor.constraint(equalTo: textFieldLogin.heightAnchor),
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
        self.scrollView.contentInset = .zero
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
