//
//  AuthViewModel.swift
//  Plumbus
//
//  Created by Kenes Yerassyl on 8/31/20.
//  Copyright © 2020 Kenes Yerassyl. All rights reserved.
//

import FirebaseAuth

protocol AuthViewModelDelegate: class {
    func goToHomePage()
}

class AuthViewModel {
    weak var delegate: AuthViewModelDelegate?
    
    func validate(_ fields: [String?]) -> String? {
        for item in fields {
            if item?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || item == nil {
                return "Not all fields are filled."
            }
        }
        return nil
    }
    
    func signInButtonClicked(_ fields: [String]) {
        Auth.auth().signIn(withEmail: fields[0], password: fields[1]) { [weak self] (result, error) in
            guard let self = self else { return }
            if let error = error {
                print("Error in signing in: \(error.localizedDescription)")
            } else {
                self.delegate?.goToHomePage()
            }
        }
    }
}
