//
//  ContactUsController.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 4/8/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import UIKit

class ContactUsController: UIViewController {

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

    
    //MARK:  Views
    
    let contactItem: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "contactGold").withRenderingMode(.alwaysTemplate)
        view.tintColor = .black //dark mode
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
    
     let Vstack: UIStackView = {
         let stack = UIStackView()
         stack.axis = .vertical
         stack.spacing = 15
         stack.alignment = .center
         //stack.addBackground(color: .darkGray, cornerRadius: 15)
        stack.distribution = .equalSpacing
        stack.sizeToFit()
     
         return stack
     }()
    
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Submit Supply Suggestions"
        lbl.font = UIFont(name: "HelveticaNeue", size: 25)
        lbl.textColor = .white //Dark mode
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        return lbl
        
    }()
    
    let submission: UITextField = {
        let txt = UITextField()

        txt.attributedPlaceholder = NSAttributedString(string: "\(UserDefaults.standard.string(forKey: "submissionsRemaining")!) remaining",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]) //Dark mode
        txt.borderStyle = .roundedRect
        txt.adjustsFontSizeToFitWidth = true
        txt.font = UIFont(name: "HelveticaNeue", size: 20)
        txt.isUserInteractionEnabled = true
        txt.alpha = 1
        txt.tag = 3
        return txt

        
    }()
    
    let submit: UIButton = {
        let btn = UIButton()
        btn.setTitle("Submit", for: .normal)
        btn.setTitleColor(Color.shared.blue, for: .normal)
        btn.backgroundColor = .white
        btn.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 25)
        btn.layer.borderColor = UIColor.white.cgColor //Dark mode
        btn.layer.borderWidth = 3
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(submitSuggestion), for: .touchUpInside)
        
        return btn
        
    }()
    
     let Vstack2: UIStackView = {
         let stack = UIStackView()
         stack.axis = .vertical
         stack.spacing = 15
         stack.alignment = .center
         //stack.addBackground(color: .darkGray, cornerRadius: 15)
        stack.distribution = .equalSpacing
        stack.sizeToFit()
     
         return stack
     }()
    
    let titleLbl2: UILabel = {
        let lbl = UILabel()
        lbl.text = "Contact Us"
        lbl.font = UIFont(name: "HelveticaNeue", size: 25)
        lbl.textColor = .white //Dark mode
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        return lbl
        
    }()
    
    let Hstack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 15
        stack.alignment = .center
        stack.addBackground(color: .white, cornerRadius: 15)

       stack.sizeToFit()
    
        return stack
    }()
    
    let emailLbl: CopyableLabel = {
        let lbl = CopyableLabel()
        lbl.text = "FindMySupplyApp@gmail.com"
        lbl.font = UIFont(name: "HelveticaNeue", size: 15)
        lbl.textColor = .black //Dark mode
        lbl.numberOfLines = 0
        //lbl.sizeToFit()
        //lbl.backgroundColor = .white
        //lbl.layer.cornerRadius = 5
        //lbl.clipsToBounds = true
        lbl.textAlignment = .center
        return lbl
        
    }()
    
    
    //MARK: Helper Functions
    
    @objc func submitSuggestion() {
        submission.resignFirstResponder()
        
        if let text = submission.text?.trim() {
            if text.count != 0 {
                let characterset = CharacterSet(charactersIn: #"abcdefghijklmnopqrstuvwxyz .ABCDEFGHIJKLMNOPQRSTUVWXYZ"#)

                if text.rangeOfCharacter(from: characterset.inverted) != nil {
                    showMessage(label: createLbl(text: "Submission cannot contain special characters."))
                    return
                }
  
                Submissions.shared.initialize(withSupply: text.replacingOccurrences(of: " ", with: "_"))
                DispatchQueue.global(qos: .userInitiated).async {
                    Submissions.shared.addSubmission { (result) in
                        switch result {
                        case .success( _):
                            DispatchQueue.main.async {
                                let success = self.createLbl(text: "Thank you for your submission.")
                                success.backgroundColor = .systemGreen
                                self.showMessage(label: success)
                                
                                let prev = UserDefaults.standard.integer(forKey: "submissionsRemaining")
                                UserDefaults.standard.set(prev-1, forKey: "submissionsRemaining")
                                self.submission.text = ""
                                self.configureSubmissionField()
                            }

                        case .failure(let error):
                            print("DEBUG: Failed with error \(error)")
                        }
                    }
                }
            
        }
        }
    }
    
    func configureSubmissionField() {
        if UserDefaults.standard.integer(forKey: "submissionsRemaining") == 0 {
            submission.isUserInteractionEnabled = false
        }
        
        submission.attributedPlaceholder = NSAttributedString(string: "\(UserDefaults.standard.string(forKey: "submissionsRemaining")!) remaining",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]) //Dark mode
        
        
    }
    
    func configureViewComponents() {
        view.backgroundColor = .black
        
        navigationItem.titleView = contactItem
        
        view.addSubview(scrollView)
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        scrollView.addSubview(Vstack)
        Vstack.anchor(top: scrollView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: view.frame.width-30, height: 100)
        Vstack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Vstack.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 10, right: 10)
        Vstack.isLayoutMarginsRelativeArrangement = true
        
        Vstack.addArrangedSubview(titleLbl)
        titleLbl.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        
        Vstack.addArrangedSubview(submission)
        submission.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 10000, height: 40)
        configureSubmissionField()
        
        scrollView.addSubview(submit)
        submit.anchor(top: Vstack.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width-30, height: 40)
        submit.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        scrollView.addSubview(Vstack2)
        Vstack2.anchor(top: submit.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: view.frame.width-30, height: 100)
        Vstack2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Vstack2.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 10, right: 10)
        Vstack2.isLayoutMarginsRelativeArrangement = true
        
        Vstack2.addArrangedSubview(titleLbl2)
        titleLbl2.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 130, height: 30)
        
        
        Vstack2.addArrangedSubview(Hstack)
        Hstack.anchor(top: nil, left: Vstack2.leftAnchor, bottom: nil, right: Vstack2.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 40)
        
        Hstack.addArrangedSubview(emailLbl)
        //titleLbl2.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 400, height: 30)
        
        
        configureColorScheme()
    }
    
    func configureColorScheme() {
        let scheme = UserDefaults.standard.integer(forKey: "colorScheme")
        
        if scheme == 0 {
            //STANDARD
            view.backgroundColor = .darkGray
               contactItem.tintColor = .black
            
             
             navigationController?.navigationBar.isTranslucent = true
             navigationController?.navigationBar.tintColor = .black
             navigationController?.navigationBar.barTintColor = .white
            StatusBarColor.shared.isDark = true
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })
            
            Vstack.addBackground(color: .gray, cornerRadius: 10)
            Vstack2.addBackground(color: .gray, cornerRadius: 10)

            
            
     
            
            
            
            
            
            
            
        }
        else if scheme == 1 {
            //DARK
               contactItem.tintColor = .white
            
             
             navigationController?.navigationBar.isTranslucent = false
             navigationController?.navigationBar.tintColor = .white
             navigationController?.navigationBar.barTintColor = .black
            StatusBarColor.shared.isDark = false
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })
            

        }
        else {
            //LIGHT
            view.backgroundColor = .white
               contactItem.tintColor = .black
            
             
             navigationController?.navigationBar.isTranslucent = false
             navigationController?.navigationBar.tintColor = .black
             navigationController?.navigationBar.barTintColor = .white
            StatusBarColor.shared.isDark = true
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })
            
            

            Vstack.addBackground(color: .lightGray, cornerRadius: 10)
            Vstack2.addBackground(color: .lightGray, cornerRadius: 10)

            
            
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
}
