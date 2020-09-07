//
//  DatabaseManager.swift
//  Plumbus
//
//  Created by Kenes Yerassyl on 9/1/20.
//  Copyright © 2020 Kenes Yerassyl. All rights reserved.
//


import FirebaseFirestore
import FirebaseFirestoreSwift

final class DatabaseManager {
    
    static let db = Firestore.firestore()
    static let usersRef = db.collection("users")
    
}

// MARK: - User functions
extension DatabaseManager {
    static func addUser(with email: String, user: User) -> Bool {
        do {
            try db.collection("users").document(email).setData(from: user)
            return true
        } catch let error {
            print("Error in adding user: \(error.localizedDescription)")
        }
        return false
    }
    
    static func changeFieldOfUser(with email: String, fields: [AnyHashable : Any]) {
        db.collection("users").document(email).updateData(fields) { (error) in
            guard let error = error else { return }
            print("Error in updating user field: \(error.localizedDescription)")
        }
    }
    
    static func doesUserExist(with email: String) -> Bool {
        var result = false
        db.collection("users").document(email).getDocument { (documentSnapshot, error) in
            guard let document = documentSnapshot else { result = false; return }
            result = document.exists
        }
        return result
    }

}
