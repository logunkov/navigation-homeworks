//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Constantin on 13.12.2022.
//

import UIKit

final class PostTableViewCell: UITableViewCell {
    
    var author: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var descriptionText: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var imageNews: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var likes: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var views: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let stackViewHeaderVertical: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
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
    
    private let stackViewHorizontal: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(author)
        contentView.addSubview(imageNews)
        contentView.addSubview(stackViewVertical)
        stackViewVertical.addArrangedSubview(descriptionText)
        stackViewVertical.addArrangedSubview(stackViewHorizontal)
        stackViewHorizontal.addArrangedSubview(likes)
        stackViewHorizontal.addArrangedSubview(views)
        
        installConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func installConstrains() {

        let size = CGFloat(floor((contentView.frame.width)))

        NSLayoutConstraint.activate([
            author.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            author.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            author.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),

            imageNews.heightAnchor.constraint(equalToConstant: size),
            imageNews.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageNews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageNews.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 16),
            imageNews.bottomAnchor.constraint(equalTo: stackViewVertical.topAnchor, constant: -16),

            stackViewVertical.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackViewVertical.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackViewVertical.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        author.text = nil
        imageNews.image = nil
        descriptionText.text = nil
        likes.text = nil
        views.text = nil
    }
}
