//
//  StorageManager.swift
//  Plumbus
//
//  Created by Kenes Yerassyl on 9/2/20.
//  Copyright © 2020 Kenes Yerassyl. All rights reserved.
//

import FirebaseStorage

final class StorageManager {
    
    static var storage = Storage.storage()
    static var storageRef = storage.reference()
    
    static func uploadImage(to folder: String, from url: URL, newName: String) {
        let ref = storage.reference().child("\(folder)/\(newName).jpg")
        ref.putFile(from: url, metadata: nil) { (metadata, error) in
            guard let error = error else { return }
            print("Error in uploading file: \(error.localizedDescription)")
        }.resume()
    }
    
    static func deleteImage(in folder: String, withName: String) {
        let ref = storage.reference().child("\(folder)/\(withName)")
        ref.delete { (error) in
            guard let error = error else { return }
            print("Error in deleting file: \(error.localizedDescription)")
        }
    }
    
}
