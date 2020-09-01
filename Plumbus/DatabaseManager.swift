//
//  DatabaseManager.swift
//  Plumbus
//
//  Created by Kenes Yerassyl on 9/1/20.
//  Copyright © 2020 Kenes Yerassyl. All rights reserved.
//

import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
    
}

extension DatabaseManager {
    
    public func insertUser(withUser user: User) {
        database.child(user.getFormattedEmail()).setValue([
            "first_name" : user.firstName,
            "last_name" : user.lastName
        ])
    }
    
    public func doesUserExist(withUser user: User, completion: @escaping ((Bool) -> Void)) {
        database.child(user.getFormattedEmail()).observeSingleEvent(of: .value) { (dataSnapshot) in
            completion((dataSnapshot.value as? String) != nil)
        }
    }
}

struct User {
    let firstName: String
    let lastName: String
    let email: String
    
    func getFormattedEmail() -> String {
        return email.replacingOccurrences(of: ".", with: "+")
    }
    // TODO: add other stuff
}
