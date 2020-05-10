//
//  SearchController.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 4/10/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import UIKit

class SearchSettingsController: UIViewController {

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
    
    override func viewWillDisappear(_ animated: Bool) {
        saveChanges()
    }
    
    //MARK:  Views
    
    let searchItem: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysTemplate)
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
         //stack.addBackground(color: .darkGray, cornerRadius: 15)
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
    
     
         return stack
     }()
    
    
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Search Radius (mi)"
        lbl.font = Fonts.shared.largeBold//UIFont(name: "HelveticaNeue", size: 25)
        lbl.textColor = .white //Dark mode
        lbl.numberOfLines = 1
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
        
    }()
    
    
     let Hstack1: UIStackView = {
         let stack = UIStackView()
         stack.axis = .horizontal
         stack.spacing = 15
         stack.alignment = .center
         //stack.addBackground(color: .lightGray, cornerRadius: 10)
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
    
     
         return stack
     }()
    
    
    
    let minus: UIButton = {
        let button = UIButton(type: .system)
        var img = UIImage(systemName: "minus")!.withRenderingMode(.alwaysTemplate)

        button.setImage( img, for: .normal)
        button.tintColor = .white
        button.sizeToFit()
        button.addTarget(self, action: #selector(subtract), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button

    }()
    
    let radius: UILabel = {
        let lbl = UILabel()
        lbl.text = "\(UserDefaults.standard.integer(forKey: "radius"))"
        lbl.font = Fonts.shared.largeLight//UIFont(name: "HelveticaNeue", size: 20)
        lbl.textColor = .black //Dark mode
        lbl.numberOfLines = 1
        lbl.backgroundColor = .white  //Dark mode
        lbl.layer.cornerRadius = 3
        lbl.layer.masksToBounds = true
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
        
    }()
    
    let plus: UIButton = {
        let button = UIButton(type: .system)
        var img = UIImage(systemName: "plus")!.withRenderingMode(.alwaysTemplate)

        button.setImage( img, for: .normal)
        button.tintColor = .white
        button.sizeToFit()
        button.addTarget(self, action: #selector(add), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
    
        return button

    }()
    

    
    
    
    
    
    
    
    //MARK: Variables
     let scheme = UserDefaults.standard.integer(forKey: "colorScheme")
    
    //MARK: Selectors
    
    @objc func subtract() {
        print("++++ SUB")
        if Int(radius.text!)! <= 5 {
            return
        }
        radius.text = "\(Int(radius.text!)! - 5)"
    }
    
    @objc func add() {
        print("++++ adddd")
        if Int(radius.text!)! >= 100 {
            return
        }
        radius.text = "\(Int(radius.text!)! + 5)"
    }
    
    @objc func saveChanges() {
        print("++++ saveee")
        if Int(radius.text!)! == UserDefaults.standard.integer(forKey: "radius") {
            return
        }
        
        UserDefaults.standard.set(Int(radius.text!)!, forKey: "radius")
    }
    
    
    
    //MARK: Helper Functions
    
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
    
    
    
    func configureViewComponents() {
        view.backgroundColor = .black
        
        navigationItem.titleView = searchItem
        
        
        view.addSubview(scrollView)
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        scrollView.addSubview(Vstack)
        Vstack.anchor(top: scrollView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width-100, height: 150)
        Vstack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Vstack.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        Vstack.isLayoutMarginsRelativeArrangement = true
        
        Vstack.addArrangedSubview(titleLbl)
        titleLbl.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        
        Vstack.addArrangedSubview(Hstack1)
        Hstack1.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 60)
        Hstack1.layoutMargins = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        Hstack1.isLayoutMarginsRelativeArrangement = true
        
        Hstack1.addArrangedSubview(minus)
        minus.transform = CGAffineTransform(scaleX: 2, y: 2)
        minus.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        
        Hstack1.addArrangedSubview(radius)
        radius.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        
        Hstack1.addArrangedSubview(plus)
        plus.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        plus.transform = CGAffineTransform(scaleX: 2, y: 2)
        
        configureColorScheme()
     
    }
    
    func configureColorScheme() {

        
        if scheme == 0 {
            //STANDARD
            view.backgroundColor = .darkGray
            
            searchItem.tintColor = .black
            
            navigationController?.navigationBar.isTranslucent = true
            navigationController?.navigationBar.tintColor = .black
            navigationController?.navigationBar.barTintColor = .white
            StatusBarColor.shared.isDark = true
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })
            
            Vstack.addBackground(color: .gray, cornerRadius: 10)
            Hstack1.addBackground(color: .white, cornerRadius: 10)
            
            plus.tintColor = .black
            minus.tintColor = .black
            
            
            
            
            
            
            
        }
        else if scheme == 1 {
            //DARK
            
            view.backgroundColor = .black
            
            searchItem.tintColor = .white
            
            
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.barTintColor = .black
            StatusBarColor.shared.isDark = false
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })

            
            
            Vstack.addBackground(color: .darkGray, cornerRadius: 10)
            Hstack1.addBackground(color: .gray, cornerRadius: 10)
            
            plus.tintColor = .white
            minus.tintColor = .white
        }
        else {
            //LIGHT
            view.backgroundColor = .white
            
            searchItem.tintColor = .black
            
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = .black
            navigationController?.navigationBar.barTintColor = .white
            StatusBarColor.shared.isDark = true
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })
            
            Vstack.addBackground(color: .lightGray, cornerRadius: 10)
            Hstack1.addBackground(color: .white, cornerRadius: 10)
            
            plus.tintColor = .black
            minus.tintColor = .black

            
            
        }
    }
    
    @objc func goBackHome() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.popToRootViewController(animated: true)
    }
    

}
