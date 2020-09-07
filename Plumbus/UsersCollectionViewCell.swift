//
//  UsersCollectionViewCell.swift
//  Plumbus
//
//  Created by Kenes Yerassyl on 9/5/20.
//  Copyright © 2020 Kenes Yerassyl. All rights reserved.
//

import UIKit

class UsersCollectionViewCell: UICollectionViewCell {
    static let id = "UsersCollectionViewCell"
    
    var user: User? {
        willSet {
            guard let user = newValue else { return }
            nameLabel.text = "\(user.firstName) \(user.lastName)"
        }
    }
    private var nameLabel = UILabel()
    private var view = UIView()
    private var imageView = UIImageView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 50
        contentView.backgroundColor = UIColor(hex: "#48484A")
        
        updateImageView()
        updateNameLabel()
    }
    
    private func updateImageView() {
        contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.leading.equalTo(contentView).offset(10)
            make.top.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView).offset(-10)
            make.width.equalTo(80)
        }
        view.layer.cornerRadius = 40
        
        view.backgroundColor = UIColor(hex: "#FF87E0")
        view.layer.borderColor = UIColor.cyan.cgColor
        view.layer.borderWidth = 2.0
        view.layer.shadowColor = UIColor(hex: "#FF87E0").cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view.layer.shadowRadius = 10.0
        view.layer.shadowOpacity = 1.0
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(6)
            make.bottom.equalTo(view).offset(-6)
            make.leading.equalTo(view).offset(6)
            make.trailing.equalTo(view).offset(-6)
        }
        imageView.layer.cornerRadius = 36
        imageView.image = UIImage(named: "rick-morty")
    }
    
    private func updateNameLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(view.snp.trailing).offset(10)
            make.trailing.equalTo(contentView).offset(-10)
            make.height.equalTo(80)
            make.top.equalTo(contentView).offset(10)
        }
        nameLabel.font = UIFont(name: "Courier", size: 22)
    }
}
