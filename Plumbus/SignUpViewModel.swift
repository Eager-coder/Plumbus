//
//  SignUpViewModel.swift
//  Plumbus
//
//  Created by Kenes Yerassyl on 8/31/20.
//  Copyright © 2020 Kenes Yerassyl. All rights reserved.
//

import Firebase
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
        Auth.auth().createUser(withEmail: fields[2], password: fields[3]) { (result, error) in
            if let error = error {
                print("Error in creating user: \(error.localizedDescription)")
            } else {
                Firestore.firestore().collection("users").addDocument(data: [
                    "firstname" : fields[0],
                    "lastname" : fields[1],
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
