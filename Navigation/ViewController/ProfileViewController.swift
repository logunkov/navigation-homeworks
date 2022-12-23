//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Constantin on 25.11.2022.
//

import UIKit

final class ProfileViewController: UIViewController {
    
//    private let authorArray = [
//        "Екатерина Кулешова",
//        "Валентин Сонин",
//        "Екатерина Кулешова",
//        "Валентин Сонин",
//        "Владимир Макаров",
//        "Екатерина Кулешова",
//    ]
//    private let descriptionArray = [
//        "Анонс новой игры NetherRealm может состояться в течение полугода — на это намекнул Эд Бун, творческий руководитель студии и создатель Mortal Kombat и Injustice.",
//        "Пользователи сети обратили внимание, что сиквел «Человека-паука» Insomniac уже можно добавить в список желаемого PS Store — пока, правда, лишь в Британии.",
//        "На канале IGN появился очередной ролик, посвящённый ремейку Dead Space. В этот раз разработчики игры из Motive Studios рассказали о том, какие изменения были внесены в плазменный резак.",
//        "Актёр Камерон Монахэн, который играл Кэла Кестиса в Star Wars Jedi: Fallen Order, рассказал об эволюции своего героя в Star Wars Jedi: Survivor.",
//        "Dwarf Fortress, на этой неделе вышедшая в Steam и за первые сутки выполнившая план продаж на два месяца, стартовала со второй строчки местного чарта, где товары и игры упорядочены по выручке за семь дней. Да, игра не смогла обойти Steam Deck.",
//        "Нил Дракманн, геймдиректор обеих The Last of Us и Uncharted 4, подтвердил в своём Twitter-аккаунте, что The Last of Us: Part I выйдет на Steam Deck."
//    ]
//    private let imageArray = ["image1", "image2", "image3", "image4", "image5", "image6"]
//    private let likesArray = [10, 20, 30, 40, 50 ,60]
//    private let viewsArray = [100, 200, 300, 400, 500 ,600]

    private var avatarWidthConstraint: NSLayoutConstraint!
    private var avatarHeightConstraint: NSLayoutConstraint!
    private var avatarXCenterConstraint: NSLayoutConstraint!
    private var avatarYCenterConstraint: NSLayoutConstraint!
    
//    private lazy var dataSource: [Post] = {
//        var dataSource: [Post] = []
//        for index in 0..<authorArray.count {
//            dataSource.append(Post(author: authorArray[index],
//                                   description: descriptionArray[index],
//                                   image: imageArray[index],
//                                   likes: likesArray[index],
//                                   views: viewsArray[index]))
//        }
//        return dataSource
//    }()

    private let profileHeaderView = ProfileHeaderView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "ArticleCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let avaterView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let imageView: UIImageView = {
        let size = 150
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        imageView.image = UIImage(named: "popeye")
        imageView.layer.borderWidth = 3
        imageView.layer.backgroundColor = UIColor.purple.cgColor
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.isHidden = true
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let closeButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.alpha = 0
        button.isHidden = true
        button.setBackgroundImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.addTarget(self, action: #selector(avatarClosed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var tapGestureRecognizerOneClick: UITapGestureRecognizer = {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.avatarOpened))
        tapGestureRecognizer.numberOfTapsRequired = 1
        return tapGestureRecognizer
    }()

