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
    func loadingBegin()
    func loadingEnd()
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
        
        let user = User(firstName: fields[0], lastName: fields[1], email: fields[2], password: fields[3])
        delegate?.loadingBegin()
        
        guard !DatabaseManager.doesUserExist(with: user.email) else {
            self.delegate?.loadingEnd()
            print("Error: User already exists")
            return
        }
        Auth.auth().createUser(withEmail: fields[2], password: fields[3]) { [weak self] (result, error) in
            DispatchQueue.main.async { self?.delegate?.loadingEnd() }
            if let error = error {
                print("Error in creating user: \(error.localizedDescription)")
            } else
            if result != nil && DatabaseManager.addUser(with: user.email, user: user) {
                DispatchQueue.main.async { self?.delegate?.goToHomePage() }
            }
        }
    }
    
}
