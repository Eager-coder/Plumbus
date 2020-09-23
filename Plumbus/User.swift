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
                    guard
                        let firstName = item["first_name"] as? String,
                        let lastName = item["last_name"] as? String,
                        let email = item["email"] as? String,
                        let password = item["password"] as? String,
                        let profileImageURL = item["profile_image"] as? String?
                    else {
                        continue
                    }
                    users.append(User(
                        firstName: firstName,
                        lastName: lastName,
                        email: email,
                        password: password,
                        profileImageURL: profileImageURL
                    ))
                }
            }
        }
    }
}
