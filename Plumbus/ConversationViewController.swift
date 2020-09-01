//
//  ConversationViewController.swift
//  Plumbus
//
//  Created by Kenes Yerassyl on 9/1/20.
//  Copyright © 2020 Kenes Yerassyl. All rights reserved.
//

import UIKit
import SnapKit
import JGProgressHUD

class ConversationViewController: UIViewController {
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
        temp.register(ConversationColletionViewCell.self, forCellWithReuseIdentifier: ConversationColletionViewCell.id)
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCollectionView()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func updateCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.bottom.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ConversationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: Create an array of dialogues
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let conversationColletionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ConversationColletionViewCell.id, for: indexPath) as? ConversationColletionViewCell
        if let cell = conversationColletionViewCell {
            return cell
        } else {
            return ConversationColletionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = ChatViewController()
        vc.navigationItem.title = "Kenes Yerassyl"
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ConversationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width * 0.95, height: 100)
    }
}
