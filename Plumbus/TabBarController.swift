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
    private let profileVC = ProfileViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(signOut)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .compose,
            target: self,
            action: #selector(presentUsers)
        )
        navigationController?.navigationBar.barTintColor = .black
        
        tabBar.barTintColor = .black
        tabBar.tintColor = UIColor(hex: "#FF87E0")
        
        conversationVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        profileVC.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 2)
        
        viewControllers = [conversationVC, profileVC]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Users.updateUsers()
        guard UserDefaults.standard.value(forKey: "email") == nil else { return }
        let navigationController = UINavigationController(rootViewController: AuthViewController())
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: false  , completion: nil)
    }
    
    @objc func presentUsers() {
        let vc = UsersViewController()
        vc.modalPresentationStyle = .pageSheet
        present(vc, animated: true, completion: nil)
    }
    
    @objc func signOut() {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            UserDefaults.standard.removeObject(forKey: "email")
            UserDefaults.standard.removeObject(forKey: "name")
            let navigationController = UINavigationController(rootViewController: AuthViewController())
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true, completion: nil)
        } catch {
            let error = error
            print("Error in signing out: \(error.localizedDescription)")
        }
    }
    
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController.tabBarItem.tag == 2 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}
