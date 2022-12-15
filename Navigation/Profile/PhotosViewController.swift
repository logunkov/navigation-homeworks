//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Constantin on 14.12.2022.
//

import UIKit

class PhotosViewController: UIViewController {
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemGray6
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var dataSource: [UIImageView] = {
        var imageArray: [UIImageView] = []
        for index in 1...20 {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "photo\(index)")
            imageArray.append(imageView)
        }
        return imageArray
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Photo Gallery"
        self.navigationController?.navigationBar.isHidden = false
        self.view.backgroundColor = .lightGray
        
        view.addSubview(collectionView)
        installConstrains()
    }
    
    private func installConstrains() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func imageSize(for width: CGFloat, with spacing: CGFloat) -> CGSize {
        let width = floor((width - 4 * spacing) / 3)
        return CGSize(width: width, height: width)
    }
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        let photos = dataSource[indexPath.row]
        cell.photoImage.image = photos.image
        cell.photoImage.contentMode = .scaleAspectFill
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let size: CGFloat = 8
        return UIEdgeInsets(top: size, left: size, bottom: size, right: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let  spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing
        return imageSize(for: collectionView.frame.width, with: spacing ?? 0)
    }
}
