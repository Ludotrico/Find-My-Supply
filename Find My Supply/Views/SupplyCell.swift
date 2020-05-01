//
//  SupplyCell.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 3/29/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import UIKit

class supplyCell: UITableViewCell {

    
    
    let supply: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.layer.cornerRadius = 10
        label.adjustsFontSizeToFitWidth = true
        label.clipsToBounds = true
        label.sizeToFit()
        label.backgroundColor = .clear
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .blue
        
        addSubview(supply)
        supply.translatesAutoresizingMaskIntoConstraints = false
        supply.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        supply.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        backgroundColor = Color.shared.gold
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


public class TableView: UITableView
{
    override public func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }

    override public var intrinsicContentSize: CGSize {
        return contentSize
    }
}
