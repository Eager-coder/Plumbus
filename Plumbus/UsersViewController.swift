//
//  UsersViewController.swift
//  Plumbus
//
//  Created by Kenes Yerassyl on 9/5/20.
//  Copyright © 2020 Kenes Yerassyl. All rights reserved.
//

import UIKit
import JGProgressHUD

class UsersViewController: UIViewController {
    private let const: CGFloat = 10
    private let spinner = JGProgressHUD(style: .dark)
    
    private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        var temp = UICollectionViewFlowLayout()
        temp.minimumLineSpacing = const
        temp.minimumInteritemSpacing = const
        return temp
    }()
    
    private lazy var collectionView: UICollectionView = {
        var temp = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewFlowLayout)
        temp.backgroundColor = .systemGray4
        temp.register(UsersCollectionViewCell.self, forCellWithReuseIdentifier: UsersCollectionViewCell.id)
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#2C2C2E")
        
        updateCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    private func updateCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.bottom.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(const)
        }
        collectionView.backgroundColor = .clear
    }
}

extension UsersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Users.users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let usersColletionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: UsersCollectionViewCell.id, for: indexPath) as? UsersCollectionViewCell
        if let cell = usersColletionViewCell {
            cell.user = Users.users[indexPath.row]
            return cell
        } else {
            return UsersCollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension UsersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width * 0.95, height: 100)
    }
}
