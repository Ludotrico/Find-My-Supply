//
//  ProductCell.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 4/3/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import UIKit


class ProductCell: UITableViewCell {
    
    
    
    var productImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    var productName: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        //productName.adjustsFontSizeToFitWidth = true
        lbl.sizeToFit()
        lbl.textColor = .black
        lbl.font = Fonts.shared.tableRowTitle//UIFont(name: "HelveticaNeue", size: 15)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    

    
    
    

    var Vstack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .top
        stack.translatesAutoresizingMaskIntoConstraints = false
        //stack.sizeToFit()

        return stack
    }()
    
    
    var Hstack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.sizeToFit()
        stack.spacing = 10
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    var Vstack2: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.sizeToFit()
        stack.translatesAutoresizingMaskIntoConstraints = false

        return stack
    }()
    
    var stockStatusLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        //productName.adjustsFontSizeToFitWidth = true
        lbl.sizeToFit()
        lbl.font = Fonts.shared.tableRowContent//UIFont(name: "HelveticaNeue", size: 15)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var quantityLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        //productName.adjustsFontSizeToFitWidth = true
        lbl.textColor = .gray
        lbl.sizeToFit()
        lbl.font = Fonts.shared.tableRowContent//UIFont(name: "HelveticaNeue", size: 15)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var priceLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        //productName.adjustsFontSizeToFitWidth = true
        lbl.textColor = .black
        lbl.sizeToFit()
        lbl.font = Fonts.shared.tableRowContent//UIFont(name: "HelveticaNeue", size: 15)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var nearbyStoresBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Nearby stores", for: .normal)
        button.titleLabel?.font = Fonts.shared.tableRowBtn//UIFont(name: "HelveticaNeue", size: 15)
        button.setTitleColor(Color.shared.blue, for: .normal)
        button.layer.borderColor = Color.shared.blue.cgColor
        button.layer.borderWidth = 1.25
        button.layer.cornerRadius = 5
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.clipsToBounds = true
        button.tag = -1
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.translatesAutoresizingMaskIntoConstraints = false
    
        return button
    }()
    
    var notificationView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.layer.cornerRadius = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let notificationBtn: UIButton = {
        let button = UIButton(type: .system)
        var img = #imageLiteral(resourceName: "notfi+").withRenderingMode(.alwaysOriginal)
    
        button.setImage( img, for: .normal)
        button.sizeToFit()
       // button.addTarget(self, action: #selector(handleCenterOnUser), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
        
    }()
    
    let notificationBtnFake: UIButton = {
        let button = UIButton(type: .system)
        var img = #imageLiteral(resourceName: "notfi+").withRenderingMode(.alwaysOriginal)
    
        button.setImage( img, for: .normal)
        button.sizeToFit()
       // button.addTarget(self, action: #selector(handleCenterOnUser), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    
    
    var line: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var divider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var rowHeight = -1
    var stackWidth = CGFloat(-1)
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        
        selectionStyle = .none
        configureViewComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    let scheme = UserDefaults.standard.integer(forKey: "colorScheme")
    
    
    
    func configureViewComponents() {
        
        
        addSubview(productImage)
        
        addSubview(notificationBtnFake)
        notificationBtnFake.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 30, height: 30)
        
        

        productImage.frame = CGRect(x: 0,y: 0,width: 100,height: rowHeight)
        
        productImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 100, height: CGFloat(100))
        
        addSubview(Vstack)
  
        
        Vstack.anchor(top: topAnchor, left: productImage.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
        Vstack.addArrangedSubview(productName)
        productName.anchor(top: nil, left: Vstack.leftAnchor, bottom: nil, right: notificationBtnFake.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 5)
        

        Vstack.addSubview(line)
        line.anchor(top: productName.bottomAnchor, left: Vstack.leftAnchor, bottom: nil, right: notificationBtnFake.leftAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: Vstack.frame.width, height: 2)
        
        Vstack.addArrangedSubview(Hstack)
        Hstack.anchor(top: nil, left: Vstack.leftAnchor, bottom: Vstack.bottomAnchor, right: Vstack.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: 0, height: 0)
        
        Hstack.addArrangedSubview(Vstack2)
        //Vstack2.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 0)
        
        Vstack2.addArrangedSubview(stockStatusLbl)

        
        Vstack2.addArrangedSubview(quantityLbl)
        
        
        Hstack.addArrangedSubview(priceLbl)
        //priceLbl.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 60, height: 0)
       
        
        Hstack.addArrangedSubview(nearbyStoresBtn)
        nearbyStoresBtn.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 60, height: 45)
        
        
        
        stackWidth = Vstack.frame.width
        
        addSubview(divider)
        divider.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: frame.width, height: 0.5)
        
        configureColorScheme()
    }
    
    func configureColorScheme() {
        let scheme = UserDefaults.standard.integer(forKey: "colorScheme")
        
        if scheme == 0 {
            //STANDARD
            backgroundColor = .white
            divider.backgroundColor = .darkGray
            
            line.backgroundColor = .lightGray
            line.alpha = 0.6
            
            quantityLbl.textColor = .black
            priceLbl.textColor = .gray

            
     
            
            
            
            
            
            
            
        }
        else if scheme == 1 {
            //DARK
            backgroundColor = .black
            
            productName.textColor = .white
            line.backgroundColor = .white
            
            divider.backgroundColor = .darkGray
            
            quantityLbl.textColor = .white
            priceLbl.textColor = .lightGray
            
            

        }
        else {
            //LIGHT
            backgroundColor = .white
            divider.backgroundColor = .darkGray
            
            line.backgroundColor = .lightGray
            line.alpha = 0.6
            
            quantityLbl.textColor = .black
            priceLbl.textColor = .gray

            
            
        }
    }

    
    
    @objc func showNearbyStores() {
        //print("====NEARBY STOREs")
    }
}
