//
//  ColorScheme.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 4/10/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import UIKit

class ColorSchemeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
          self.navigationController?.navigationBar.isHidden = false
         
        mapIcon.addTarget(self, action: #selector(goBackHome), for: .touchUpInside)
        
          let rightBarButtonItem = UIBarButtonItem(customView: mapIcon)

 
          self.navigationItem.rightBarButtonItem = rightBarButtonItem
              
          
       }
    
       override func viewWillDisappear(_ animated: Bool) {
           self.navigationController?.navigationBar.isHidden = true
       }

    
    //MARK:  Views
    
    let mapIcon: UIButton = {
        let mapBtn = UIButton(type: .system)
        mapBtn.setImage(#imageLiteral(resourceName: "map-1").withRenderingMode(.alwaysTemplate), for: .normal)
        
        let scheme = UserDefaults.standard.integer(forKey: "colorTheme")
        if scheme == 0 {
            mapBtn.tintColor = .black
        } else if scheme == 1 {
            mapBtn.tintColor = .white
        } else {
            mapBtn.tintColor = .black
        }
        
        
        mapBtn.sizeToFit()
        mapBtn.contentMode = .scaleAspectFit
        
        
        mapBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        mapBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        mapBtn.translatesAutoresizingMaskIntoConstraints = false
        return mapBtn
    }()
    
    
    
    let schemeItem: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "colrSettings").withRenderingMode(.alwaysTemplate)
        view.tintColor = .black //dark mode
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
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
     let Vstack: UIStackView = {
         let stack = UIStackView()
         stack.axis = .vertical
         stack.spacing = 15
         stack.alignment = .center
         stack.addBackground(color: .darkGray, cornerRadius: 15)
        stack.distribution = .equalSpacing
        stack.sizeToFit()
        stack.translatesAutoresizingMaskIntoConstraints = false
     
         return stack
     }()
    
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Color Scheme"
        lbl.font = Fonts.shared.largeBold//UIFont(name: "HelveticaNeue", size: 25)
        lbl.textColor = .white //Dark mode
        lbl.numberOfLines = 1
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
        
    }()
    
    
    lazy var schemeSegment: UISegmentedControl = {
        let control = UISegmentedControl(items: schemes)
        control.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "colorScheme")
        control.layer.cornerRadius = 10
        control.layer.borderWidth = 1
        control.layer.masksToBounds = true
        control.layer.borderColor  = UIColor.white.cgColor //Dark mode
        control.addTarget(self, action: #selector(handleSchemeToggle(_:)), for: .valueChanged)
        control.tintColor = .white
        control.selectedSegmentTintColor = .white
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    
    //MARK: Variables
    let schemes = ["Standard", "Dark", "Light"]
    var menuController: MenuController!
    var homeController: HomeController!
    var settingsController: SettingsController!
    let scheme = UserDefaults.standard.integer(forKey: "colorScheme")
    
    
    //MARK: Helper Functions
    @objc func handleSchemeToggle(_ control: UISegmentedControl) {
        print("+++ mapType toggled")
        
        switch control.selectedSegmentIndex {
        case 0:
            UserDefaults.standard.set(0, forKey: "colorScheme")
            configureColorScheme()
        case 1:
            UserDefaults.standard.set(1, forKey: "colorScheme")
            configureColorScheme()
        case 2:
            UserDefaults.standard.set(2, forKey: "colorScheme")
            configureColorScheme()
        default:
            UserDefaults.standard.set(0, forKey: "colorScheme")
            configureColorScheme()
            
        }
        
        
    }
    
    
    
    func configureViewComponents() {

        view.backgroundColor = .black
        
        navigationItem.titleView = schemeItem
        
        
        view.addSubview(scrollView)
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        scrollView.addSubview(Vstack)
        Vstack.anchor(top: scrollView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: view.frame.width-30, height: 100)
        Vstack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Vstack.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 10, right: 10)
        Vstack.isLayoutMarginsRelativeArrangement = true
        
        Vstack.addArrangedSubview(titleLbl)
        titleLbl.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        
        Vstack.addArrangedSubview(schemeSegment)
        schemeSegment.anchor(top: nil, left: nil, bottom: nil, right:nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 10000, height: 10000)
        
        configureColorScheme()
    }
    
     func configureColorScheme() {
        print("+++Configuring schme \(scheme)")
        settingsController.configureColorScheme()
        menuController.configureColorScheme()
        
        let scheme = UserDefaults.standard.integer(forKey: "colorScheme")
         if scheme == 0 {
             //STANDARD
             view.backgroundColor = .darkGray
               schemeItem.tintColor = .black
            mapIcon.tintColor = .black

             navigationController?.navigationBar.isTranslucent = true
             navigationController?.navigationBar.tintColor = .black
             navigationController?.navigationBar.barTintColor = .white
            StatusBarColor.shared.isDark = true
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })



            view.backgroundColor = .darkGray
            Vstack.subviews[0].backgroundColor = .gray
            titleLbl.textColor = .white
            
            schemeSegment.layer.borderColor  = UIColor.darkGray.cgColor //Dark mode
            schemeSegment.selectedSegmentTintColor = .white
            schemeSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
            schemeSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.darkGray], for: .normal)

             

      
             
             
             
         }
         else if scheme == 1 {
             //DARK
             view.backgroundColor = .black
             schemeItem.tintColor = .white
            mapIcon.tintColor = .white
             
             
             navigationController?.navigationBar.isTranslucent = false
             navigationController?.navigationBar.tintColor = .white
             navigationController?.navigationBar.barTintColor = .black
            StatusBarColor.shared.isDark = false
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })
            
            view.backgroundColor = .black
            Vstack.subviews[0].backgroundColor = .darkGray
            titleLbl.textColor = .white
            
            schemeSegment.layer.borderColor  = UIColor.gray.cgColor //Dark mode
            schemeSegment.selectedSegmentTintColor = .black
            schemeSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
            schemeSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
             

               
             
         }
         else {
             //LIGHT
            view.backgroundColor = .white
              schemeItem.tintColor = .black
            mapIcon.tintColor = .black
            
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = .black
            navigationController?.navigationBar.barTintColor = .white
            StatusBarColor.shared.isDark = true
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })
 
            Vstack.subviews[0].backgroundColor = .lightGray
            titleLbl.textColor = .white
            
            schemeSegment.layer.borderColor  = UIColor.white.cgColor //Dark mode
            schemeSegment.selectedSegmentTintColor = .white
            schemeSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
            schemeSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)

             
             
         }
     }
    


    @objc func goBackHome() {
        print("+++GO HOME")
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    
}
