//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Constantin on 01.12.2022.
//

import UIKit

class ProfileHeaderView: UIView {

    private var statusText: String?

    private lazy var labelName: UILabel = {
//        let labelName = UILabel(frame: CGRect(x: 170, y: 90 + 27, width: 204, height: 18))
        let labelName = UILabel()
        //labelName.backgroundColor = .yellow
        labelName.text = "Popeye the Sailor"
        labelName.font = UIFont.boldSystemFont(ofSize: 18)
        labelName.textColor = .black
        labelName.textAlignment = .center
        labelName.translatesAutoresizingMaskIntoConstraints = false
        return labelName
    }()

    private lazy var labelStatus: UILabel = {
//        let labelStatus = UILabel(frame: CGRect(x: 170, y: 256 + 16 - 34 - 14, width: 204, height: 14))
        let labelStatus = UILabel()
        //labelStatus.backgroundColor = .yellow
        labelStatus.text = "Шпинат - Сила!"
        labelStatus.numberOfLines = 0
        labelStatus.font = UIFont.boldSystemFont(ofSize: 14)
        labelStatus.textColor = .gray
        labelStatus.textAlignment = .center
        labelStatus.translatesAutoresizingMaskIntoConstraints = false
        return labelStatus
    }()

    private lazy var button: UIButton = {
//        let button = UIButton(frame: CGRect(x: 16, y: 256 + 16 + 20, width: 374 - 16, height: 50))
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Set status", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var imageView: UIImageView = {
        let size = 150
//        let imageView = UIImageView(frame: CGRect(x: 16, y: 90 + 16, width: size, height: size))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        imageView.image = UIImage(named: "popeye")
        imageView.layer.borderWidth = 3
        imageView.layer.backgroundColor = UIColor.purple.cgColor
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var textField: UITextField = {
//        let textField = UITextField(frame: CGRect(x: 170, y: 256 - 12, width: 204, height: 40))
        let textField = UITextField()
        textField.text = ""
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.textAlignment = .center
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    init() {
        super.init(frame: .zero)

        self.addSubview(labelName)
        self.addSubview(labelStatus)
        self.addSubview(imageView)
        self.addSubview(button)
        self.addSubview(textField)

        installConstrains()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func buttonPressed() {
        labelStatus.text = statusText
        print(labelStatus.text ?? "nil")
    }

    @objc private func statusTextChanged(_ textField: UITextField) {
        if let text = textField.text {
            statusText = text
        }
    }

    private func installConstrains() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150),

            button.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            button.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 50),

            labelName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
            labelName.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            labelName.trailingAnchor.constraint(equalTo: button.trailingAnchor),

            textField.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: button.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -8),
            textField.heightAnchor.constraint(equalToConstant: 40),

            labelStatus.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            labelStatus.trailingAnchor.constraint(equalTo: button.trailingAnchor),
            labelStatus.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -8)
        ])
    }
}
