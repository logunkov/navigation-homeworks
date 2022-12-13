//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Constantin on 25.11.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    private let authorArray = [
        "Екатерина Кулешова",
        "Валентин Сонин",
        "Екатерина Кулешова",
        "Валентин Сонин",
        "Владимир Макаров",
        "Екатерина Кулешова",
    ]
    private let descriptionArray = [
        "Анонс новой игры NetherRealm может состояться в течение полугода — на это намекнул Эд Бун, творческий руководитель студии и создатель Mortal Kombat и Injustice.",
        "Пользователи сети обратили внимание, что сиквел «Человека-паука» Insomniac уже можно добавить в список желаемого PS Store — пока, правда, лишь в Британии.",
        "На канале IGN появился очередной ролик, посвящённый ремейку Dead Space. В этот раз разработчики игры из Motive Studios рассказали о том, какие изменения были внесены в плазменный резак.",
        "Актёр Камерон Монахэн, который играл Кэла Кестиса в Star Wars Jedi: Fallen Order, рассказал об эволюции своего героя в Star Wars Jedi: Survivor.",
        "Dwarf Fortress, на этой неделе вышедшая в Steam и за первые сутки выполнившая план продаж на два месяца, стартовала со второй строчки местного чарта, где товары и игры упорядочены по выручке за семь дней. Да, игра не смогла обойти Steam Deck.",
        "Нил Дракманн, геймдиректор обеих The Last of Us и Uncharted 4, подтвердил в своём Twitter-аккаунте, что The Last of Us: Part I выйдет на Steam Deck."
    ]
    private let imageArray = ["image1", "image2", "image3", "image4", "image5", "image6"]
    private let likesArray = [10, 20, 30, 40, 50 ,60]
    private let viewsArray = [100, 200, 300, 400, 500 ,600]


    private lazy var dataSource: [Post] = {
        var dataSource: [Post] = []
        for index in 0..<authorArray.count {
            dataSource.append(Post(author: authorArray[index],
                                   description: descriptionArray[index],
                                   image: imageArray[index],
                                   likes: likesArray[index],
                                   views: viewsArray[index]))
        }
        return dataSource
    }()

    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView()
//        view.backgroundColor = .lightGray
        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "ArticleCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Profile"
        self.view.backgroundColor = .lightGray
        self.view.addSubview(tableView)
        installConstrains()

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.touch))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        view.addGestureRecognizer(recognizer)
    }

    private func installConstrains() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    @objc func touch() {
           self.view.endEditing(true)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! PostTableViewCell
        let article = dataSource[indexPath.row]

        cell.author.text = article.author
        cell.imageNews.image = UIImage(named: article.image)
        cell.descriptionText.text = article.description
        cell.likes.text = "Likes: \(article.likes)"
        cell.views.text = "Views: \(article.views)"

        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = profileHeaderView
        headerView.backgroundColor = .systemGray6
        headerView.heightAnchor.constraint(equalToConstant: 240).isActive = true

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 240
    }
}
