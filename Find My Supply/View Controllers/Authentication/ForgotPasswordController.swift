
//  ViewController.swift
//  findMySupply2
//
//  Created by Ludovico Veniani on 3/27/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import UIKit
import SwiftUI
import CryptoSwift

class ForgotPasswordController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureViewComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        print("===\(UserDefaults.standard.bool(forKey: "forgotPassword"))")
        if !UserDefaults.standard.bool(forKey: "forgotPassword") {
            self.showSentEmail(message: "VVerification email sent. Tap to resend.")
            checkIfForgotPassword()
        }
    }
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "tpTransp")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    

    lazy var psw1ContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view.textContainerView(view: view, UIImage(systemName: "lock")!.withTintColor(.white, renderingMode: .alwaysOriginal), psw1TextField!)
    }()
    
    lazy var psw2ContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view.textContainerView(view: view, UIImage(systemName: "lock.fill")!.withTintColor(.white, renderingMode: .alwaysOriginal), psw2TextField!)
    }()
    
    lazy var psw1TextField: UITextField? = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf.textField(withPlaceolder: "New password", isSecureTextEntry: true, isTextEntry: true)
    }()
    
    lazy var psw2TextField: UITextField? = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf.textField(withPlaceolder: "New password, again", isSecureTextEntry: true, isTextEntry: true)
    }()
    

    
    let resetPswButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset password", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(Color.shared.blue, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(resetPassword), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Remembered your password?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: "Cancel", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: Color.shared.gold]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = Color.shared.gold
        spinner.startAnimating()
        spinner.alpha = 1
        spinner.isHidden = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    
    
    //MARK VARIABLES
    var forgotPassword = false
    var showMessage = true
    
    @objc func resetPassword(){
        psw1TextField?.resignFirstResponder()
        psw2TextField?.resignFirstResponder()
        
        
        if !forgotPassword {
            showMessage(label: createLbl(text: "Verify your email to reset password."))
            return
        }

            
            var psw1 = ""
            var psw2 = ""
            
        
        if psw1TextField?.text?.isEmpty ?? true || psw2TextField?.text?.isEmpty ?? true {

            showMessage(label: createLbl(text: "New password required."))
            return
     
            }
            else {
                if let p1 = psw1TextField?.text {
                    psw1 = p1
                    if p1.count < 5 {
                        showMessage(label: createLbl(text: "Password must be at least 5 characters."))
                        return
                    }
                    else if p1.count > 100  {
                        showMessage(label: createLbl(text: "Password is too long."))
                        return
                    }
                }
                if let p2 = psw2TextField?.text {
                    psw2 = p2
                    if psw1 != psw2 {
                        showMessage(label: createLbl(text: "Passwords do not match."))
                        return
                    }
                }
            }
    
            self.resetPswButton.isEnabled = false
        
        spinner.isHidden = false
        DispatchQueue.global(qos: .userInitiated).async {
            UserAuth.shared.fetchNewSalt { (result) in
                switch result {
                case .success(let s):
                    UpdateUser.shared.salt = s
                    UpdateUser.shared.newPassword = psw1
                    UpdateUser.shared.type = "forgot"
                    UpdateUser.shared.changePassword { (result) in
                            switch result {
                            case .success( _):
                                let userAuth = UserAuth.shared
                                userAuth.initLoginUser(withLogin: UserDefaults.standard.string(forKey: "login")!, withPassword: psw1)
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
                                                    print("Hashed password: \((psw1+user.salt).sha256())\n")

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
                                                            
                                                        }
                                                    
                                                }
                                                
                                         
                         
                                              UserDefaults.standard.set(false, forKey: "tappedForgotPassword")
                                              UserDefaults.standard.set(false, forKey: "forgotPassword")
                                              self.navigationController?.popToRootViewController(animated: true)
                                        
                                                  
                                              self.resetPswButton.isEnabled = true
                                                self.spinner.isHidden = true
                                                
                                              print("Updated Register Obj salt\n")
                                            }
                                        case .failure(let error):
                                            print("DEBUG: Failed with error \(error)")
                                            DispatchQueue.main.async {
                                             self.spinner.isHidden = true
                                                self.resetPswButton.isEnabled = true
                                            self.showMessage(label: self.createLbl(text: "Oops! A network error occurred, please check your connection and try again."))
                                        }

                                    }
                                }



                                
                            case.failure(let error):
                                print("DEBUG: Failed with error \(error)")
                                DispatchQueue.main.async {
                                     self.spinner.isHidden = true
                                    self.resetPswButton.isEnabled = true
                                     self.showMessage(label: self.createLbl(text: "Oops! A network error occurred, please check your connection and try again."))
                                }
                            }
                        }
                case .failure(let error):
                    print("DEBUG: Failed with error \(error)")
                    DispatchQueue.main.async {
                         self.spinner.isHidden = true
                        self.resetPswButton.isEnabled = true
                         self.showMessage(label: self.createLbl(text: "Oops! A network error occurred, please check your connection and try again."))
                    }
            }
        }
                
            }
        

        
            
                
    }
    
    
    
    

    
    @objc func sendResetPswEmail() {
        psw1TextField?.resignFirstResponder()
        psw2TextField?.resignFirstResponder()
            
        spinner.isHidden = false
       
        DispatchQueue.global(qos: .userInitiated).async {
            UserAuth.shared.login = UserDefaults.standard.string(forKey: "login")!
            UserAuth.shared.sendResetPasswordEmail { (result) in
                switch result {
                    case .success(var m):
                        DispatchQueue.main.async {
                             let firstChar = m.first
                             if firstChar == "#" {
                                 m.removeFirst()
                                 self.showMessage(label: self.createLbl(text: m))
                                self.spinner.isHidden = true
                                 return
                             }

                             self.showSentEmail(message: m)
                   
                        }
                        
                        DispatchQueue.main.async {
                             self.spinner.isHidden = true
                        }
                       
                        UserDefaults.standard.set(true, forKey: "tappedForgotPassword")
                        self.checkIfForgotPassword()

            
                    case .failure(let error):
                        print("DEBUG: Failed with error \(error)")
                        DispatchQueue.main.async {
                             self.spinner.isHidden = true
                             self.showMessage(label: self.createLbl(text: "Oops! A network error occurred, please check your connection and try again."))
                        }
                    
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

                              self.forgotPassword = true
                          }
                          if !self.forgotPassword {
                              self.checkIfForgotPassword()
                          }
                          
                      case .failure(let error):
                          print("DEBUG: Failed with error \(error)")
                          DispatchQueue.main.async {
                            self.showMessage(label: self.createLbl(text: "Oops! A network error occurred, please check your connection and try again."))
                          }
                      }
                  }
              }
          }
          
      }
    
    
    
    
    @objc func cancel() {
        UserDefaults.standard.set(false, forKey: "tappedForgotPassword")
        UserDefaults.standard.set(false, forKey: "forgotPassword")
        navigationController?.pushViewController(LoginController(), animated: true)
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
            
            scrollView.addSubview(psw1ContainerView)
            psw1ContainerView.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
            
            scrollView.addSubview(psw2ContainerView)
            psw2ContainerView.anchor(top: psw1ContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
            
        
            scrollView.addSubview(resetPswButton)
            resetPswButton.anchor(top: psw2ContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
            scrollView.addSubview(spinner)
            spinner.anchor(top: psw2ContainerView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    

            scrollView.addSubview(cancelButton)
        cancelButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 32, paddingBottom: 16, paddingRight: 32, width: 0, height: 50)
        
            let h = logoImageView.frame.height + 60 + 140
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
        
        let label = UIButton()

        var m = message
        m.removeFirst()
        
        
        label.backgroundColor = .systemGreen
        label.setTitleColor(.white, for: .normal)
        label.setTitle(m, for: .normal)
        label.titleLabel?.font = UIFont.italicSystemFont(ofSize: 15.0)

        label.addTarget(self, action:  #selector(sendResetPswEmail)     , for: .touchUpInside)
      
       
        //lbl.sizeToFit()
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

