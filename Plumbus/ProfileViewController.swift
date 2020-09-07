//
//  ProfileViewController.swift
//  Plumbus
//
//  Created by Kenes Yerassyl on 9/1/20.
//  Copyright © 2020 Kenes Yerassyl. All rights reserved.
//

import SnapKit

class ProfileViewController: UIViewController {
    
    private var viewView = UIView()
    private var imageView = UIImageView()
    private var nameLabel = UILabel()
    private var friendsButton = UIButton()
    private let const: CGFloat = 20.0
    private var profileVM = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        profileVM.delegate = self
        updateBackground()
        updateImageView()
        updateNameLabel()
    }
    
    
    private func updateBackground() {
        let backgroundImageView = UIImageView()
        view.addSubview(backgroundImageView)
        backgroundImageView.image = UIImage(named: "profile-back")
        let imageSize = backgroundImageView.image?.size
        let mult = max(view.frame.width / (imageSize?.width)!, view.frame.height / (imageSize?.height)!)
        backgroundImageView.frame = CGRect(origin: .zero, size: CGSize(width: (imageSize?.width)! * mult, height: (imageSize?.height)! * mult))
        backgroundImageView.alpha = 0.5
    }
    
    private func updateImageView() {
        view.addSubview(viewView)
        viewView.addSubview(imageView)
        
        viewView.snp.makeConstraints { (make) in
            make.width.equalTo(view.frame.width * 0.65)
            make.height.equalTo(view.frame.width * 0.65)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(view).offset(-view.frame.height * 0.2)
        }
        viewView.layer.cornerRadius = view.frame.width * 0.325
        viewView.backgroundColor = UIColor(hex: "#FF87E0")
        viewView.layer.borderColor = UIColor.cyan.cgColor
        viewView.layer.borderWidth = 2.0
        viewView.layer.shadowColor = UIColor(hex: "#FF87E0").cgColor
        viewView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewView.layer.shadowRadius = 10.0
        viewView.layer.shadowOpacity = 1.0
        
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(view.frame.width * 0.6)
            make.height.equalTo(view.frame.width * 0.6)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(view).offset(-view.frame.height * 0.2)
        }
        imageView.image = UIImage(named: "rick-morty")
        profileVM.downloadProfileImage()
        imageView.layer.cornerRadius = view.frame.width * 0.3
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageViewClicked))
        imageView.addGestureRecognizer(tap)
    }
    
    @objc private func imageViewClicked() {
        showActionSheetOfImage()
    }
    
    private func updateNameLabel() {
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(viewView.snp.bottom).offset(const * 2)
            make.centerX.equalTo(view)
            make.width.equalToSuperview()
            make.height.equalTo(view.frame.height * 0.05)
        }
        let shadow = NSShadow()
        shadow.shadowColor = UIColor(hex: "#FF87E0")
        shadow.shadowOffset = CGSize(width: 0.0, height: 0.0)
        shadow.shadowBlurRadius = 10.0
        let text = NSAttributedString(string: "\(profileVM.user?.firstName ?? "Name") \(profileVM.user?.lastName ?? "Surname")", attributes: [
            .font : UIFont(name: "UniversalJack", size: 34) as Any,
            .strokeWidth : -2.0,
            .strokeColor : UIColor.cyan,
            .foregroundColor : UIColor(hex: "#FF87E0"),
            .shadow : shadow
        ])
        nameLabel.textAlignment = .center
        nameLabel.attributedText = text
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showActionSheetOfImage() {
        let actionSheet = UIAlertController(
            title: "Profile Image",
            message: nil,
            preferredStyle: .actionSheet
        )
        actionSheet.addAction(UIAlertAction(
            title: "Take a Photo",
            style: .default,
            handler: { [weak self] (_) in self?.getImage(from: false) }
        ))
        actionSheet.addAction(UIAlertAction(
            title: "Choose a Photo",
            style: .default,
            handler: { [weak self] (_) in self?.getImage(from: true) }
        ))
        actionSheet.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil
        ))
        present(actionSheet, animated: true)
    }
    
    func getImage(from flag: Bool) {
        let vc = UIImagePickerController()
        vc.sourceType = !flag ? .camera : .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.editedImage] as? UIImage else { return }
        imageView.image = image
        profileVM.deleteProfileImage()
        if let url = info[.imageURL] as? URL {
            profileVM.uploadProfileImage(url)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ProfileViewController: ProfileViewModelDelegate {
    func setProfileImage(_ data: Data) {
        imageView.image = UIImage(data: data)
    }
}