    private lazy var tapGestureRecognizerTwoClicks: UITapGestureRecognizer = {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.touch))
        tapGestureRecognizer.numberOfTapsRequired = 2
        return tapGestureRecognizer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Profile"
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .lightGray
        self.view.addSubview(tableView)
        self.view.addSubview(avaterView)
        self.view.addSubview(imageView)
        self.view.addSubview(closeButton)
        installConstrains()
        installRecognizer()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    private func installConstrains() {
        avatarWidthConstraint = imageView.widthAnchor.constraint(equalToConstant: 150)
        avatarHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: 150)
        avatarXCenterConstraint = imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 91)
        avatarYCenterConstraint = imageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 91 )

        NSLayoutConstraint.activate([
            self.avatarWidthConstraint, self.avatarHeightConstraint,
            self.avatarXCenterConstraint, self.avatarYCenterConstraint,
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            avaterView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            avaterView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            avaterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            avaterView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            closeButton.heightAnchor.constraint(equalToConstant: 44),
            closeButton.widthAnchor.constraint(equalToConstant: 44),
        ])
    }

    private func installRecognizer() {
        profileHeaderView.imageView.addGestureRecognizer(tapGestureRecognizerOneClick)
        view.addGestureRecognizer(tapGestureRecognizerTwoClicks)
    }

    @objc func touch() {
        self.view.endEditing(true)
    }

    private func getInvisibility() {
        self.profileHeaderView.imageView.isHidden.toggle()
        self.closeButton.isHidden.toggle()
        self.imageView.isHidden.toggle()
    }

    @objc func avatarOpened() {
        let sizeWidth = CGFloat(floor((view.safeAreaLayoutGuide.layoutFrame.width)))
        let sizeHeight = CGFloat(floor((view.safeAreaLayoutGuide.layoutFrame.height)))

        avatarXCenterConstraint.constant = 91
        avatarYCenterConstraint.constant = 91 - tableView.contentOffset.y
        self.view.layoutIfNeeded()

        getInvisibility()


        if sizeWidth > sizeHeight {
            avatarWidthConstraint.constant = sizeHeight
            avatarHeightConstraint.constant = sizeHeight
        } else {
            avatarWidthConstraint.constant = sizeWidth
            avatarHeightConstraint.constant = sizeWidth
        }

        avatarXCenterConstraint.constant = sizeWidth / 2
        avatarYCenterConstraint.constant = sizeHeight / 2


        UIView.animate(withDuration: 0.5) {
            self.avaterView.alpha = 0.7
            self.imageView.layer.cornerRadius = 0
            self.view.layoutIfNeeded()
        }

        UIView.animate(withDuration: 0.3, delay: 0.5) {
            self.closeButton.alpha = 1
            self.view.layoutIfNeeded()
        }
    }

    @objc func avatarClosed() {
        UIView.animate(withDuration: 0.3) {
            self.closeButton.alpha = 0
            self.view.layoutIfNeeded()
        }

        avatarWidthConstraint.constant = 150
        avatarHeightConstraint.constant = 150

        avatarXCenterConstraint.constant = 91
        avatarYCenterConstraint.constant = 91 - tableView.contentOffset.y


        UIView.animate(withDuration: 0.5, delay: 0.3) {
            self.avaterView.alpha = 0
            self.imageView.layer.cornerRadius = 150 / 2
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.getInvisibility()
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as! PhotosTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! PostTableViewCell
            let article = dataSource[indexPath.row - 1]
            
            cell.author.text = article.author
            cell.imageNews.image = UIImage(named: article.image)
            cell.descriptionText.text = article.description
            cell.likes.text = "Likes: \(article.likes)"
            cell.views.text = "Views: \(article.views)"
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = profileHeaderView
        headerView.backgroundColor = .lightGray
        headerView.heightAnchor.constraint(equalToConstant: 225).isActive = true
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 225
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let photosViewController = PhotosViewController()
            self.navigationController?.pushViewController(photosViewController, animated: true)
        }
    }
}

extension ProfileViewController {

    private var authorArray: [String] { return [
        "Екатерина Кулешова",
        "Валентин Сонин",
        "Екатерина Кулешова",
        "Валентин Сонин",
        "Владимир Макаров",
        "Екатерина Кулешова",
    ]}

    private var descriptionArray: [String] { return [
        "Анонс новой игры NetherRealm может состояться в течение полугода — на это намекнул Эд Бун, творческий руководитель студии и создатель Mortal Kombat и Injustice.",
        "Пользователи сети обратили внимание, что сиквел «Человека-паука» Insomniac уже можно добавить в список желаемого PS Store — пока, правда, лишь в Британии.",
        "На канале IGN появился очередной ролик, посвящённый ремейку Dead Space. В этот раз разработчики игры из Motive Studios рассказали о том, какие изменения были внесены в плазменный резак.",
        "Актёр Камерон Монахэн, который играл Кэла Кестиса в Star Wars Jedi: Fallen Order, рассказал об эволюции своего героя в Star Wars Jedi: Survivor.",
        "Dwarf Fortress, на этой неделе вышедшая в Steam и за первые сутки выполнившая план продаж на два месяца, стартовала со второй строчки местного чарта, где товары и игры упорядочены по выручке за семь дней. Да, игра не смогла обойти Steam Deck.",
        "Нил Дракманн, геймдиректор обеих The Last of Us и Uncharted 4, подтвердил в своём Twitter-аккаунте, что The Last of Us: Part I выйдет на Steam Deck."
    ]}

    private var imageArray: [String] { return ["image1", "image2", "image3", "image4", "image5", "image6"] }
    private var likesArray: [Int] { return [10, 20, 30, 40, 50 ,60] }
    private var viewsArray: [Int] { return [100, 200, 300, 400, 500 ,600] }

    private var dataSource: [Post] {
        var dataSource: [Post] = []
        for index in 0..<authorArray.count {
            dataSource.append(Post(author: authorArray[index],
                                   description: descriptionArray[index],
                                   image: imageArray[index],
                                   likes: likesArray[index],
                                   views: viewsArray[index]))
        }
        return dataSource
    }
}
