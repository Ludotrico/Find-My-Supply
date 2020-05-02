
//  ViewController.swift
//  findMySupply2
//
//  Created by Ludovico Veniani on 3/27/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import UIKit
import SwiftUI
import CryptoSwift

class LoginController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureViewComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !verified && UserDefaults.standard.bool(forKey: "firstLaunch"){
            showSentEmail(message: "VVerification email sent. Tap to resend.")
        }
    }
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        
        return view
    }()
    
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "tpTransp")
        return iv
    }()
    

    lazy var loginContainerView: UIView = {
        let view = UIView()
        return view.textContainerView(view: view, UIImage(systemName: "person")!.withTintColor(.white, renderingMode: .alwaysOriginal), loginTextField!)
    }()
    
    lazy var passwordContainerView: UIView = {
        let view = UIView()
        return view.textContainerView(view: view, UIImage(systemName: "lock")!.withTintColor(.white, renderingMode: .alwaysOriginal),passwordTextField!)
    }()
    
    lazy var loginTextField: UITextField? = {
        var tf = UITextField()
        tf = tf.textField(withPlaceolder: "Username or email", isSecureTextEntry: false, isTextEntry: true)
        tf.autocapitalizationType = .none
        return tf
    }()
    
    lazy var passwordTextField: UITextField? = {
        let tf = UITextField()
        return tf.textField(withPlaceolder: "Password", isSecureTextEntry: true, isTextEntry: true)
    }()
    
    var errorMessage: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 16.0)
        label.textColor = .white
        label.numberOfLines = 10
        label.text=""
        return label
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign in", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(Color.shared.blue, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    
    let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: "Sign up", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: Color.shared.gold]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowRegister), for: .touchUpInside)
        return button
    }()
    
    let forgotPasswordBtn: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Forgot password?", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: Color.shared.gold])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(sendResetPswEmail), for: .touchUpInside)
        button.clipsToBounds = true
        button.titleLabel?.sizeToFit()
        return button
    }()
    
    
    //MARK VARIABLES
    var verified = false
    var forgotPassword = false
    
    @objc func handleLogin(){
        loginTextField?.resignFirstResponder()
        passwordTextField?.resignFirstResponder()
        

            
            var login = ""
            var psw = ""
            
        
        if loginTextField?.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true || passwordTextField?.text?.isEmpty ?? true {
            if loginTextField?.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true{
                    showMessage(label: createLbl(text: "Username or email required."))
                    return
                }
            if passwordTextField?.text?.isEmpty ?? true {
                    showMessage(label: createLbl(text: "Password required."))
                    return
                }
            }
            else {
                if let l = loginTextField?.text {
                    login = l.trim()
                    
                    if l.count > 60 {
                        showMessage(label: createLbl(text: "Username or email is too long.\n"))
                        return
                    }
                    else if login.contains(" ") {
                        showMessage(label: createLbl(text: "Username or email cannot contain spaces."))
                        return
                    }

                }
                if let p = passwordTextField?.text {
                    psw = p
                    if p.count < 5 {
                        showMessage(label: createLbl(text: "Password must be at least 5 characters."))
                        return
                    }
                    else if p.count > 100  {
                        showMessage(label: createLbl(text: "Password is too long."))
                        return
                    }
                }
            }
    
            let userAuth = UserAuth.shared
            self.loginButton.isEnabled = false
            DispatchQueue.global(qos: .userInitiated).async {
                print("\n\n\n======================START==================\n")
                userAuth.initLoginUser(withLogin: login, withPassword: psw)
                userAuth.fetchUserInfo { (result) in
                    switch result {
                        case .success(let user):
                            print("Completed User Fetch with user: \(user)\n")
                            DispatchQueue.main.async {
                                let firstChar = user.message.first
                                if firstChar == "#" {
                                    self.showMessage(label: self.createLbl(text: "Username or email not found."))
                                }
                                else {
                                
                                    print("=====Server salt:\(user.salt)\n\(user.password)")
                                    print("=====Local psw: \((psw+user.salt).sha256())\n")
                                    if user.password != (psw+user.salt).sha256() {
                                        if user.identifiedByEmail {
                                            self.showMessage(label: self.createLbl(text: "Incorrect password for given email."))
                                        }
                                        else {
                                            self.showMessage(label: self.createLbl(text: "Incorrect password for given username."))
                                        }
                                    }else {
                                        if firstChar == "F" {
                                            //User is unverified, (not a typo)
                                            self.showSentEmail(message: "VVerification email sent. Tap to resend.")
                                        } else {
                                            UserDefaults.standard.set(true, forKey: "isRegistered")
                                            UserDefaults.standard.set("\(user.fName)", forKey: "fName")
                                            UserDefaults.standard.set("\(user.email)", forKey: "email")
                                            UserDefaults.standard.set("\(user.username)", forKey: "username")
                                            UserDefaults.standard.set("\(user.ID)", forKey: "userID")
                                            UserDefaults.standard.set("\(user.salt)", forKey: "salt")
                                            UserDefaults.standard.set("\(user.password)", forKey: "password")
                                            (UserDefaults.standard.integer(forKey: "radius") == 0) ? UserDefaults.standard.set(10, forKey: "radius") : nil
                                            UserDefaults.standard.set(10, forKey: "submissionsRemaining")
                                            UserDefaults.standard.set(true, forKey: "firstLaunch")
                                            
        //                                        if UserDefaults.standard.string(forKey: "askedForNotification") == nil {
        //                                            UserDefaults.standard.set("not asked", forKey: "askedForNotification")
        //                                        }
                                            self.navigationController?.popToRootViewController(animated: true)
                                        }
                                    }
                                }
                                
                                self.loginButton.isEnabled = true
                                print("Updated Register Obj salt\n")
                            }
                        case .failure(let error):
                            print("DEBUG: Failed with error \(error)")

                    }
                }

                       
                        
                }
            
                
    }
    
    @objc func sendResetPswEmail() {
        loginTextField?.resignFirstResponder()
        passwordTextField?.resignFirstResponder()
    
            var login = ""

        if loginTextField?.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true {
                if loginTextField?.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true{
                    showMessage(label: createLbl(text: "Username or email required."))
                    return
                }
            }
            else {
                if let l = loginTextField?.text {
                    login = l.trim()
                    
                    if l.count > 60 {
                        showMessage(label: createLbl(text: "Username or email is too long.\n"))
                        return
                    }
                    else if login.contains(" ") {
                        showMessage(label: createLbl(text: "Username or email cannot contain spaces."))
                        return
                    }

                }
            }
        
        
        DispatchQueue.global(qos: .userInitiated).async {
            UserAuth.shared.login = login
            UserAuth.shared.sendResetPasswordEmail { (result) in
                switch result {
                    case .success(var m):
                        DispatchQueue.main.async {
                             let firstChar = m.first
                             if firstChar == "#" {
                                 m.removeFirst()
                                 self.showMessage(label: self.createLbl(text: m))
                                 return
                             }

                             self.showSentEmail(message: m)
                            print("++ SET IT TO TRUE")
                            UserDefaults.standard.set(true, forKey: "tappedForgotPassword")
                            UserDefaults.standard.set(login, forKey: "login")
                            self.checkIfForgotPassword()
                   
                        }



            
                    case .failure(let error):
                        print("DEBUG: Failed with error \(error)")
                    
                }
            }
        }
    }
    
      func checkIfForgotPassword() {
          DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 3) {
              self.checkVerification()
          }
          
    
          
      }
      
      
      func checkVerification() {
          DispatchQueue.global(qos: .userInitiated).async {
              UserAuth.shared.checkIfForgotPassword { (result) in
                  DispatchQueue.main.async {
                      switch result {
                      case .success(let bool):
                          if bool {
                              UserDefaults.standard.set(true, forKey: "forgotPassowrd")
                              self.navigationController?.pushViewController(ForgotPasswordController(), animated: true)
                              self.forgotPassword = true
                          }
                          if !self.forgotPassword {
                              self.checkIfForgotPassword()
                          }
                          
                      case .failure(let error):
                          print("DEBUG: Failed with error \(error)")
                          
                      }
                  }
              }
          }
      }
    
    @objc func sendVerificationEmail() {
        print("=== RESENT")
        DispatchQueue.global(qos: .userInitiated).async {
            UserAuth.shared.sendVerificationEmail { (result) in
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        //VV is not a typo
                        self.showSentEmail(message: "VVerification email sent. Tap to resend.")
                    }
                    
                    
                case .failure(let error):
                    print("DEBUG: Failed with error \(error)")
                    
                }
                
            }
        }
    }
    
    
    @objc func handleShowRegister() {
        print("handling sign up")
        navigationController?.pushViewController(RegisterController(), animated: true)
    }

    func configureViewComponents() {
        view.backgroundColor = Color.shared.theme
            navigationController?.navigationBar.isHidden = true
        
            view.addSubview(scrollView)
            scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
            
            scrollView.addSubview(logoImageView)
            logoImageView.anchor(top: scrollView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 150)
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            
            scrollView.addSubview(loginContainerView)
            loginContainerView.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
            
            scrollView.addSubview(passwordContainerView)
            passwordContainerView.anchor(top: loginContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
            
        scrollView.addSubview(forgotPasswordBtn)
        forgotPasswordBtn.anchor(top: passwordContainerView.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 32)
        
            scrollView.addSubview(loginButton)
            loginButton.anchor(top: passwordContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)

    

            scrollView.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 32, paddingBottom: 16, paddingRight: 32, width: 0, height: 50)
        
            let h = logoImageView.frame.height + 60 + 206
            scrollView.contentSize = CGSize(width: view.frame.width, height: h)
            
            configureColorScheme()
        }
    
    func configureColorScheme() {
        StatusBarColor.shared.isDark = false
        UIView.animate(withDuration: 0.5, animations: {
             self.setNeedsStatusBarAppearanceUpdate()
        })
    }
    
    func showMessage(label: UILabel) {
        

        self.view.addSubview(label)
        label.alpha = 1
        
      //     self.noNearbyStoresLbl.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        label.frame = CGRect(x: 0 ,y: self.view.frame.height, width: (self.view.frame.width/4)*3, height: 50)
        label.center.x = view.center.x
     
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                label.frame = CGRect(x: 0, y: self.view.frame.height - 120, width: (self.view.frame.width/4)*3, height: 50)
                label.center.x = self.view.center.x
            }, completion: { _ in
                    UIView.animate(withDuration: 2, delay: 2, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        label.alpha = 0
                    }, completion: { _ in
                        
                        label.removeFromSuperview()
                        label.alpha = 1
                    })
            })
        
    }
    
    func createLbl(text: String) -> UILabel {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.rgb(red: 209, green: 21, blue: 0)
        lbl.textColor = .white
        lbl.text = text
        lbl.font = UIFont.italicSystemFont(ofSize: 15.0)
        //lbl.sizeToFit()
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        //lbl.adjustsFontSizeToFitWidth  = true
        lbl.layer.cornerRadius = 10
        return lbl
    }
    
    func showSentEmail(message: String) {
        
        var m = message
        let firstChar = m.removeFirst()
        
        var isVerificationEmail = false
        
        if firstChar == "V" {
            isVerificationEmail = true
        }
        
    
        let label = UIButton()

        label.backgroundColor = .systemGreen
        label.setTitleColor(.white, for: .normal)
        label.setTitle(m, for: .normal)
        label.titleLabel?.font = UIFont.italicSystemFont(ofSize: 15.0)
        if isVerificationEmail {
             label.addTarget(self, action:  #selector(sendVerificationEmail), for: .touchUpInside)
        } else {
             label.addTarget(self, action:  #selector(sendResetPswEmail)     , for: .touchUpInside)
        }
       
        label.titleLabel?.textAlignment = .center
        label.titleLabel?.numberOfLines = 1
        label.titleLabel?.adjustsFontSizeToFitWidth  = true
        label.layer.cornerRadius = 0
        label.titleLabel?.baselineAdjustment = .alignCenters
        label.titleLabel?.lineBreakMode = .byClipping
        
        
        
        
        self.view.addSubview(label)
        
//
        
        view.bringSubviewToFront(label)

        
        label.alpha = 1
        

        label.frame = CGRect(x: 0 ,y: 0, width: self.view.frame.width, height: 20)
        label.center.x = view.center.x

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {

            label.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height ?? 25, width: self.view.frame.width, height: 20)
            label.center.x = self.view.center.x
        }, completion: nil)
        

        
        
    }
    

    
}

