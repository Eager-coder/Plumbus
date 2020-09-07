//
//  SignUpViewController.swift
//  Plumbus
//
//  Created by Kenes Yerassyl on 8/31/20.
//  Copyright © 2020 Kenes Yerassyl. All rights reserved.
//

import UIKit
import JGProgressHUD

class SignUpViewController: UIViewController {
    
    private let const: CGFloat = 20.0
    private let signUpVM = SignUpViewModel()
    private let nameFirstTextField = UITextField()
    private let nameLastTextField = UITextField()
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
        
        signUpVM.delegate = self
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
            make.height.equalTo(view.frame.height * 0.75)
        }
        
        let gradient = CAGradientLayer()
        boxView.layer.addSublayer(gradient)
        gradient.colors = [UIColor(hex: "#09FBD3").cgColor, UIColor(hex: "FE53BB").cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.frame = CGRect(origin: .zero, size: CGSize(width: view.frame.width - const * 2, height: view.frame.height * 0.75))
        
        boxView.alpha = 0.9
        boxView.layer.masksToBounds = true
        boxView.layer.cornerRadius = 30
        
        // First Name Label
        let nameFirstLabel = UILabel()
        boxView.addSubview(nameFirstLabel)
        nameFirstLabel.snp.makeConstraints { make in
            make.top.equalTo(boxView).offset(const)
            make.leading.equalTo(boxView).offset(const)
            make.trailing.equalTo(boxView).offset(-const)
            make.height.equalTo(view.frame.height * 0.04)
        }
        nameFirstLabel.text = "First Name"
        nameFirstLabel.font = UIFont(name: "UniversalJack", size: 24)
        
        // First Name TextField
        boxView.addSubview(nameFirstTextField)
        nameFirstTextField.snp.makeConstraints { make in
            make.top.equalTo(nameFirstLabel.snp.bottom).offset(const / 2)
            make.leading.equalTo(boxView).offset(const)
            make.trailing.equalTo(boxView).offset(-const)
            make.height.equalTo(view.frame.height * 0.08)
        }
        nameFirstTextField.backgroundColor = .white
        nameFirstTextField.layer.cornerRadius = 20
        nameFirstTextField.setLeftPaddingPoints(20)
        nameFirstTextField.setRightPaddingPoints(20)
        nameFirstTextField.layer.addSublayer(getInnerShadow())

        // Last Name Label
        let nameLastLabel = UILabel()
        boxView.addSubview(nameLastLabel)
        nameLastLabel.snp.makeConstraints { make in
            make.top.equalTo(nameFirstTextField.snp.bottom).offset(const)
            make.leading.equalTo(boxView).offset(const)
            make.trailing.equalTo(boxView).offset(-const)
            make.height.equalTo(view.frame.height * 0.04)
        }
        nameLastLabel.text = "Last Name"
        nameLastLabel.font = UIFont(name: "UniversalJack", size: 24)
        
        // Last Name TextField
        boxView.addSubview(nameLastTextField)
        nameLastTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLastLabel.snp.bottom).offset(const / 2)
            make.leading.equalTo(boxView).offset(const)
            make.trailing.equalTo(boxView).offset(-const)
            make.height.equalTo(view.frame.height * 0.08)
        }
        nameLastTextField.backgroundColor = .white
        nameLastTextField.layer.cornerRadius = 20
        nameLastTextField.setLeftPaddingPoints(20)
        nameLastTextField.setRightPaddingPoints(20)
        nameLastTextField.layer.addSublayer(getInnerShadow())
    
        // Email Label
        let emailLabel = UILabel()
        boxView.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLastTextField.snp.bottom).offset(const)
            make.leading.equalTo(boxView).offset(const)
            make.trailing.equalTo(boxView).offset(-const)
            make.height.equalTo(view.frame.height * 0.04)
        }
        emailLabel.text = "Email"
        emailLabel.font = UIFont(name: "UniversalJack", size: 24)

        // Email TextField
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

        // Password Label
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

        // Password TextField
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
        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.addSublayer(getInnerShadow())
    
        
//      signUpButton
        let signUpButton = UIButton()
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(const)
            make.height.equalTo(view.frame.height * 0.07)
            make.width.equalTo(view.frame.width * 0.45)
            make.centerX.equalToSuperview()
        }
        signUpButton.backgroundColor = UIColor(hex: "#3CB9FC")
        signUpButton.layer.cornerRadius = 17
        signUpButton.layer.borderWidth = 2.0;
        signUpButton.layer.borderColor = UIColor.clear.cgColor
        signUpButton.layer.shadowColor = UIColor.black.cgColor
        signUpButton.layer.shadowOpacity = 0.4
        signUpButton.layer.shadowRadius = 10
        signUpButton.layer.shadowOffset = CGSize(width: 4, height: 5);
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.titleLabel?.font = UIFont(name: "UniversalJack", size: 24)
        signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
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
    
    @objc func signUpButtonClicked() {
        if let errorMessage = signUpVM.validate([nameFirstTextField.text, nameLastTextField.text, emailTextField.text, passwordTextField.text]) {
            // TODO: show error
        } else {
            signUpVM.signUpButtonClicked([
                nameFirstTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines),
                nameLastTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines),
                emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines),
                passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            ])
        }
    }
}

extension SignUpViewController: SignUpViewModelDelegate {
    func goToHomePage(email: String, name: String) {
        
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(name, forKey: "name")
        
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func loadingBegin() {
        spinner.show(in: view, animated: true)
    }
    
    func loadingEnd() {
        spinner.dismiss(animated: true)
    }
}
