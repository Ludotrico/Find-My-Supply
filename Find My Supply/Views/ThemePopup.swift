//
//  ThemePopup.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 4/11/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import UIKit

class ThemePopup: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     let Vstack: UIStackView = {
         let stack = UIStackView()
         stack.axis = .vertical
         
         stack.alignment = .center
         //stack.addBackground(color: Color.shared.blue, cornerRadius: 15)
        //stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
    
     
         return stack
     }()
    
    
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Color Theme"
        lbl.font = UIFont(name: "BrandonGrotesque-Black", size: 35)//UIFont(name: "HelveticaNeue", size: 25)
        lbl.textColor = .white //Dark mode
        lbl.numberOfLines = 1
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
        
    }()
    
    
     let Hstack: UIStackView = {
         let stack = UIStackView()
         stack.axis = .horizontal
         //stack.spacing = 15
         stack.alignment = .center
    
        //stack.addBackground(color: .lightGray, cornerRadius: 15)
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let standardImg: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "standard")
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.sizeToFit()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        
        return view
    }()
    
    let darkImg: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "night")
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.sizeToFit()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        
        return view
    }()
    
    let lightImg: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "light")
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.sizeToFit()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
        
    
    
    
    
    
        lazy var themeSegment: UISegmentedControl = {
            let control = UISegmentedControl(items: themes)
            control.selectedSegmentIndex = 0
            control.layer.cornerRadius = 10
            control.layer.borderWidth = 1
            control.layer.masksToBounds = true
            control.layer.borderColor  = UIColor.white.cgColor //Dark mode
            control.addTarget(self, action: #selector(handleThemeToggle(_:)), for: .valueChanged)
            control.tintColor = .white
            control.selectedSegmentTintColor = .white
            control.translatesAutoresizingMaskIntoConstraints = false
            control.translatesAutoresizingMaskIntoConstraints = false
            return control
        }()
        

    
     
    
    let themes = ["Standard", "Dark", "Light"]
    
    
    
    
    //MARK: Helper Functions
    
    @objc func handleThemeToggle(_ control: UISegmentedControl) {
        //print("+++Theme toggled  \(control.selectedSegmentIndex)")
        
        switch control.selectedSegmentIndex {
        case 0:
            UserDefaults.standard.set(0, forKey: "colorScheme")
        
        case 1:
            UserDefaults.standard.set(1, forKey: "colorScheme")
        default:
            UserDefaults.standard.set(2, forKey: "colorScheme")
            
        }
        
        
    }
    
 
    
    
    
    
    
    func configureViewComponents() {
        backgroundColor = .systemTeal
        layer.cornerRadius = 20
        alpha = 0.9
        
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        overrideUserInterfaceStyle = .light
        
        addSubview(Vstack)
        Vstack.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 15, paddingBottom: 15, paddingRight: 15)
        
        Vstack.addArrangedSubview(titleLbl)
        titleLbl.heightAnchor.constraint(equalToConstant:  40).isActive = true
        
        Vstack.addArrangedSubview(Hstack)
        
        Hstack.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 280, height: 70)
        Hstack.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        Hstack.isLayoutMarginsRelativeArrangement = true
        
        Hstack.addArrangedSubview(standardImg)
        standardImg.widthAnchor.constraint(equalToConstant: 80).isActive = true
        standardImg.heightAnchor.constraint(equalToConstant: 80).isActive = true
        Hstack.addArrangedSubview(darkImg)
        darkImg.widthAnchor.constraint(equalToConstant: 80).isActive = true
        darkImg.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        Hstack.addArrangedSubview(lightImg)
        lightImg.widthAnchor.constraint(equalToConstant: 80).isActive = true
        lightImg.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        Vstack.addArrangedSubview(themeSegment)
        themeSegment.widthAnchor.constraint(equalToConstant: 280).isActive = true
        themeSegment.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
    
    }

}
