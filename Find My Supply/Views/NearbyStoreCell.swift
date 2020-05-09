//
//  NearbyStoreCell.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 4/5/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import UIKit

class NearbyStoreCell: UICollectionViewCell {
    
    let storeImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    var chainLogo: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = #imageLiteral(resourceName: "targBlack")
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    

    

    
    
    

    var Vstack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .top
        stack.spacing = 10
        //stack.sizeToFit()

        return stack
    }()
    
    
    var Hstack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.sizeToFit()
    
        stack.distribution = .equalSpacing
        return stack
    }()
    
    var HstackTitle: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.sizeToFit()
    
        //stack.distribution = .equalSpacing
        return stack
    }()
    
    var cityLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
       
        lbl.textColor = .white
        lbl.adjustsFontSizeToFitWidth = true
        lbl.sizeToFit()
        lbl.font = UIFont(name: "HelveticaNeue", size: 18)
        lbl.textAlignment = .center
        return lbl
    }()
    
    

    
    var quantityLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = .white

        lbl.sizeToFit()
        lbl.font = UIFont(name: "HelveticaNeue", size: 15)
        lbl.textAlignment = .center
        return lbl
    }()
    
    var openStatusLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0

        lbl.sizeToFit()
        lbl.font = UIFont(name: "HelveticaNeue", size: 15)
        lbl.textAlignment = .center
        return lbl
    }()
    
    var distanceLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
       
        lbl.textColor = .white
        lbl.sizeToFit()
        lbl.font = UIFont(name: "HelveticaNeue", size: 15)
        lbl.textAlignment = .center
        return lbl
    }()
    
    


    
    
    
    var line: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 2
        return view
    }()
    
    var divider: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 2
        return view
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewComponents()
        backgroundColor = .clear
      
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    func configureViewComponents() {
        addSubview(storeImage)
        storeImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 0, width: 100, height: 100)
        
        addSubview(Vstack)
        Vstack.anchor(top: topAnchor, left: storeImage.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 1000, height: 1000)
        
        
        Vstack.addArrangedSubview(HstackTitle)
        HstackTitle.anchor(top: Vstack.topAnchor, left: Vstack.leftAnchor, bottom: nil, right: Vstack.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        
        HstackTitle.addArrangedSubview(chainLogo)
        HstackTitle.addArrangedSubview(cityLbl)
        
        addSubview(line)
        line.anchor(top: nil, left: Vstack.leftAnchor, bottom: nil, right: Vstack.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: Vstack.frame.width, height: 2)
        line.topAnchor.constraint(equalTo: topAnchor, constant: 45).isActive = true
        
        Vstack.addArrangedSubview(Hstack)
        Hstack.anchor(top: nil, left: Vstack.leftAnchor, bottom: Vstack.bottomAnchor, right: Vstack.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        Hstack.addArrangedSubview(quantityLbl)
        Hstack.addArrangedSubview(openStatusLbl)
        Hstack.addArrangedSubview(distanceLbl)
        
        addSubview(divider)
        divider.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: frame.width, height: 0.5)
        
        configureColorScheme()
        
    }
    
    func configureColorScheme() {
        let scheme = UserDefaults.standard.integer(forKey: "colorScheme")
        
        if scheme == 0 {
            //STANDARD
            divider.backgroundColor = .white
            //chainLogo.transform = CGAffineTransform(scaleX: 2, y: 2)
            

     

            
        }
        else if scheme == 1 {
            //DARK
            divider.backgroundColor = .darkGray
           // chainLogo.transform = CGAffineTransform(scaleX: 2, y: 2)

        }
        else {
            //LIGHT
            divider.backgroundColor = .lightGray
            line.backgroundColor = .lightGray
            
            quantityLbl.textColor = .black
            distanceLbl.textColor = .black
           // chainLogo.transform = CGAffineTransform(scaleX: 1, y: 1)
            
            

            
            
        }
    }
}
