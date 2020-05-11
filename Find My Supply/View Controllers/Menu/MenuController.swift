//
//  MenuController.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 4/8/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import UIKit

class MenuController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureMenuView()
        
        
        
        //view.frame.origin.x = -250
        


        // Do any additional setup after loading the view.
    }
    

    
    let menuView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let Hstack0: UIStackView = {
        let Hstack = UIStackView()
        Hstack.axis = .horizontal
        //Hstack.alignment = .leading
        Hstack.spacing = 15
        Hstack.isUserInteractionEnabled = true
        return Hstack
    }()
    
    let Hstack1: UIStackView = {
        let Hstack = UIStackView()
        Hstack.axis = .horizontal
        //Hstack.alignment = .leading
        Hstack.spacing = 15
        return Hstack
    }()
    
    let Hstack2: UIStackView = {
        let Hstack = UIStackView()
        Hstack.axis = .horizontal
        //Hstack.alignment = .leading
        Hstack.spacing = 15
        return Hstack
    }()
    
    let Hstack3: UIStackView = {
        let Hstack = UIStackView()
        Hstack.axis = .horizontal
        //Hstack.alignment = .leading
        Hstack.spacing = 15
        return Hstack
    }()
    
    let Hstack4: UIStackView = {
        let Hstack = UIStackView()
        Hstack.axis = .horizontal
        //Hstack.alignment = .leading
        Hstack.spacing = 15
        return Hstack
    }()
    
    let profileImg: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.image = #imageLiteral(resourceName: "goldProf").withRenderingMode(.alwaysOriginal)
        return view
    }()
    
    let profileLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Profile"
        lbl.font = Fonts.shared.menu//UIFont(name: "Helvetica-Bold", size: 28)
        lbl.textColor = Color.shared.gold  //Dark mode
        lbl.textAlignment = .left
        return lbl
    }()
    
    let notifIcon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.image =  #imageLiteral(resourceName: "goldBell").withRenderingMode(.alwaysOriginal)
        view.image?.withTintColor(.white)
        return view
    }()
    
    let notifLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Notifications"
        lbl.font = Fonts.shared.menu//UIFont(name: "Helvetica-Bold", size: 28)
        lbl.textColor = Color.shared.gold  //Dark mode
        lbl.textAlignment = .left
        return lbl
    }()
    
    
    let settingsIcon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.image =  #imageLiteral(resourceName: "goldGear").withRenderingMode(.alwaysOriginal)
        return view
    }()
    
    let settingsLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Settings"
        lbl.font = Fonts.shared.menu//UIFont(name: "Helvetica-Bold", size: 28)
        lbl.textColor = Color.shared.gold  //Dark mode
        lbl.textAlignment = .left
        return lbl
    }()
    
    let goldIcon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.image = #imageLiteral(resourceName: "contactGold").withRenderingMode(.alwaysOriginal)
        return view
    }()
    
    let goldLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Gold"
        lbl.font = Fonts.shared.menu//UIFont(name: "Helvetica-Bold", size: 28)
        lbl.textColor = Color.shared.gold  //Dark mode
        lbl.textAlignment = .left
        return lbl
    }()
    
    let contactIcon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.image = #imageLiteral(resourceName: "contactGold").withRenderingMode(.alwaysOriginal)
        return view
    }()
    
    let contactLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Contact Us"
        lbl.font = Fonts.shared.menu//UIFont(name: "Helvetica-Bold", size: 28)
        lbl.textColor = Color.shared.gold  //Dark mode
        lbl.textAlignment = .left
        return lbl
    }()
    
    var delegate: HomeControllerDelegate?
    
    @objc func openProfileController() {
        //print("+++++OPEN PROFILE")
        //navigationController?.pushViewController(ProfileController(), animated: true)
        delegate?.handleMenuToggle(forMenuOption: 0)

        
    }
    
    @objc func openNotificationsController() {
        //print("+++++OPEN PROFILE")
        //navigationController?.pushViewController(ProfileController(), animated: true)
        delegate?.handleMenuToggle(forMenuOption: 1)

        
    }
    
    @objc func openSettingsController() {
        //print("+++++OPEN PROFILE")
        //navigationController?.pushViewController(ProfileController(), animated: true)
        delegate?.handleMenuToggle(forMenuOption: 2)

        
    }
    
    @objc func openGoldController() {
        //print("+++++OPEN PROFILE")
        //navigationController?.pushViewController(ProfileController(), animated: true)
        delegate?.handleMenuToggle(forMenuOption: 3)

        
    }
    
    @objc func openContactUsController() {
        //print("+++++OPEN PROFILE")
        //navigationController?.pushViewController(ProfileController(), animated: true)
        delegate?.handleMenuToggle(forMenuOption: 4)

        
    }
    
    
    
    func configureMenuView() {
        
        menuView.isUserInteractionEnabled = true
        Hstack0.isUserInteractionEnabled = true
        view.addSubview(menuView)

      

        menuView.frame = CGRect(x: 0,y: 0, width: 250, height: view.frame.height)
        //menuView.rightAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        //menuView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 250, height: view.frame.height)

        
        menuView.addSubview(Hstack0)
        Hstack0.anchor(top: nil, left: menuView.leftAnchor, bottom: nil, right: menuView.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: menuView.frame.width, height: 30)
        Hstack0.topAnchor.constraint(equalTo: menuView.topAnchor, constant: 100).isActive = true
        var tap = UITapGestureRecognizer(target: self, action: #selector(openProfileController))
        Hstack0.addGestureRecognizer(tap)

        Hstack0.addArrangedSubview(profileImg)
        profileImg.anchor(top: Hstack0.topAnchor, left: Hstack0.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        Hstack0.addArrangedSubview(profileLbl)
        profileLbl.anchor(top: Hstack0.topAnchor, left: profileImg.rightAnchor, bottom: nil, right: Hstack0.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 0)

        menuView.addSubview(Hstack1)
        Hstack1.anchor(top: nil, left: menuView.leftAnchor, bottom: nil, right: menuView.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 15)
        Hstack1.topAnchor.constraint(equalTo: Hstack0.bottomAnchor, constant: 30).isActive = true
        tap = UITapGestureRecognizer(target: self, action: #selector(openNotificationsController))
        Hstack1.addGestureRecognizer(tap)

        Hstack1.addArrangedSubview(notifIcon)
        notifIcon.anchor(top: Hstack1.topAnchor, left: Hstack1.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        Hstack1.addArrangedSubview(notifLbl)
        notifLbl.anchor(top: Hstack1.topAnchor, left: notifIcon.rightAnchor, bottom: nil, right: Hstack1.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 0)

        menuView.addSubview(Hstack2)
        Hstack2.anchor(top: nil, left: menuView.leftAnchor, bottom: nil, right: menuView.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 15)
        Hstack2.topAnchor.constraint(equalTo: Hstack1.bottomAnchor, constant: 30).isActive = true
        tap = UITapGestureRecognizer(target: self, action: #selector(openSettingsController))
        Hstack2.addGestureRecognizer(tap)


        Hstack2.addArrangedSubview(settingsIcon)
        settingsIcon.anchor(top: Hstack2.topAnchor, left: Hstack2.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        Hstack2.addArrangedSubview(settingsLbl)
        settingsLbl.anchor(top: Hstack2.topAnchor, left: settingsIcon.rightAnchor, bottom: nil, right: Hstack2.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 0)
        
        menuView.addSubview(Hstack3)
        Hstack3.anchor(top: nil, left: menuView.leftAnchor, bottom: nil, right: menuView.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 15)
        Hstack3.topAnchor.constraint(equalTo: Hstack2.bottomAnchor, constant: 30).isActive = true
        tap = UITapGestureRecognizer(target: self, action: #selector(openGoldController))
        Hstack3.addGestureRecognizer(tap)


        Hstack3.addArrangedSubview(goldIcon)
        goldIcon.anchor(top: Hstack3.topAnchor, left: Hstack3.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        Hstack3.addArrangedSubview(goldLbl)
        goldLbl.anchor(top: Hstack3.topAnchor, left: goldIcon.rightAnchor, bottom: nil, right: Hstack3.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 0)
        
        
        
        
        menuView.addSubview(Hstack4)
        Hstack4.anchor(top: nil, left: menuView.leftAnchor, bottom: nil, right: menuView.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 15)
        Hstack4.topAnchor.constraint(equalTo: Hstack3.bottomAnchor, constant: 30).isActive = true
        tap = UITapGestureRecognizer(target: self, action: #selector(openContactUsController))
        Hstack4.addGestureRecognizer(tap)


        Hstack4.addArrangedSubview(contactIcon)
        contactIcon.anchor(top: Hstack4.topAnchor, left: Hstack4.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        Hstack4.addArrangedSubview(contactLbl)
        contactLbl.anchor(top: Hstack4.topAnchor, left: contactIcon.rightAnchor, bottom: nil, right: Hstack4.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 0)
        
        configureColorScheme()

        
    }
    
    func configureColorScheme() {
        let scheme = UserDefaults.standard.integer(forKey: "colorScheme")
        
        if scheme == 0 {
            //STANDARD
            view.backgroundColor = .black
            menuView.backgroundColor = .black
            
            for lbl in [profileLbl, notifLbl, settingsLbl, goldLbl, contactLbl] {
                lbl.textColor = Color.shared.gold
            }
            
            for img in [profileImg, notifIcon, settingsIcon, goldIcon, contactIcon] {
                if img == profileImg {
                    img.image = UIImage(systemName: "person.fill")?.withTintColor(.white, renderingMode: .alwaysTemplate)
                    img.tintColor = Color.shared.gold
                }
                else if img == notifIcon {
                    img.image = UIImage(systemName: "bell.fill")?.withTintColor(.white, renderingMode: .alwaysTemplate)
                    img.tintColor = Color.shared.gold
                }
                else if img == settingsIcon {
                    img.image = UIImage(systemName: "gear")?.withTintColor(.white, renderingMode: .alwaysTemplate)
                    img.tintColor = Color.shared.gold
                }
                else if img == goldIcon {
                    img.image = #imageLiteral(resourceName: "medallionTP").withRenderingMode(.alwaysTemplate)
                    img.tintColor = Color.shared.gold
                }
                else {
                    img.image = UIImage(systemName: "plus.bubble.fill")?.withTintColor(.white, renderingMode: .alwaysTemplate)
                    img.tintColor = Color.shared.gold
                }
                
            }
            
            
            
            
            
            
            
            
        }
        else if scheme == 1 {
            //DARK
            
            view.backgroundColor = .black
            menuView.backgroundColor = .black
            
            for lbl in [profileLbl, notifLbl, settingsLbl,goldLbl, contactLbl] {
                lbl.textColor = Color.shared.gold//.white
            }
            
            for img in [profileImg, notifIcon, settingsIcon, goldIcon, contactIcon] {
                if img == profileImg {
                    img.image = UIImage(systemName: "person.fill")?.withTintColor(.white, renderingMode: .alwaysTemplate)
                    img.tintColor = Color.shared.gold//.white
                }
                else if img == notifIcon {
                    img.image = UIImage(systemName: "bell.fill")?.withTintColor(.white, renderingMode: .alwaysTemplate)
                    img.tintColor = Color.shared.gold//.white
                }
                else if img == settingsIcon {
                    img.image = UIImage(systemName: "gear")?.withTintColor(.white, renderingMode: .alwaysTemplate)
                    img.tintColor = Color.shared.gold//.white
                }
                else if img == goldIcon {
                    img.image = #imageLiteral(resourceName: "medallionTP").withRenderingMode(.alwaysTemplate)
                    img.tintColor = Color.shared.gold//.white
                }
                else {
                    img.image = UIImage(systemName: "plus.bubble.fill")?.withTintColor(.white, renderingMode: .alwaysTemplate)
                    img.tintColor = Color.shared.gold//.white
                }
                
            }

        }
        else {
            //LIGHT
            view.backgroundColor = .white
            menuView.backgroundColor = .white
            
            for lbl in [profileLbl, notifLbl, settingsLbl, goldLbl, contactLbl] {
                lbl.textColor = .black
            }
            
            for img in [profileImg, notifIcon, settingsIcon, goldIcon, contactIcon] {
                if img == profileImg {
                    img.image = UIImage(systemName: "person.fill")?.withTintColor(.white, renderingMode: .alwaysTemplate)
                    img.tintColor = .black
                }
                else if img == notifIcon {
                    img.image = UIImage(systemName: "bell.fill")?.withTintColor(.white, renderingMode: .alwaysTemplate)
                    img.tintColor = .black
                }
                else if img == settingsIcon {
                    img.image = UIImage(systemName: "gear")?.withTintColor(.white, renderingMode: .alwaysTemplate)
                    img.tintColor = .black
                }
                else if img == goldIcon {
                    img.image = #imageLiteral(resourceName: "medallionTP").withRenderingMode(.alwaysTemplate)
                    img.tintColor = .black
                }
                else {
                    img.image = UIImage(systemName: "plus.bubble.fill")?.withTintColor(.white, renderingMode: .alwaysTemplate)
                    img.tintColor = .black
                }
                
            }

            
            
        }
    }
    


  

}
