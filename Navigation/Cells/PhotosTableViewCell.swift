//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Constantin on 14.12.2022.
//

import UIKit

final class PhotosTableViewCell: UITableViewCell {
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rightArrow: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "arrow.right")
        image.tintColor = .black
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let stackViewHorizontalHeader: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let stackViewHorizontalPhoto: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let stackViewVertical: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let imageFirst:    UIImageView = { UIImageView() }()
    private let imageSecond:   UIImageView = { UIImageView() }()
    private let imageThird:    UIImageView = { UIImageView() }()
    private let imageFourth:   UIImageView = { UIImageView() }()
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
        let size = CGFloat(floor((contentView.frame.width - 3 * 8) / 4))
        NSLayoutConstraint.activate([
            imageFirst.heightAnchor.constraint(equalToConstant: size),
            stackViewVertical.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            stackViewVertical.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            stackViewVertical.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stackViewVertical.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }
}
