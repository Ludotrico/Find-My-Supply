//
//  NotificationCell.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 4/9/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        
        selectionStyle = .none
        configureViewComponents()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
//    var notifImage: UIImageView = {
//        let view = UIImageView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.contentMode = .scaleAspectFit
//        view.clipsToBounds = true
//        view.layer.cornerRadius = 5
//        view.image = #imageLiteral(resourceName: "71d611ca-0e5c-4a6c-b10d-0e0ee94cb4b9_2.5cb24b19864d3394f6a6349dec877db1")
//        return view
//    }()
//
//    let deleteBtn: UIButton = {
//        let button = UIButton(type: .system)
//        var img = UIImage(systemName: "trash.circle.fill")!.withRenderingMode(.alwaysTemplate)
//
//        button.setImage( img, for: .normal)
//        button.tintColor = UIColor.rgb(red: 255, green: 0, blue: 0)
//        button.sizeToFit()
//       // button.addTarget(self, action: #selector(handleCenterOnUser), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//
//    }()
//
//    var Vstack1: UIStackView = {
//        let stack = UIStackView()
//        stack.axis = .vertical
//        stack.alignment = .center
//        //stack.sizeToFit()
//
//        return stack
//    }()
//
//    var productName: UILabel = {
//        let lbl = UILabel()
//        lbl.translatesAutoresizingMaskIntoConstraints = false
//        lbl.numberOfLines = 0
//        lbl.text = "Toilet Paper"
//        //productName.adjustsFontSizeToFitWidth = true
//        lbl.sizeToFit()
//        lbl.textColor = .black
//        lbl.font = UIFont(name: "HelveticaNeue", size: 15)
//        lbl.textAlignment = .center
//        return lbl
//    }()
//
//
//    var line: UIView = {
//        let view = UIView()
//        view.backgroundColor = .lightGray
//        view.layer.cornerRadius = 2
//        return view
//    }()
//
//
//
//
//    func configureViewComponents() {
//        //addSubview(notifImage)
//        //notifImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 125, height: 125)
//
//        addSubview(deleteBtn)
//        deleteBtn.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 2, width: 30, height: 30)
//
//        addSubview(Vstack1)
//        Vstack1.anchor(top: topAnchor, left: rightAnchor, bottom: bottomAnchor, right: leftAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width:  0, height: 0)
//
//        Vstack1.addArrangedSubview(productName)
//        productName.anchor(top: Vstack1.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//    }
//

    
    let notifImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        //view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
        let deleteBtnFake: UIButton = {
            let button = UIButton(type: .system)
            var img = UIImage(systemName: "trash.circle.fill")!.withRenderingMode(.alwaysTemplate)
    
            button.setImage( img, for: .normal)
            button.tintColor = UIColor.rgb(red: 255, green: 0, blue: 0)
            button.sizeToFit()
            //button.addTarget(self, action: #selector(test), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            return button
    
        }()
    
        let deleteBtn: UIButton = {
            let button = UIButton(type: .system)
            var img = UIImage(systemName: "trash.circle.fill")!.withRenderingMode(.alwaysTemplate)
    
            button.setImage( img, for: .normal)
            button.tintColor = UIColor.rgb(red: 255, green: 0, blue: 0)
            button.sizeToFit()
            //button.addTarget(self, action: #selector(test), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
    
        }()
    
        var productName: UILabel = {
            let lbl = UILabel()
            lbl.translatesAutoresizingMaskIntoConstraints = false
            lbl.numberOfLines = 0
            lbl.text = ""
            //productName.adjustsFontSizeToFitWidth = true
            lbl.sizeToFit()
            lbl.textColor = .black
            lbl.font = Fonts.shared.tableRowTitle//UIFont(name: "HelveticaNeue", size: 15)
            lbl.textAlignment = .center
            return lbl
        }()
    
    

    

    
    
    

    var Vstack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .top
        stack.spacing = 10
        //stack.sizeToFit()
        stack.translatesAutoresizingMaskIntoConstraints = false

        return stack
    }()
    
    
    var Hstack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.sizeToFit()
        stack.translatesAutoresizingMaskIntoConstraints = false
    
        //stack.distribution = .equalSpacing
        return stack
    }()
    
    var Vstack2: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.sizeToFit()
        stack.spacing = 2
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    

    
    var titleStackLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = .black
        lbl.text = ""
        lbl.sizeToFit()
        lbl.font = Fonts.shared.tableRowContent//UIFont(name: "HelveticaNeue", size: 15)
        lbl.textAlignment = .center
        return lbl
    }()
    
    var addressLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textColor = .gray //Dark mode
        lbl.text = ""//"26502 Towne Centre Dr, Foothill Ranch, CA 92610"
        lbl.sizeToFit()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.font = Fonts.shared.tableRowContent//UIFont(name: "HelveticaNeue", size: 12)
        lbl.textAlignment = .center
        return lbl
    }()
    
    var dateLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.text = ""
        lbl.sizeToFit()
        lbl.font = Fonts.shared.tableRowContent//UIFont(name: "HelveticaNeue", size: 15)
        lbl.textAlignment = .center
        return lbl
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
        view.backgroundColor = .black
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    

    
    
    func configureViewComponents() {
        addSubview(deleteBtnFake)
        deleteBtnFake.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 30, height: 30)
        
        addSubview(notifImage)
        notifImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 0, width: 100, height: 125)


        addSubview(Vstack)
        Vstack.anchor(top: topAnchor, left: notifImage.rightAnchor, bottom: bottomAnchor, right: deleteBtnFake.leftAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 5, width: 1000, height: 1000)

        Vstack.addArrangedSubview(productName)
        productName.anchor(top: Vstack.topAnchor, left: Vstack.leftAnchor, bottom: nil, right: deleteBtnFake.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 1000, height: 0)

        Vstack.addArrangedSubview(line)
        line.anchor(top: productName.bottomAnchor, left: Vstack.leftAnchor, bottom: nil, right: deleteBtnFake.leftAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: Vstack.frame.width, height: 2)
        //line.topAnchor.constraint(equalTo: topAnchor, constant: 45).isActive = true

        Vstack.addArrangedSubview(Hstack)
        Hstack.anchor(top: nil, left: Vstack.leftAnchor, bottom: Vstack.bottomAnchor, right: Vstack.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

        Hstack.addArrangedSubview(Vstack2)
        
        Vstack2.addArrangedSubview(titleStackLbl)
        Vstack2.addArrangedSubview(addressLbl)
        
        
        Hstack.addArrangedSubview(dateLbl)
        dateLbl.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 70, height: 0)
        
        addSubview(deleteBtn)
        deleteBtn.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 30, height: 30)
        
        addSubview(divider)
        divider.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: frame.width, height: 0.5)
        
        configureColorScheme()
    }
    
    func configureColorScheme() {
        let scheme = UserDefaults.standard.integer(forKey: "colorScheme")
        
        if scheme == 0 {
            //STANDARD
            backgroundColor = .white
            
            line.backgroundColor = .lightGray
            
            productName.textColor = .black
            titleStackLbl.textColor = .black
            addressLbl.textColor = .gray
            dateLbl.textColor = .gray
            
            divider.backgroundColor = .darkGray
            

            
    
            
        }
        else if scheme == 1 {
            //DARK
            backgroundColor = .black
            
            line.backgroundColor = .white
            
            productName.textColor = .white
            titleStackLbl.textColor = .white
            addressLbl.textColor = .lightGray
            dateLbl.textColor = .lightGray
            
            divider.backgroundColor = .white
            

            

        }
        else {
            //LIGHT
            backgroundColor = .white               
               line.backgroundColor = .lightGray
               
               productName.textColor = .black
               titleStackLbl.textColor = .black
               addressLbl.textColor = .gray
               dateLbl.textColor = .gray
               
               divider.backgroundColor = .darkGray

            
            
        }
    }
    
    @objc func test() {
        print("+++DELETE")
    }
    
    
    
}
