//
//  ChangePasswordController.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 4/8/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import UIKit
import CryptoSwift

class ChangePasswordController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewComponents()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
          self.navigationController?.navigationBar.isHidden = false
          

          let mapBtn = UIButton(type: .system)
          mapBtn.setImage(#imageLiteral(resourceName: "map-1").withRenderingMode(.alwaysTemplate), for: .normal)
          
          if scheme == 0 {
              mapBtn.tintColor = .black
          } else if scheme == 1 {
              mapBtn.tintColor = .white
          } else {
              mapBtn.tintColor = .black
          }
          
          
          mapBtn.sizeToFit()
          mapBtn.contentMode = .scaleAspectFit
          mapBtn.addTarget(self, action: #selector(goBackHome), for: .touchUpInside)
          
          let rightBarButtonItem = UIBarButtonItem(customView: mapBtn)
          mapBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
          mapBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
          
    

          self.navigationItem.rightBarButtonItem = rightBarButtonItem
              
          
       }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        currentPswField.becomeFirstResponder()
    }
    

    //MARK: - Variables
    
    //MARK: - Views
    let pswItem: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "lock.slash.fill")
        view.contentMode = .scaleAspectFit
        view.sizeToFit()
        view.widthAnchor.constraint(equalToConstant: 30).isActive = true
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return view

    }()
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    let Vstack1: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 15
            stack.alignment = .center
        stack.sizeToFit()
        
            return stack
    }()
    
    let currentPswLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Enter current password:"
        lbl.font = UIFont(name: "HelveticaNeue", size: 25)
        lbl.textColor = .white //Dark mode
        lbl.numberOfLines = 1
        lbl.sizeToFit()
        return lbl
        
    }()
    
    let currentPswField: UITextField = {
        let txt = UITextField()
        txt.isSecureTextEntry = true
        txt.attributedPlaceholder = NSAttributedString(string: "Password",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]) //Dark mode
        txt.borderStyle = .roundedRect
        txt.adjustsFontSizeToFitWidth = true
        txt.font = UIFont(name: "HelveticaNeue", size: 20)
        txt.isUserInteractionEnabled = true
        txt.alpha = 1
        txt.tag = 1
        return txt
        
    }()
    
    let continueBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Continue", for: .normal)
        btn.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 25)
        btn.layer.borderColor = UIColor.white.cgColor //Dark mode
        btn.layer.borderWidth = 3
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(verifyPassword), for: .touchUpInside)
        
        return btn
        
    }()
    
    let Vstack2: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 15
            stack.alignment = .center
        stack.sizeToFit()
        
            return stack
    }()
    
    let newPswLbl1: UILabel = {
        let lbl = UILabel()
        lbl.text = "Enter new password:"
        lbl.font = UIFont(name: "HelveticaNeue", size: 25)
        lbl.textColor = .white //Dark mode
        lbl.numberOfLines = 1
        lbl.sizeToFit()
        return lbl
        
    }()
    
    let newPswField1: UITextField = {
        let txt = UITextField()
        txt.isSecureTextEntry = true
        txt.attributedPlaceholder = NSAttributedString(string: "Password",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]) //Dark mode
        txt.borderStyle = .roundedRect
        txt.adjustsFontSizeToFitWidth = true
        txt.font = UIFont(name: "HelveticaNeue", size: 20)
        txt.isUserInteractionEnabled = true
        txt.alpha = 1
        txt.tag = 1
        return txt
        
    }()
    
    let newPswLbl2: UILabel = {
        let lbl = UILabel()
        lbl.text = "Repeat new password:"
        lbl.font = UIFont(name: "HelveticaNeue", size: 25)
        lbl.textColor = .white //Dark mode
        lbl.numberOfLines = 1
        lbl.sizeToFit()
        return lbl
        
    }()
    
    let newPswField2: UITextField = {
        let txt = UITextField()
        txt.isSecureTextEntry = true
        txt.attributedPlaceholder = NSAttributedString(string: "Password",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]) //Dark mode
        txt.borderStyle = .roundedRect
        txt.adjustsFontSizeToFitWidth = true
        txt.font = UIFont(name: "HelveticaNeue", size: 20)
        txt.isUserInteractionEnabled = true
        txt.alpha = 1
        txt.tag = 1
        return txt
        
    }()
    
    let saveBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Save", for: .normal)
        btn.setTitleColor(Color.shared.blue, for: .normal)
        btn.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 25)
        btn.layer.borderColor = UIColor.white.cgColor //Dark mode
        btn.layer.borderWidth = 3
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(savePassword), for: .touchUpInside)
        
        return btn
        
    }()
    
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.startAnimating()
        spinner.isHidden = true
        spinner.color = Color.shared.gold
        return spinner
    }()
    
     let scheme = UserDefaults.standard.integer(forKey: "colorScheme")
    
    
    //MARK: - Helper Functions
    @objc func savePassword() {
        print("+++Save Psw")
        if let psw1 = newPswField1.text {
            if let psw2 = newPswField2.text {
                
                print("+++\(psw1) \(psw2)")
                if psw1 == psw2 {
                    if psw1.count < 5 {
                        newPswField1.resignFirstResponder()
                        newPswField2.resignFirstResponder()
                        showMessage(label: createLbl(text: "Password must be at least 5 characters."))
                        return
                    }
                    else if psw1.count > 100  {
                        newPswField1.resignFirstResponder()
                        newPswField2.resignFirstResponder()
                        showMessage(label: createLbl(text: "Password is too long."))
                        return
                    }
                } else {
                    newPswField1.resignFirstResponder()
                    newPswField2.resignFirstResponder()
                    showMessage(label: createLbl(text: "Passwords do not match, try again."))
                    return
                    }
                
                
                UpdateUser.shared.newPassword = psw1
                let salt = UserDefaults.standard.string(forKey: "salt")!
                UpdateUser.shared.salt = salt
                UpdateUser.shared.type = "change"
                
                DispatchQueue.main.async {
                    self.spinner.isHidden = false
                }
                
                DispatchQueue.global(qos: .userInitiated).async {
                    UpdateUser.shared.changePassword { (result) in
                        switch result {
                        case .success( _):
                            UserDefaults.standard.set((psw1+salt).sha256(), forKey: "password")
                            DispatchQueue.main.async {
                                let success = self.createLbl(text: "Succesfully changed password.")
                                success.backgroundColor = .systemGreen
                                self.newPswField1.resignFirstResponder()
                                self.newPswField2.resignFirstResponder()
                                self.showMessage(label: success)
                                self.spinner.isHidden = true
                                return
                            }

                            
                        case.failure(let error):
                            print("DEBUG: Failed with error \(error)")
                            DispatchQueue.main.async {
                                self.spinner.isHidden = true
                                self.showMessage(label: self.createLbl(text: "Oops! A network error occurred, please check your connection and try again."))
                            }
                        }
                    }
                }
                

                
                
                
                
                }
 
            }
        }
        
        
        
    
    
    
    func configurePart2() {
        pswItem.image = UIImage(systemName: "lock.open.fill")
        
        scrollView.addSubview(Vstack2)
        Vstack2.anchor(top: scrollView.topAnchor, left: nil, bottom: nil, right: nil , paddingTop: 25, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: view.frame.width-30, height: 260)
        Vstack2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        Vstack2.addArrangedSubview(newPswLbl1)
        newPswLbl1.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 240, height: 40)
        
        Vstack2.addArrangedSubview(newPswField1)
        newPswField1.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 260, height: 40)
        
        Vstack2.addArrangedSubview(newPswLbl2)
        newPswLbl2.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 260, height: 40)
        
        Vstack2.addArrangedSubview(newPswField2)
        newPswField2.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 260, height: 40)
        
        Vstack2.addArrangedSubview(saveBtn)
        saveBtn.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 260, height: 40)
        
        newPswField1.becomeFirstResponder()
        
        
        scrollView.addSubview(spinner)
        spinner.anchor(top: saveBtn.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    
    
    
    @objc func verifyPassword() {
        
        print("+++Verify Psw")
        currentPswField.resignFirstResponder()
        if let psw = currentPswField.text {
            let password = psw.trim()
            if password.count == 0 {
                return
            }
            if psw.count < 5 {
                showMessage(label: createLbl(text: "Password must be at least 5 characters."))
                return
            }
            else if psw.count > 100  {
                showMessage(label: createLbl(text: "Password is too long."))
                return

            }
            
            let hashed = (psw + UserDefaults.standard.string(forKey: "salt")!).sha256()
            if hashed == UserDefaults.standard.string(forKey: "password") {
                Vstack1.removeFromSuperview()
                configurePart2()
                return
            }
            else {
                showMessage(label: createLbl(text: "Password is incorrect."))
                return
            }
            
            
            
        }
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
    
    func showMessage(label: UILabel) {
        

        self.view.addSubview(label)
        label.alpha = 1
        
      //     self.noNearbyStoresLbl.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        label.frame = CGRect(x: 0 ,y: self.view.frame.height, width: (self.view.frame.width/4)*3, height: 50)
        label.center.x = view.center.x
     
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                label.frame = CGRect(x: 0, y: self.view.frame.height - 100, width: (self.view.frame.width/4)*3, height: 50)
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
    
    @objc func goBackHome() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func configureViewComponents() {
        view.backgroundColor = .black  //Dark mode
        
        navigationItem.titleView = pswItem
        
        view.addSubview(scrollView)
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        scrollView.addSubview(Vstack1)
        Vstack1.anchor(top: scrollView.topAnchor, left: nil, bottom: nil, right: nil , paddingTop: 25, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: view.frame.width-30, height: 150)
        Vstack1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        Vstack1.addArrangedSubview(currentPswLbl)
        currentPswLbl.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 270, height: 40)
        
        Vstack1.addArrangedSubview(currentPswField)
        currentPswField.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 270, height: 40)
        
        Vstack1.addArrangedSubview(continueBtn)
        continueBtn.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 270, height: 40)
        
        configureColorScheme()
    }
    
    func configureColorScheme() {
       
        
        if scheme == 0 {
            //STANDARD
            view.backgroundColor = .darkGray
            
            pswItem.tintColor = .black
            
            navigationController?.navigationBar.isTranslucent = true
            navigationController?.navigationBar.tintColor = .black
            navigationController?.navigationBar.barTintColor = .white
            StatusBarColor.shared.isDark = true
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })
            
            continueBtn.backgroundColor = .white
            continueBtn.setTitleColor(Color.shared.blue, for: .normal)

            saveBtn.backgroundColor = .white
            saveBtn.setTitleColor(Color.shared.blue, for: .normal)
            
            spinner.color = Color.shared.gold
            
            
            
            
            
            
            
            
        }
        else if scheme == 1 {
            //DARK
            view.backgroundColor = .black
            
            pswItem.tintColor = .white
            
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.barTintColor = .black
            StatusBarColor.shared.isDark = false
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })
            
            continueBtn.backgroundColor = .white
            continueBtn.setTitleColor(Color.shared.blue, for: .normal)
            
            saveBtn.backgroundColor = .white
            saveBtn.setTitleColor(Color.shared.blue, for: .normal)
            spinner.color = Color.shared.gold
            
            

        }
        else {
            //LIGHT
            view.backgroundColor = .lightGray
            
            pswItem.tintColor = .black
            
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = .black
            navigationController?.navigationBar.barTintColor = .white
            StatusBarColor.shared.isDark = true
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })
            
            continueBtn.backgroundColor = .white
            continueBtn.setTitleColor(Color.shared.blue, for: .normal)

            saveBtn.backgroundColor = .white
            saveBtn.setTitleColor(Color.shared.blue, for: .normal)
            spinner.color = .black

            
            
        }
    }

}
