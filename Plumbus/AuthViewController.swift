//
//  AuthViewController.swift
//  Plumbus
//
//  Created by Kenes Yerassyl on 8/23/20.
//  Copyright © 2020 Kenes Yerassyl. All rights reserved.
//

import UIKit
import SnapKit

class AuthViewController: UIViewController {
    
    private let const: CGFloat = 20.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .black
        updateBackground()
        updatePlumbusLabel()
        updateRegistration()
    }
    
    func updateBackground() {
        let backgroundImageView = UIImageView()
        view.addSubview(backgroundImageView)
        backgroundImageView.image = UIImage(named: "cool-rick")
        let imageSize = backgroundImageView.image?.size
        let mult = max(view.frame.width / (imageSize?.width)!, view.frame.height / (imageSize?.height)!)
        backgroundImageView.frame = CGRect(origin: .zero, size: CGSize(width: (imageSize?.width)! * mult, height: (imageSize?.height)! * mult))
        backgroundImageView.alpha = 0.5
    }
    
    func updatePlumbusLabel() {
        let label = UILabel()
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(const * 2.5)
            make.width.equalTo(view.frame.width * 0.9)
            make.centerX.equalToSuperview()
            make.height.equalTo(view.frame.height * 0.2)
        }
        
        let shadow = NSShadow()
        shadow.shadowColor = UIColor(hex: "#FF87E0")
        shadow.shadowOffset = CGSize(width: 0.0, height: 0.0)
        shadow.shadowBlurRadius = 10.0
        let text = NSAttributedString(string: "PLUMBUS", attributes: [
            .font : UIFont(name: "UniversalJack", size: 66) as Any,
            .strokeWidth : -2.0,
            .strokeColor : UIColor.cyan,
            .foregroundColor : UIColor(hex: "#FF87E0"),
            .shadow : shadow
        ])
        
        label.textAlignment = .center
        label.attributedText = text
    }
    
    func updateRegistration() {
        let boxView = UIView()
        view.addSubview(boxView)
        boxView.snp.makeConstraints { make in
            make.bottom.equalTo(view).offset(-const)
            make.leading.equalTo(view).offset(const)
            make.trailing.equalTo(view).offset(-const)
            make.height.equalTo(view.frame.height * 0.55)
        }
        
        let gradient = CAGradientLayer()
        boxView.layer.addSublayer(gradient)
//        gradient.colors = [UIColor(hex: "#08F7FE").cgColor, UIColor(hex: "#09FBD3").cgColor, UIColor(hex: "FE53BB").cgColor, UIColor(hex: "F5D300").cgColor]
        gradient.colors = [UIColor(hex: "#09FBD3").cgColor, UIColor(hex: "FE53BB").cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.frame = CGRect(origin: .zero, size: CGSize(width: view.frame.width - const * 2, height: view.frame.height * 0.55))
        
        boxView.alpha = 0.9
        boxView.layer.masksToBounds = true
        boxView.layer.cornerRadius = 30
        
        
        let emailLabel = UILabel()
        boxView.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(boxView).offset(const)
            make.leading.equalTo(boxView).offset(const)
            make.trailing.equalTo(boxView).offset(-const)
            make.height.equalTo(view.frame.height * 0.04)
        }
        emailLabel.text = "Email"
        emailLabel.font = UIFont(name: "UniversalJack", size: 24)
        
        let emailTextField = UITextField()
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(const / 2)
            make.leading.equalTo(boxView).offset(const)
            make.trailing.equalTo(boxView).offset(-const)
            make.height.equalTo(view.frame.height * 0.08)
        }
        emailTextField.backgroundColor = .white
        emailTextField.layer.cornerRadius = 20
        
        let passwordLabel = UILabel()
        boxView.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(const)
            make.leading.equalTo(boxView).offset(const)
            make.trailing.equalTo(boxView).offset(-const)
            make.height.equalTo(view.frame.height * 0.04)
        }
        passwordLabel.text = "Password"
        passwordLabel.font = UIFont(name: "UniversalJack", size: 24)
        
        let passwordTextField = UITextField()
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(const / 2)
            make.leading.equalTo(boxView).offset(const)
            make.trailing.equalTo(boxView).offset(-const)
            make.height.equalTo(view.frame.height * 0.08)
        }
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.cornerRadius = 20
    }
}
