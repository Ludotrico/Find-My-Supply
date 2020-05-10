//
//  ProfileController.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 4/7/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
       
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
          
    override func viewWillAppear(_ animated: Bool) {
       
      self.navigationController?.navigationBar.isHidden = false
    }
    

    
    //MARK: - Views
    let profItem: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person.fill")
        view.contentMode = .scaleAspectFit
        view.sizeToFit()
        view.widthAnchor.constraint(equalToConstant: 30).isActive = true
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view

    }()
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let profImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person.circle")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .white  //Dark mode
        view.contentMode = .scaleAspectFit
        view.sizeToFit()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view

    }()
    
    
    
    let Hstack1: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 15
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        //stack.addBackground(color: .darkGray, cornerRadius: 10)
    
        return stack
    }()
    
    let fNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "First Name:"
        lbl.font = Fonts.shared.largeBold//UIFont(name: "HelveticaNeue", size: 25)
        lbl.textColor = .white //Dark mode
        lbl.numberOfLines = 1
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
        
    }()
    
    let fNameField: UITextField = {
        let txt = UITextField()

        txt.attributedPlaceholder = NSAttributedString(string: UserDefaults.standard.string(forKey: "fName")!,
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]) //Dark mode
        txt.borderStyle = .roundedRect
        txt.adjustsFontSizeToFitWidth = true
        txt.font = Fonts.shared.largeLight//UIFont(name: "HelveticaNeue", size: 20)
        txt.isUserInteractionEnabled = false
        txt.autocorrectionType = .no
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.alpha = 1
        txt.tag = 1
        return txt
        
    }()
    
