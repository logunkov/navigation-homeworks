//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Constantin on 14.12.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rightArrow: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "arrow.right")
        image.tintColor = .black
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var stackViewHorizontalHeader: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var stackViewHorizontalPhoto: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var stackViewVertical: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var imageFirst:    UIImageView = { UIImageView() }()
    private lazy var imageSecond:   UIImageView = { UIImageView() }()
    private lazy var imageThird:    UIImageView = { UIImageView() }()
    private lazy var imageFourth:   UIImageView = { UIImageView() }()
    private lazy var imageArray = [imageFirst, imageSecond, imageThird, imageFourth]
    
    private func installImage() {
        var index = 1
        for image in imageArray {
            image.image = UIImage(named: "photo\(index)")
            image.clipsToBounds = true
            image.layer.cornerRadius = 6
            image.backgroundColor = .black
            image.contentMode = .scaleAspectFill
            image.translatesAutoresizingMaskIntoConstraints = false
            index += 1
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(stackViewVertical)
        stackViewVertical.addArrangedSubview(stackViewHorizontalHeader)
        stackViewVertical.addArrangedSubview(stackViewHorizontalPhoto)
        stackViewHorizontalHeader.addArrangedSubview(label)
        stackViewHorizontalHeader.addArrangedSubview(rightArrow)
        
        for image in imageArray {
            stackViewHorizontalPhoto.addArrangedSubview(image)
        }
        
        installImage()
        installConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func installConstrains() {
        NSLayoutConstraint.activate([
            imageFirst.heightAnchor.constraint(equalTo: stackViewHorizontalPhoto.widthAnchor, multiplier: 0.25),
            stackViewVertical.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            stackViewVertical.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            stackViewVertical.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stackViewVertical.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }
}
