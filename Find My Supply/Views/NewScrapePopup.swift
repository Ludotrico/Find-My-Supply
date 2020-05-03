//
//  ThemePopup.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 4/11/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import UIKit

class NewScrapePopup: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Congratulations!"
        lbl.font = UIFont(name: "BrandonGrotesque-Black", size: 35)
        lbl.textColor = .white //Dark mode
        lbl.numberOfLines = 1
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
        
    }()
    

    
    

    
    let backgroundImg: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "web")
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.sizeToFit()
        
        
        
        return view
    }()
    
    
    let text: PaddingLabel = {
        let lbl = PaddingLabel()
        lbl.text = "You’re the first user in 92660! This ZIP code is not currently supported but we’re working hard to provide you reliable data quickly. We'll email you when the data's available."
        lbl.font = UIFont(name: "BrandonGrotesque-Black", size: 20)
        lbl.textColor = .black //Dark mode
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.adjustsFontSizeToFitWidth = true
        lbl.layer.cornerRadius = 10
        lbl.layer.masksToBounds = true
        lbl.textAlignment = .center
        lbl.backgroundColor = UIColor(white: 1, alpha: 0.7)
        
        return lbl
        
    }()
    
    
    

     

    
    //MARK: Helper Functions
    
    
    
    
    
    
    func configureViewComponents() {
        backgroundColor = .systemTeal
        layer.cornerRadius = 20
        alpha = 0.9
        
        layer.borderColor = Color.shared.gold.cgColor //UIColor.white.cgColor
        layer.borderWidth = 2
        
        
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "web")
        //view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.sizeToFit()
        view.layer.cornerRadius = 20
        
    
        
        addSubview(view)
        view.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        addSubview(titleLbl)
        //titleLbl.heightAnchor.constraint(equalToConstant:  40).isActive = true
        //titleLbl.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        titleLbl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLbl.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        
        
        
        addSubview(text)
        text.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 30, paddingBottom: 30, paddingRight: 30, width: frame.width-40, height: 0)
        
        
//        whiteRect.addSubview(text)
//        text.anchor(top: whiteRect.topAnchor, left: whiteRect.leftAnchor, bottom: whiteRect.bottomAnchor, right: whiteRect.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 0)

        
        
        

        
        
        
    
    }

}
