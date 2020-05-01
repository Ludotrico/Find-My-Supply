//
//  MenuCell.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 4/7/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

      var icon: UIImageView = {
          let view = UIImageView()
          view.translatesAutoresizingMaskIntoConstraints = false
          view.contentMode = .scaleAspectFit
          view.clipsToBounds = true
          view.layer.cornerRadius = 5
          return view
      }()
      
      
      var productName: UILabel = {
          let lbl = UILabel()
          lbl.translatesAutoresizingMaskIntoConstraints = false
          lbl.numberOfLines = 0
          //productName.adjustsFontSizeToFitWidth = true
          lbl.sizeToFit()
          lbl.textColor = .black
          lbl.font = UIFont(name: "HelveticaNeue", size: 15)
          lbl.textAlignment = .center
          return lbl
      }()
      

      
      
      
      
      var Hstack: UIStackView = {
          let stack = UIStackView()
          stack.axis = .horizontal
          stack.alignment = .leading
          stack.sizeToFit()
          stack.spacing = 20
          //stack.distribution = .equalSpacing
          return stack
      }()
      
    
      

      override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
          super.init(style: style, reuseIdentifier: reuseIdentifier)

          
          selectionStyle = .none
          configureViewComponents()
      }
      
      required init?(coder: NSCoder) {
          fatalError()
      }
      
      
      
      
      func configureViewComponents() {
          

        addSubview(Hstack)
        Hstack.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        
        icon.image = #imageLiteral(resourceName: "ic_person_outline_white_2x")
        Hstack.addArrangedSubview(icon)
        
      }

      
   

}