//    lazy var fNameContainer: UIView = {
//        let view = UIView()
//        return view.textContainerView(view: view, UIImage(systemName: "person")!.withTintColor(.white, renderingMode: .alwaysTemplate), fNameField)
//
//    }()
    
    let pencil1: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "pencil")?.withRenderingMode(.alwaysTemplate), for: .normal)
        view.addTarget(self, action: #selector(editFname), for: .touchUpInside)
        view.tintColor = .white //Dark mode
        view.contentMode = .scaleAspectFit
        view.sizeToFit()
        view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let Hstack2: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 15
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        //stack.addBackground(color: .darkGray, cornerRadius: 10)
    
        return stack
    }()
    
    let usernameLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Username:"
        lbl.font = Fonts.shared.largeBold//UIFont(name: "HelveticaNeue", size: 25)
        lbl.textColor = .white //Dark mode
        lbl.numberOfLines = 1
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
        
    }()
    
    let usernameField: UITextField = {
        let txt = UITextField()

        txt.attributedPlaceholder = NSAttributedString(string: UserDefaults.standard.string(forKey: "username")!,
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]) //Dark mode
        txt.borderStyle = .roundedRect
        txt.adjustsFontSizeToFitWidth = true
        txt.font = Fonts.shared.largeLight//UIFont(name: "HelveticaNeue", size: 20)
        txt.isUserInteractionEnabled = false
        txt.autocapitalizationType = .none
        txt.autocorrectionType = .no
        txt.alpha = 1
        txt.tag = 3
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt

        
    }()
    
    let pencil2: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "pencil")?.withRenderingMode(.alwaysTemplate), for: .normal)
        view.addTarget(self, action: #selector(editUsername), for: .touchUpInside)
        view.tintColor = .white //Dark mode
        view.contentMode = .scaleAspectFit
        view.sizeToFit()
        view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let Hstack3: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.spacing = 15
            stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        //stack.addBackground(color: .darkGray, cornerRadius: 10)
        
            return stack
    }()
    
    let emailLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Email:"
        lbl.font = Fonts.shared.largeBold//UIFont(name: "HelveticaNeue", size: 25)
        lbl.textColor = .white //Dark mode
        lbl.numberOfLines = 1
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
        
    }()
    
    let emailField: UITextField = {
        let txt = UITextField()

        txt.attributedPlaceholder = NSAttributedString(string: UserDefaults.standard.string(forKey: "email")!,
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]) //Dark mode
        txt.borderStyle = .roundedRect
        txt.adjustsFontSizeToFitWidth = true
        txt.font = Fonts.shared.largeLight//UIFont(name: "HelveticaNeue", size: 20)
        txt.isUserInteractionEnabled = false
        txt.autocapitalizationType = .none
        txt.autocorrectionType = .no
        txt.alpha = 1
        txt.tag = 2
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
        
    }()
    
    let pencil3: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "pencil")?.withRenderingMode(.alwaysTemplate), for: .normal)
        view.addTarget(self, action: #selector(editEmail), for: .touchUpInside)
        view.tintColor = .white //Dark mode
        view.contentMode = .scaleAspectFit
        view.sizeToFit()
        view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let changePswBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Change password", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .darkGray
        btn.titleLabel?.font = Fonts.shared.largeBold//UIFont(name: "HelveticaNeue", size: 25)
        btn.layer.borderColor = UIColor.white.cgColor //Dark mode
        btn.layer.borderWidth = 3
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(goToChangePassword), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
        
    }()
    
    let save: UIButton = {
        let btn = UIButton()
        btn.setTitle("Save", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = Color.shared.blue
        btn.titleLabel?.font = Fonts.shared.largeBold//UIFont(name: "HelveticaNeue", size: 25)
        btn.layer.borderColor = UIColor.white.cgColor //Dark mode
        btn.layer.borderWidth = 3
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(saveChanges), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
        
    }()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.startAnimating()
        spinner.isHidden = true
        spinner.color = Color.shared.gold
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    
    
    

    //MARK: - Variables
    var hasEdited = [Int]()
    
    //MARK: - Selectors
    
    @objc func saveChanges() {
        print("+++SAVE")
        
        

        var fName = "_"
        var email = "_"
        var usrname = "_"

        
        var nonEmptyFields = [UITextField]()
        if hasEdited.count == 0 {
            return
        }
        
        for elem in [pencil1, pencil2, pencil3] {
            elem.isHidden = false
        }
        
        for field in [fNameField, emailField, usernameField] {
            if let text = field.text {
               if !text.trimmingCharacters(in: .whitespaces).isEmpty {
                nonEmptyFields.append(field)
                }
            }
            field.resignFirstResponder()
            
        }
        
        if nonEmptyFields.count == 0 {
            return
        }
        for field in nonEmptyFields {
            if field.tag == 1 {
                if let name = fNameField.text?.trimmingCharacters(in: .whitespaces) {
                    if !name.isEmpty {
                        let characterset = CharacterSet(charactersIn: #"abcdefghijklmnopqrstuvwxyz’ABCDEFGHIJKLMNOPQRSTUVWXYZ"#)
                        if name.count > 60 {
                            showMessage(label: createLbl(text: "First name is too long."))
                            return
                        }
                        else if name.rangeOfCharacter(from: characterset.inverted) != nil {
                            showMessage(label: createLbl(text: "First name cannot contain special characters."))
                            return
                        }
                        fName = name
                    }
                    
                }
                
            }
            else if field.tag == 2 {
                if let e = emailField.text?.trimmingCharacters(in: .whitespaces) {
                    if !e.isEmpty {
                        if !e.contains("@") || !e.contains(".") || e.contains(" ") {
                            showMessage(label: createLbl(text: "Email address is invalid."))
                            return
                        }
                        else if e.count > 100 {
                            showMessage(label: createLbl(text: "Email is too long."))
                            return
                        }
                        email = e
                    }
                }
                
            }
            else if field.tag == 3 {
                  if let username = usernameField.text?.trimmingCharacters(in: .whitespaces) {
                     if !username.isEmpty {
                         if username.count > 60 {
                             showMessage(label: createLbl(text: "Username is too long."))
                             return
                         }
                         else if username.contains(" ") {
                             showMessage(label: createLbl(text: "Username cannot contain spaces."))
                             return
                         }
                        usrname = username
                     }
                 }
            }
        }
        
        print("+++ENTerinG update with: \(fName) \(email) \(usrname)")

            
        DispatchQueue.main.async {
            self.spinner.isHidden = false
        }
        UpdateUser.shared.initialize(withFname: fName, withEmail: email, withUsername: usrname)
        
        DispatchQueue.global(qos: .userInitiated).async {
            UpdateUser.shared.update { (result) in
                switch result {
                case .success(var m):
                    DispatchQueue.main.async {
                        if m.removeFirst() == "#" {
                            self.showMessage(label: self.createLbl(text: m))
                            self.spinner.isHidden = true
                            return
                        }
                        let success = self.createLbl(text: "Changes saved.")
                        success.backgroundColor = .systemGreen
                        self.showMessage(label: success)
                        
                        for field in nonEmptyFields {
                            if let text = field.text {
                               if !text.trimmingCharacters(in: .whitespaces).isEmpty {
                                field.placeholder = text.trim()
                                }
                            }
                        }
                        for elem in [self.fNameField, self.emailField, self.usernameField] {
                            elem.text = ""
                        }
                        self.spinner.isHidden = true
                    }

                    self.updateUserDefaults(fName: fName, email: email, username: usrname)
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
    
    func updateUserDefaults(fName: String, email: String, username: String) {
        if fName != "_" {
            UserDefaults.standard.set(fName, forKey: "fName")
        }
        if email != "_" {
            UserDefaults.standard.set(email, forKey: "email")
        }
        if username != "_" {
            UserDefaults.standard.set(username, forKey: "username")
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
        lbl.adjustsFontSizeToFitWidth  = true
        lbl.layer.cornerRadius = 10
        return lbl
    }
    
    @objc func editFname() {
        print("+++EDIT FNAME")
        fNameField.isUserInteractionEnabled = true
        usernameField.isUserInteractionEnabled = false
        emailField.isUserInteractionEnabled = false
        
        pencil2.isHidden = false
        pencil3.isHidden = false
  

        fNameField.becomeFirstResponder()
        
        pencil1.isHidden = true
        if !hasEdited.contains(1) {
            hasEdited.append(1)
        }

        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.fNameField.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: { _ in
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.fNameField.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        })
        
        
            
    
    }
    
    @objc func editUsername() {
        print("+++EDIT usrname")
        fNameField.isUserInteractionEnabled = false
        usernameField.isUserInteractionEnabled = true
        emailField.isUserInteractionEnabled = false
        
        pencil1.isHidden = false
        pencil3.isHidden = false
        
        usernameField.becomeFirstResponder()
        
        pencil2.isHidden = true
        if !hasEdited.contains(2) {
            hasEdited.append(2)
        }

        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.usernameField.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: { _ in
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.usernameField.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        })
        
        
    }
    
    @objc func editEmail() {
        print("+++EDIT email")
        fNameField.isUserInteractionEnabled = false
        usernameField.isUserInteractionEnabled = false
        emailField.isUserInteractionEnabled = true
        
        pencil1.isHidden = false
        pencil2.isHidden = false
        
        emailField.becomeFirstResponder()
        
        pencil3.isHidden = true
        if !hasEdited.contains(3) {
            hasEdited.append(3)
        }

        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.emailField.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: { _ in
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.emailField.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        })
    }
    
    @objc func goToChangePassword() {
        navigationController?.pushViewController(ChangePasswordController(), animated: true)
    }
    
    
    //MARK: - Helper Functions

    func configureViewComponents() {
        view.backgroundColor = .black //Dark mode

        navigationItem.titleView = profItem
        
        
        view.addSubview(scrollView)
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 15)
        
        scrollView.addSubview(profImage)
        profImage.anchor(top: scrollView.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 1500, height: 150)
        
        scrollView.addSubview(Hstack1)
        Hstack1.anchor(top: profImage.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: view.frame.width-30, height: 40)
        Hstack1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Hstack1.addArrangedSubview(fNameLbl)
        fNameLbl.widthAnchor.constraint(equalToConstant: 130).isActive = true
        Hstack1.addArrangedSubview(fNameField)
        Hstack1.addArrangedSubview(pencil1)
        Hstack1.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        Hstack1.isLayoutMarginsRelativeArrangement = true
        //pencil1.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 10)
        //pencil1.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        
        scrollView.addSubview(Hstack2)
        Hstack2.anchor(top: Hstack1.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: view.frame.width-30, height: 40)
        Hstack2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Hstack2.addArrangedSubview(emailLbl)
        emailLbl.widthAnchor.constraint(equalToConstant: 130).isActive = true
        Hstack2.addArrangedSubview(emailField)
        Hstack2.addArrangedSubview(pencil3)
        Hstack2.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        Hstack2.isLayoutMarginsRelativeArrangement = true
        

        
        scrollView.addSubview(Hstack3)
        Hstack3.anchor(top: Hstack2.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: view.frame.width-30, height: 40)
        Hstack3.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Hstack3.addArrangedSubview(usernameLbl)
        usernameLbl.widthAnchor.constraint(equalToConstant: 130).isActive = true
        Hstack3.addArrangedSubview(usernameField)
        Hstack3.addArrangedSubview(pencil2)
        Hstack3.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        Hstack3.isLayoutMarginsRelativeArrangement = true

        
        scrollView.addSubview(changePswBtn)
        changePswBtn.anchor(top: Hstack3.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 280, height: 45)
        changePswBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

       
         scrollView.addSubview(save)
        save.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 25, paddingRight: 0, width: view.frame.width-30, height: 40)
        save.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        save.topAnchor.constraint(equalTo: changePswBtn.bottomAnchor, constant: 60).isActive = true

        
        scrollView.addSubview(spinner)
        spinner.anchor(top: nil, left: nil, bottom: save.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: 850)
        print("===\(view.frame.height)")
        
        configureColorScheme()
        


    }
    
    func configureColorScheme() {
        let scheme = UserDefaults.standard.integer(forKey: "colorScheme")
        
        if scheme == 0 {
            //STANDARD
            view.backgroundColor = .darkGray
            
            navigationController?.navigationBar.isTranslucent = true
            navigationController?.navigationBar.tintColor = .black
            navigationController?.navigationBar.barTintColor = .white
            StatusBarColor.shared.isDark = true
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })
            
            profItem.tintColor = .black
            profImage.tintColor = .white
            
            
            for stack in [Hstack1, Hstack2, Hstack3] {
                stack.addBackground(color: .black, cornerRadius: 10)
            }
            
            for pencil in [pencil1, pencil2, pencil3] {
                pencil.tintColor = .white
            }
            
            
            save.backgroundColor = .white
            save.setTitleColor(Color.shared.blue, for: .normal)
            
            changePswBtn.backgroundColor = .black
            changePswBtn.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            
            spinner.color = Color.shared.gold
            

            
            
            
            
            
            
            
            
        }
        else if scheme == 1 {
            //DARK
            view.backgroundColor = .black
            
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.barTintColor = .black
            StatusBarColor.shared.isDark = false
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })
            
            
            profItem.tintColor = .white
            profImage.tintColor = .white
            
            for stack in [Hstack1, Hstack2, Hstack3] {
                stack.addBackground(color: .darkGray, cornerRadius: 10)
            }
            
            for pencil in [pencil1, pencil2, pencil3] {
                pencil.tintColor = .white
            }
            
            save.backgroundColor = .white
            save.setTitleColor(Color.shared.blue, for: .normal)
            
            changePswBtn.backgroundColor = .darkGray
            changePswBtn.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            
            spinner.color = Color.shared.gold

        }
        else {
            //LIGHT
            view.backgroundColor = .white
            
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = .black
            navigationController?.navigationBar.barTintColor = .white
            StatusBarColor.shared.isDark = true
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })
            
            profItem.tintColor = .black
            profImage.tintColor = .gray
            
            
            for stack in [Hstack1, Hstack2, Hstack3] {
                stack.addBackground(color: .gray, cornerRadius: 10)
            }
            
            for pencil in [pencil1, pencil2, pencil3] {
                pencil.tintColor = .white
            }
            
            
            save.backgroundColor = .white
            save.setTitleColor(Color.shared.blue, for: .normal)

            
            changePswBtn.backgroundColor = .gray
            changePswBtn.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            
            spinner.color = .black
  

            
            
        }
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




}
