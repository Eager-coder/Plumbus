//
//  AuthViewController.swift
//  Plumbus
//
//  Created by Kenes Yerassyl on 8/23/20.
//  Copyright © 2020 Kenes Yerassyl. All rights reserved.
//

import UIKit
import SnapKit
import JGProgressHUD

class AuthViewController: UIViewController{
    private let const: CGFloat = 20.0
    private let authVM = AuthViewModel()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let spinner = JGProgressHUD(style: .dark)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .black
        updateBackground()
        updatePlumbusLabel()
        updateRegistration()
        
        authVM.delegate = self
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
        // boxView
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
        gradient.colors = [UIColor(hex: "#09FBD3").cgColor, UIColor(hex: "FE53BB").cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.frame = CGRect(origin: .zero, size: CGSize(width: view.frame.width - const * 2, height: view.frame.height * 0.55))
        
        boxView.alpha = 0.9
        boxView.layer.masksToBounds = true
        boxView.layer.cornerRadius = 30
        
        // emailLabel
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
        
        // emailTextField
        boxView.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(const / 2)
            make.leading.equalTo(boxView).offset(const)
            make.trailing.equalTo(boxView).offset(-const)
            make.height.equalTo(view.frame.height * 0.08)
        }
        emailTextField.backgroundColor = .white
        emailTextField.layer.cornerRadius = 20
        emailTextField.setLeftPaddingPoints(20)
        emailTextField.setRightPaddingPoints(20)
        emailTextField.layer.addSublayer(getInnerShadow())

        // passwordLabel
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
        
        // passwordTextField
        boxView.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(const / 2)
            make.leading.equalTo(boxView).offset(const)
            make.trailing.equalTo(boxView).offset(-const)
            make.height.equalTo(view.frame.height * 0.08)
        }
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.cornerRadius = 20
        passwordTextField.setLeftPaddingPoints(20)
        passwordTextField.setRightPaddingPoints(20)
        passwordTextField.layer.addSublayer(getInnerShadow())
        passwordTextField.isSecureTextEntry = true
    
        
        //signInButton
        // TODO: Add selector
        let signInButton = UIButton()
        view.addSubview(signInButton)
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(const * 2)
            make.height.equalTo(view.frame.height * 0.07)
            make.width.equalTo(view.frame.width * 0.45)
            make.centerX.equalToSuperview()
        }
        signInButton.backgroundColor = UIColor(hex: "#3CB9FC")
        signInButton.layer.cornerRadius = 17
        signInButton.layer.borderWidth = 2.0;
        signInButton.layer.borderColor = UIColor.clear.cgColor
        signInButton.layer.shadowColor = UIColor.black.cgColor
        signInButton.layer.shadowOpacity = 0.4
        signInButton.layer.shadowRadius = 10
        signInButton.layer.shadowOffset = CGSize(width: 4, height: 5);
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.setTitleColor(.black, for: .normal)
        signInButton.titleLabel?.font = UIFont(name: "UniversalJack", size: 24)
        signInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)

        //signUpLabel
        let signUpLabel = UILabel()
        view.addSubview(signUpLabel)
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(const)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.frame.width * 0.45)
            make.height.equalTo(view.frame.height * 0.035)
        }
        let text = NSAttributedString(string: "Sign Up", attributes: [
            .font : UIFont(name: "Courier", size: 18) as Any
        ])
        signUpLabel.textAlignment = .center
        signUpLabel.attributedText = text
        signUpLabel.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(showSignUpPage))
        signUpLabel.addGestureRecognizer(tap)
        
    }
    
    func getInnerShadow() -> CALayer {
        let innerShadow = CALayer()
        innerShadow.frame = CGRect(origin: .zero, size: CGSize(width: view.frame.width - const * 4, height: view.frame.height * 0.08))
        let path = UIBezierPath(roundedRect: innerShadow.bounds.insetBy(dx: -3, dy: -3), cornerRadius: 20)
        let cutout = UIBezierPath(roundedRect: innerShadow.bounds, cornerRadius: 20).reversing()
        path.append(cutout)
        innerShadow.shadowPath = path.cgPath
        innerShadow.masksToBounds = true
        innerShadow.shadowColor = UIColor.black.cgColor
        innerShadow.shadowOffset = CGSize(width: 0, height: 0)
        innerShadow.shadowOpacity = 1
        innerShadow.shadowRadius = 4
        innerShadow.cornerRadius = 20
        return innerShadow
    }
    
    @objc func showSignUpPage() {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    @objc func signInButtonClicked() {
        if let errorMessage = authVM.validate([emailTextField.text, passwordTextField.text]) {
            // TODO: show error
        } else {
            authVM.signInButtonClicked([
                emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines),
                passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            ])
        }
    }
}

extension AuthViewController: AuthViewModelDelegate {
    func loadingBegin() {
        spinner.show(in: view, animated: true)
    }
    
    func loadingEnd() {
        spinner.dismiss(animated: true)
    }
    
    func goToHomePage() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
