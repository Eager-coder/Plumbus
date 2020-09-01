//
//  SignUpViewModel.swift
//  Plumbus
//
//  Created by Kenes Yerassyl on 8/31/20.
//  Copyright © 2020 Kenes Yerassyl. All rights reserved.
//

import FirebaseFirestore
import FirebaseAuth

protocol SignUpViewModelDelegate: class {
    func goToHomePage()
}

class SignUpViewModel {
    
    weak var delegate: SignUpViewModelDelegate?
    
    func validate(_ fields: [String?]) -> String? {
        
        for item in fields {
            if item?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || item == nil {
                return "Not all fields are filled."
            }
        }
        
        return nil
    }
    
    func signUpButtonClicked(_ fields: [String]) {
        
        let user = User(firstName: fields[0], lastName: fields[1], email: fields[2])
    
        DatabaseManager.shared.doesUserExist(withUser: user) { [weak self] (doesExist) in
            
            guard let self = self else { return }
            guard !doesExist else {
                print("Error: User already exists")
                return
            }
            
            Auth.auth().createUser(withEmail: fields[2], password: fields[3]) { (result, error) in
        
                if let error = error {
                    print("Error in creating user: \(error.localizedDescription)")
                } else {
                    DatabaseManager.shared.insertUser(withUser: user)
                    
                    Firestore.firestore().collection("users").addDocument(data: [
                        "first_name" : fields[0],
                        "last_name" : fields[1],
                        "uid" : result!.user.uid
                    ]) { (error) in
                        if let error = error {
                            print("Error in saving user: \(error.localizedDescription)")
                        } else {
                            self.delegate?.goToHomePage()
                        }
                    }
                }
                
            }
        }
    }
}
