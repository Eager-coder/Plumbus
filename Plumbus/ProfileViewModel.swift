//
//  ProfileViewModel.swift
//  Plumbus
//
//  Created by Kenes Yerassyl on 9/1/20.
//  Copyright © 2020 Kenes Yerassyl. All rights reserved.
//

import FirebaseAuth
import FirebaseFirestore

protocol ProfileViewModelDelegate: class {
    func setProfileImage(_ data: Data)
}

class ProfileViewModel {
    
    weak var delegate: ProfileViewModelDelegate?
    var user: User?

    init() {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else { return }
        DatabaseManager.usersRef.document(email).getDocument { (documentSnapshot, error) in
            let result = Result {
                try documentSnapshot?.data(as: User.self)
            }
            switch result {
            case .success(let user):
                guard let user = user else { return }
                self.user = user
            case .failure(let error):
                print("Error in decoding user: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteProfileImage() {
        StorageManager.deleteImage(in: "profile_images", withName: user?.profileImageURL ?? "")
    }
    
    func uploadProfileImage(_ url: URL) {
        StorageManager.uploadImage(
            to: "profile_images",
            from: url,
            newName: "\(user?.email ?? "default_email")_profile_image"
        )
        guard let email = user?.email else { return }
        DatabaseManager.changeFieldOfUser(with: email, fields: ["profile_image" : "\(email)_profile_image.jpg"])
        user?.profileImageURL = "\(email)_profile_image.jpg"
    }
    
    func downloadProfileImage() {
        let ref = StorageManager.storageRef.child("profile_images/\(user?.profileImageURL ?? "")")
        ref.getData(maxSize: 15 * 1024 * 1024) { (data, error) in
            guard let data = data else {
                print("Error in getting data: \(error?.localizedDescription ?? "")")
                return
            }
            DispatchQueue.main.async { self.delegate?.setProfileImage(data) }
        }
    }
}
