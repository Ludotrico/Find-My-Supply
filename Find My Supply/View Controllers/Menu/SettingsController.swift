//
//  SettingsController.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 4/7/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {

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
    
    
    let gearItem: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "gear")
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
    
    let Hstack1: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 15
        stack.alignment = .center
        //stack.addBackground(color: .white, cornerRadius: 10)
   
    
        return stack
    }()
    
    
    
    let searchImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .black //dark mode
        view.contentMode = .scaleAspectFit
        view.sizeToFit()
        view.widthAnchor.constraint(equalToConstant: 30).isActive = true
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return view

    }()
    
    let searchSettingsLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Search"
        lbl.font = UIFont(name: "HelveticaNeue", size: 25)
        lbl.textColor = .black //Dark mode
        lbl.numberOfLines = 1
        lbl.sizeToFit()
        return lbl
        
    }()
    
    let arrow1: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .black //dark mode
        view.contentMode = .scaleAspectFit
        view.sizeToFit()
        view.widthAnchor.constraint(equalToConstant: 30).isActive = true
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return view

    }()
    
    let Hstack2: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 15
        stack.alignment = .center
        //stack.addBackground(color: .white, cornerRadius: 10)
  
    
        return stack
    }()
    
    let mapImage: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "mapTransp")
        view.contentMode = .scaleAspectFit
        view.sizeToFit()
        view.widthAnchor.constraint(equalToConstant: 30).isActive = true
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return view

    }()
    
    let mapSettingsLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Map"
        lbl.font = UIFont(name: "HelveticaNeue", size: 25)
        lbl.textColor = .black //Dark mode
        lbl.numberOfLines = 1
        lbl.sizeToFit()
        return lbl
        
    }()
    
    let arrow2: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .black //dark mode
        view.contentMode = .scaleAspectFit
        view.sizeToFit()
        view.widthAnchor.constraint(equalToConstant: 30).isActive = true
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return view

    }()
    
    let Hstack3: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 15
        stack.alignment = .center
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 10
        //stack.addBackground(color: .white, cornerRadius: 10)
    
        return stack
    }()
    
    let colorImage: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "colrSettings")
        view.contentMode = .scaleAspectFit
        view.sizeToFit()
        view.widthAnchor.constraint(equalToConstant: 30).isActive = true
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        return view

    }()
    
    let colorSchemeLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Color Scheme"
        lbl.font = UIFont(name: "HelveticaNeue", size: 25)
        lbl.textColor = .black //Dark mode
        lbl.numberOfLines = 1
        lbl.sizeToFit()
        return lbl
        
    }()
    
    let arrow3: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .black //dark mode
        view.contentMode = .scaleAspectFit
        view.sizeToFit()
        view.widthAnchor.constraint(equalToConstant: 30).isActive = true
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return view

    }()
    
    //MARK: Variables
    var menuController: MenuController!
    var homeController: HomeController!
    
    
    //MARK: Selectors
    
    @objc func goToSearchSettings() {
        navigationController?.pushViewController(SearchSettingsController(), animated: true)
    }
    
    @objc func goToMapSettings() {
        navigationController?.pushViewController(MapSettingsController(), animated: true)
    }
    
    @objc func goToSchemeSettings() {
        let CSC = ColorSchemeController()
        CSC.menuController = menuController
        CSC.homeController = homeController
        CSC.settingsController = self
        navigationController?.pushViewController(CSC, animated: true)
    }
    
    //MARK: Helper Functions
    
    func configureViewComponents() {

        view.backgroundColor = .black   //Dark mode
        
        navigationItem.titleView = gearItem
        
        view.addSubview(scrollView)
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        scrollView.addSubview(Hstack1)

        Hstack1.anchor(top: scrollView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: view.frame.width-20, height: 40)
        Hstack1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
        Hstack1.addArrangedSubview(searchImage)
        searchImage.leftAnchor.constraint(equalTo: Hstack1.leftAnchor, constant: 10).isActive = true
        Hstack1.addArrangedSubview(searchSettingsLbl)
        searchSettingsLbl.widthAnchor.constraint(equalToConstant: 60).isActive = true
        Hstack1.addArrangedSubview(arrow1)
        arrow1.rightAnchor.constraint(equalTo: Hstack1.rightAnchor, constant: -20).isActive = true
        
        var tap = UITapGestureRecognizer(target: self, action: #selector(goToSearchSettings))
        Hstack1.addGestureRecognizer(tap)
        
        scrollView.addSubview(Hstack2)
        Hstack2.anchor(top: Hstack1.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: view.frame.width-20, height: 40)
        Hstack2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tap = UITapGestureRecognizer(target: self, action: #selector(goToMapSettings))
        Hstack2.addGestureRecognizer(tap)
    
        Hstack2.addArrangedSubview(mapImage)
        mapImage.leftAnchor.constraint(equalTo: Hstack2.leftAnchor, constant: 10).isActive = true
        Hstack2.addArrangedSubview(mapSettingsLbl)
        mapSettingsLbl.widthAnchor.constraint(equalToConstant: 60).isActive = true
        Hstack2.addArrangedSubview(arrow2)
        arrow2.rightAnchor.constraint(equalTo: Hstack2.rightAnchor, constant: -20).isActive = true
    
        scrollView.addSubview(Hstack3)
        Hstack3.anchor(top: Hstack2.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: view.frame.width-20, height: 40)
        Hstack3.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tap = UITapGestureRecognizer(target: self, action: #selector(goToSchemeSettings))
        Hstack3.addGestureRecognizer(tap)
    
        Hstack3.addArrangedSubview(colorImage)
        colorImage.leftAnchor.constraint(equalTo: Hstack3.leftAnchor, constant: 10).isActive = true
        Hstack3.addArrangedSubview(colorSchemeLbl)
       
        Hstack3.addArrangedSubview(arrow3)
        arrow3.rightAnchor.constraint(equalTo: Hstack3.rightAnchor, constant: -20).isActive = true

        configureColorScheme()
    }
    
    func configureColorScheme() {
        let scheme = UserDefaults.standard.integer(forKey: "colorScheme")
        
        if scheme == 0 {
            //STANDARD
            view.backgroundColor = .darkGray
            
            gearItem.tintColor = .black
            
            navigationController?.navigationBar.isTranslucent = true
            navigationController?.navigationBar.tintColor = .black
            navigationController?.navigationBar.barTintColor = .white
            StatusBarColor.shared.isDark = true
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })
            
            for stack in [Hstack1, Hstack2, Hstack3] {
                stack.addBackground(color: .white, cornerRadius: 10)
            }
                        
            
            
            
            
            
            
            
        }
        else if scheme == 1 {
            //DARK
            view.backgroundColor = .black
            
            gearItem.tintColor = .white
            
            navigationController?.navigationBar.isTranslucent = false
            //navigationController?.overrideUserInterfaceStyle  = .dark
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.barTintColor = .black
            StatusBarColor.shared.isDark = false
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })
            
            for stack in [Hstack1, Hstack2, Hstack3] {
                stack.addBackground(color: .white, cornerRadius: 10)
            }

        }
        else {
            //LIGHT
            view.backgroundColor = .white
            
            gearItem.tintColor = .black
            
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = .black
            navigationController?.navigationBar.barTintColor = .white
            StatusBarColor.shared.isDark = true
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })
            
            for stack in [Hstack1, Hstack2, Hstack3] {
                stack.addBackground(color: .lightGray, cornerRadius: 10)
            }

            
            
        }
    }
    
    
    
    
    
    
    

}
