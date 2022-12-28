//
//  ShowPostViewController.swift
//  Navigation
//
//  Created by Constantin on 28.12.2022.
//

import UIKit

final class ShowPostViewController: UIViewController {

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
        label.isUserInteractionEnabled = true
//        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLike))
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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Post"
        self.navigationController?.navigationBar.isHidden = false
        self.view.backgroundColor = .systemGray6

        view.addSubview(author)
        view.addSubview(imageNews)
        view.addSubview(stackViewVertical)

        stackViewVertical.addArrangedSubview(descriptionText)
        stackViewVertical.addArrangedSubview(stackViewHorizontal)
        stackViewHorizontal.addArrangedSubview(likes)
        stackViewHorizontal.addArrangedSubview(views)

        installConstrains()
    }

    private func installConstrains() {
        let size = CGFloat(floor((view.frame.width)))

        NSLayoutConstraint.activate([
            author.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            author.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            author.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            imageNews.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 16),
            imageNews.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageNews.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imageNews.heightAnchor.constraint(equalToConstant: size),

            stackViewVertical.topAnchor.constraint(equalTo: imageNews.bottomAnchor, constant: 16),
            stackViewVertical.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackViewVertical.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

        ])
    }

}
