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
    
    private let conversationVC = ConversationViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(signOut))
        conversationVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        
        viewControllers = [conversationVC]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard FirebaseAuth.Auth.auth().currentUser == nil else { return }
        let navigationController = UINavigationController(rootViewController: AuthViewController())
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: false  , completion: nil)
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
