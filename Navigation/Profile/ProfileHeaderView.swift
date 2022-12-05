//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Constantin on 01.12.2022.
//

import UIKit

class ProfileHeaderView: UIView {

    private var statusText: String?

    var labelName: UILabel {
        let labelName = UILabel(frame: CGRect(x: 170, y: 90 + 27, width: 204, height: 18))
        //labelName.backgroundColor = .yellow
        labelName.text = "Popeye the Sailor"
        labelName.font = UIFont.boldSystemFont(ofSize: 18)
        labelName.textColor = .black
        labelName.textAlignment = .center
        return labelName
    }

    var labelStatus: UILabel
// Было
//    {
//        let labelStatus = UILabel(frame: CGRect(x: 170, y: 256 + 16 - 34 - 14, width: 204, height: 14))
//        //labelStatus.backgroundColor = .yellow
//        labelStatus.text = "Шпинат - Сила!"
//        labelStatus.numberOfLines = 0
//        labelStatus.font = UIFont.boldSystemFont(ofSize: 14)
//        labelStatus.textColor = .gray
//        labelStatus.textAlignment = .center
//        return labelStatus
//    }

    var button: UIButton {
        let button = UIButton(frame: CGRect(x: 16, y: 256 + 16 + 20, width: 374 - 16, height: 50))
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
        return button
    }

    var imageView: UIImageView {
        let size = 150
        let imageView = UIImageView(frame: CGRect(x: 16, y: 90 + 16, width: size, height: size))
        imageView.image = UIImage(named: "popeye")
        imageView.layer.borderWidth = 3
        imageView.layer.backgroundColor = UIColor.purple.cgColor
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true

        return imageView
    }

    var textField: UITextField {
        let textField = UITextField(frame: CGRect(x: 170, y: 256 - 12, width: 204, height: 40))
        textField.text = ""
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.textAlignment = .center
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)

        return textField
    }

    init() {
        // Стало
        self.labelStatus = UILabel(frame: CGRect(x: 170, y: 256 + 16 - 34 - 14, width: 204, height: 14))
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        creatingLabelStatus()
        self.addSubview(labelName)
        self.addSubview(labelStatus)
        self.addSubview(imageView)
        self.addSubview(button)
        self.addSubview(textField)
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

    func creatingLabelStatus() {
        // Стало
        //labelStatus.backgroundColor = .yellow
        labelStatus.text = "Шпинат - Сила!"
        labelStatus.numberOfLines = 0
        labelStatus.font = UIFont.boldSystemFont(ofSize: 14)
        labelStatus.textColor = .gray
        labelStatus.textAlignment = .center
    }
}
