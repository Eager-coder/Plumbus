//
//  TabBarViewController.swift
//  Plumbus
//
//  Created by Kenes Yerassyl on 8/31/20.
//  Copyright © 2020 Kenes Yerassyl. All rights reserved.
//

import UIKit
import FirebaseAuth

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        view.backgroundColor = .cyan
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(signOut))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let navigationController = UINavigationController(rootViewController: AuthViewController())
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: false , completion: nil)
        } else {
            
        }
    }
    
    @objc func signOut() {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            let navigationController = UINavigationController(rootViewController: AuthViewController())
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true, completion: nil)
        } catch {
            let error = error
            print("Error in signing out: \(error.localizedDescription)")
        }
    }
    
}
