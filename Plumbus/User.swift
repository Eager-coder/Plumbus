//
//  User.swift
//  Plumbus
//
//  Created by Kenes Yerassyl on 9/1/20.
//  Copyright © 2020 Kenes Yerassyl. All rights reserved.
//

struct User: Codable {
    var firstName: String
    var lastName: String
    var email: String 
    var password: String
    var profileImageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case password
        case profileImageURL = "profile_image"
    }
}

class Users {
    static var users = [User]()
    
    static func updateUsers() {
        DatabaseManager.db.collection("users").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error in updating users: \(error.localizedDescription)")
            } else {
                guard let querySnapshot = querySnapshot else { return }
                users.removeAll()
                for item in querySnapshot.documents {
                    guard let email = item.get("email") as? String else { continue }
                    DatabaseManager.db.collection("users").document(email).getDocument { (documentSnapshot, error) in
                        let result = Result {
                            try documentSnapshot?.data(as: User.self)
                        }
                        switch result {
                        case .success(let user):
                            guard let user = user else { return }
                            users.append(user)
                        case .failure(let error):
                            print("Error in getting document: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
    }
}
