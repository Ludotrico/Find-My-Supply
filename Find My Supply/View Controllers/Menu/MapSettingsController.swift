//
//  MapSettingsController.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 4/10/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import UIKit

class MapSettingsController: UIViewController {

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
    
    //MARK:  Views
    
    let mapItem: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "mapTransp").withRenderingMode(.alwaysTemplate)
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
        stack.sizeToFit()
        stack.translatesAutoresizingMaskIntoConstraints = false
     
         return stack
     }()
    
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Map Type"
        lbl.font = Fonts.shared.largeBold//UIFont(name: "HelveticaNeue", size: 25)
        lbl.textColor = .white //Dark mode
        lbl.numberOfLines = 1
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
        
    }()
    
    
    lazy var mapTypeSegment: UISegmentedControl = {
        let control = UISegmentedControl(items: mapTypes)
        control.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "mapType")
        control.layer.cornerRadius = 10
        control.layer.borderWidth = 1
        control.layer.masksToBounds = true
        control.layer.borderColor  = UIColor.white.cgColor //Dark mode
        control.addTarget(self, action: #selector(handleMapTypeToggle(_:)), for: .valueChanged)
        control.tintColor = .white
        control.selectedSegmentTintColor = .white
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    
    
    
    
    
     let Vstack2: UIStackView = {
         let stack = UIStackView()
         stack.axis = .vertical
         stack.spacing = 15
         stack.alignment = .center
         //stack.addBackground(color: .darkGray, cornerRadius: 15)
        stack.distribution = .equalSpacing
        stack.sizeToFit()
        stack.translatesAutoresizingMaskIntoConstraints = false
         return stack
     }()
    
    let titleLbl2: UILabel = {
        let lbl = UILabel()
        lbl.text = "Map Style"
        lbl.font = Fonts.shared.largeBold//UIFont(name: "HelveticaNeue", size: 25)
        lbl.textColor = .white //Dark mode
        lbl.numberOfLines = 1
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
        
    }()
    
    
    lazy var mapStyleSegment: UISegmentedControl = {
        let control = UISegmentedControl(items: mapStyles)
        let style = UserDefaults.standard.string(forKey: "mapStyle")
        if style == nil {
            control.selectedSegmentIndex = 0
        }
        else if style == "D" {
            control.selectedSegmentIndex = 0
        }
        else {
            control.selectedSegmentIndex = 1
        }
        
        control.layer.cornerRadius = 10
        control.layer.borderWidth = 1
        control.layer.masksToBounds = true
        control.layer.borderColor  = UIColor.white.cgColor //Dark mode
        control.addTarget(self, action: #selector(handleMapStyleToggle(_:)), for: .valueChanged)
        control.tintColor = .white
        control.selectedSegmentTintColor = .white
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    
    
     let Vstack3: UIStackView = {
         let stack = UIStackView()
         stack.axis = .vertical
         stack.spacing = 15
         stack.alignment = .center
         //stack.addBackground(color: .darkGray, cornerRadius: 15)
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
    
     
         return stack
     }()
    
    
    
    
    let titlelbl3: UILabel = {
        let lbl = UILabel()
        lbl.text = "Get Directions From"
        lbl.font = Fonts.shared.largeBold//UIFont(name: "HelveticaNeue", size: 25)
        lbl.textColor = .white //Dark mode
        lbl.numberOfLines = 1
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
        
    }()
    
    

    

    lazy var mapAppSegment: UISegmentedControl = {
        let control = UISegmentedControl(items: mapApps)
        control.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "mapApp")
        control.layer.cornerRadius = 10
        control.layer.borderWidth = 1
        control.layer.masksToBounds = true

        control.layer.borderColor  = UIColor.white.cgColor //Dark mode
        control.addTarget(self, action: #selector(handleMapAppToggle(_:)), for: .valueChanged)
        control.tintColor = .white
        control.selectedSegmentTintColor = .white
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    

    

    
    let save: UIButton = {
        let btn = UIButton()
        btn.setTitle("Save", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        btn.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 25)
        btn.layer.borderColor = UIColor.white.cgColor //Dark mode
        btn.layer.borderWidth = 3
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(saveChanges), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
        
    }()
    
    
    
    
    
    
    
    //MARK: Variables
    let mapTypes = ["Standard", "Hybrid", "Satelite"]
    let mapStyles = ["Dark", "Light"]
    let mapApps = ["Apple Maps", "Waze", "Google Maps" ]
     let scheme = UserDefaults.standard.integer(forKey: "colorScheme")

    
    //MARK: Selectors
    

    
    @objc func saveChanges() {
        //print("++++ saveee")

    }
    
    
    
    //MARK: Helper Functions

    
    @objc func handleMapAppToggle(_ control: UISegmentedControl) {
        //print("+++MAp style toggled")
        
        switch control.selectedSegmentIndex {
        case 0:
            UserDefaults.standard.set(0, forKey: "mapApp")
            
        case 1:
            if UIApplication.shared.canOpenURL(URL(string:"waze://")!) {
                UserDefaults.standard.set(1, forKey: "mapApp")
            }
            else {
                showMessage(label: createLbl(text: "Waze is not downloaded."))
                control.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "mapApp")
            }
        case 2:
            if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
                UserDefaults.standard.set(2, forKey: "mapApp")
            }
            else {
                showMessage(label: createLbl(text: "Google maps is not downloaded."))
                control.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "mapApp")
            }
            
        default:
            UserDefaults.standard.set(0, forKey: "mapApp")
            
        }
        
        
    }
    
    @objc func handleMapStyleToggle(_ control: UISegmentedControl) {
        //print("+++MAp style toggled")
        
        switch control.selectedSegmentIndex {
        case 0:
            UserDefaults.standard.set("D", forKey: "mapStyle")
            
        case 1:
            UserDefaults.standard.set("L", forKey: "mapStyle")
        default:
            UserDefaults.standard.set("D", forKey: "mapStyle")
            
        }
        
        
    }
    
    @objc func handleMapTypeToggle(_ control: UISegmentedControl) {
        //print("+++ mapType toggled")
        
        switch control.selectedSegmentIndex {
        case 0:
            UserDefaults.standard.set(0, forKey: "mapType")
            
        case 1:
            UserDefaults.standard.set(1, forKey: "mapType")
        case 2:
            UserDefaults.standard.set(2, forKey: "mapType")
        default:
            UserDefaults.standard.set(0, forKey: "mapType")
            
        }
        
        
    }
    
    func createLbl(text: String) -> UILabel {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.rgb(red: 209, green: 21, blue: 0)
        lbl.textColor = .white
        lbl.text = text
        lbl.font = Fonts.shared.slideInMessage
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
        
        navigationItem.titleView = mapItem
        
        
        view.addSubview(scrollView)
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        scrollView.addSubview(Vstack)
        Vstack.anchor(top: scrollView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: view.frame.width-30, height: 100)
        Vstack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Vstack.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 10, right: 10)
        Vstack.isLayoutMarginsRelativeArrangement = true
        
        Vstack.addArrangedSubview(titleLbl)
        titleLbl.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        
        Vstack.addArrangedSubview(mapTypeSegment)
        mapTypeSegment.anchor(top: nil, left: nil, bottom: nil, right:nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 10000, height: 10000)
        
        
        scrollView.addSubview(Vstack2)
        Vstack2.anchor(top: Vstack.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: view.frame.width-30, height: 100)
        Vstack2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Vstack2.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 10, right: 10)
        Vstack2.isLayoutMarginsRelativeArrangement = true
        
        Vstack2.addArrangedSubview(titleLbl2)
        titleLbl2.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        
        
        Vstack2.addArrangedSubview(mapStyleSegment)
        mapStyleSegment.anchor(top: nil, left: nil, bottom: nil, right:nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 10000, height: 10000)
        
        scrollView.addSubview(Vstack3)
        Vstack3.anchor(top: Vstack2.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: view.frame.width-30, height: 100)
        Vstack3.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Vstack3.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 10, right: 10)
        Vstack3.isLayoutMarginsRelativeArrangement = true
        
        Vstack3.addArrangedSubview(titlelbl3)
        titlelbl3.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        
        
        Vstack3.addArrangedSubview(mapAppSegment)
        mapAppSegment.anchor(top: nil, left: nil, bottom: nil, right:nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 10000, height: 10000)

        
        configureColorScheme()
        
    }
    
    func configureColorScheme() {
   
        
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
            
            mapItem.tintColor = .black
            
            Vstack.addBackground(color: .gray, cornerRadius: 10)
            Vstack2.addBackground(color: .gray, cornerRadius: 10)
            Vstack3.addBackground(color: .gray, cornerRadius: 10)
            
            for segment in [mapTypeSegment, mapStyleSegment, mapAppSegment] {
                segment.layer.borderColor  = UIColor.darkGray.cgColor //Dark mode
                segment.selectedSegmentTintColor = .white
                segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
                segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.darkGray], for: .normal)
            }
            
            
     
            
            
            
            
            
            
            
        }
        else if scheme == 1 {
            //DARK
            view.backgroundColor = .black
            mapItem.tintColor = .white
            
            
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.barTintColor = .black
            StatusBarColor.shared.isDark = false
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })
            
            Vstack.addBackground(color: .darkGray, cornerRadius: 10)
            Vstack2.addBackground(color: .darkGray, cornerRadius: 10)
            Vstack3.addBackground(color: .darkGray, cornerRadius: 10)
            
            for segment in [mapTypeSegment, mapStyleSegment, mapAppSegment] {
                segment.layer.borderColor  = UIColor.gray.cgColor //Dark mode
                segment.selectedSegmentTintColor = .black
                segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
                segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
                
              
            }
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
            
            mapItem.tintColor = .black
            
            Vstack.addBackground(color: .lightGray, cornerRadius: 10)
            Vstack2.addBackground(color: .lightGray, cornerRadius: 10)
            Vstack3.addBackground(color: .lightGray, cornerRadius: 10)
            
            for segment in [mapTypeSegment, mapStyleSegment, mapAppSegment] {
                segment.layer.borderColor  = UIColor.white.cgColor //Dark mode
                segment.selectedSegmentTintColor = .white
                segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
                segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
            }

            
            
        }
    }
    

    
    @objc func goBackHome() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.popToRootViewController(animated: true)
    }
    


    
    
    
    
    
    
    

}
