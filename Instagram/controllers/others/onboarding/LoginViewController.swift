//
//  LoginViewController.swift
//  Instagram
//
//  Created by robusta on 05/05/2024.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let headerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        let backgroundImageView = UIImageView(image: UIImage(named: "gradient"))
        view.layer.cornerRadius = Constants.cornerRadius * 3
        view.addSubview(backgroundImageView)
        return view
    }()
    
    private let userEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or Email..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .systemGray6
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password..."
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .systemGray6
        field.isSecureTextEntry = true
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .link
        button.layer.cornerRadius = Constants.cornerRadius
        return button
    }()
    
    private let termsButton: UIButton = {
       let button = UIButton()
        button.setTitle("Terms & Conditions", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
       return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("New User? Create an Account", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(createAccountButtonTapped), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(TermsButtonTapped), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(PrivacyButtonTapped), for: .touchUpInside)
        
        addSubViews()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        userEmailField.delegate = self
        passwordField.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // setup views layout
        headerView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: view.width,
                                  height: view.frame.height / 3.0)
        configureHeaderView()
        
        userEmailField.frame = CGRect(x: 25,
                                      y: headerView.bottom + 60,
                                      width: view.width - 50,
                                      height: 52.0)
        
        passwordField.frame = CGRect(x: 25,
                                      y: userEmailField.bottom + 15,
                                      width: view.width - 50,
                                      height: 52.0)
        
        loginButton.frame = CGRect(x: 25,
                                      y: passwordField.bottom + 15,
                                      width: view.width - 50,
                                      height: 52.0)
        
        createAccountButton.frame = CGRect(x: 25,
                                      y: loginButton.bottom + 15,
                                      width: view.width - 50,
                                      height: 52.0)
        
        termsButton.frame = CGRect(x: 10,
                                   y: view.height - view.safeAreaInsets.bottom - 100,
                                      width: view.width - 20,
                                      height: 50.0)
        
        privacyButton.frame = CGRect(x: 10,
                                      y: view.height - view.safeAreaInsets.bottom - 50,
                                      width: view.width - 20,
                                      height: 50.0)
        
    }
    
    func configureHeaderView(){
        
        guard headerView.subviews.count == 1 else {
            return
        }

        guard let backgroundView = headerView.subviews.first else {
            return
        }

        backgroundView.frame = headerView.bounds
        
        let imageView = UIImageView(image: UIImage(named: "logo3"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width / 4.0,
                                 y: view.safeAreaInsets.top,
                                 width: headerView.width / 2.0,
                                 height: headerView.height - view.safeAreaInsets.top)
    }
    
    func addSubViews() {
        view.addSubview(headerView)
        view.addSubview(userEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(createAccountButton)
    }
    
    @objc func loginButtonTapped(){
        userEmailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let userEmail = userEmailField.text, !userEmail.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
                   return
        }
        
        var email: String?
        var username: String?
        
        if userEmail.contains("@") , userEmail.contains(".") {
            email = userEmail
        }else {
            username = userEmail
        }
        
        AuthManager.shared.loginUser(username: username, email: email, password: password) { success in
            DispatchQueue.main.async {
                if success {
                    self.dismiss(animated: true)
                }else {
                    let alert = UIAlertController(title: "Login Error !", message: "We are unable to login...", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive))
                    self.present(alert, animated: true)
                }
            }
            
        }
    }
    
    @objc func createAccountButtonTapped(){
        let vc = RegisterViewController()
        vc.title = "Create Account"
        present(UINavigationController(rootViewController: vc), animated: true)
        
    }
    
    @objc func TermsButtonTapped(){
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc func PrivacyButtonTapped(){
        guard let url = URL(string: "https://help.instagram.com/196883487377501") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }

}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userEmailField {
            passwordField.becomeFirstResponder()
        }else if textField == passwordField {
            loginButtonTapped()
        }
        return true
    }
}
