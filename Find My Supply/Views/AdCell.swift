//
//  AdCell.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 4/19/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import UIKit
import GoogleMobileAds
import EzPopup
//APP ID: ca-app-pub-7180024158512245~7111316337
//AD UNIT ID: ca-app-pub-7180024158512245/2015736475

class AdCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        
        selectionStyle = .none
        configureViewComponents()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    var bannerAd: GADBannerView = {
        let ad = GADBannerView()
        ad.adUnitID = "ca-app-pub-3940256099942544/2934735716" //Ads.shared.tableViewBannerID
        
        return ad
    }()
    
    let cancelBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "whiteX").withRenderingMode(.alwaysOriginal), for: .normal)
        

        //button.addTarget(self, action: #selector(showPopup), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    

    
    

    
    func configureViewComponents() {

        addSubview(bannerAd)
        bannerAd.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
  
        
        addSubview(cancelBtn)
        cancelBtn.anchor(top: bannerAd.topAnchor, left: nil, bottom: nil, right: bannerAd.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 15, height: 15)
        
        
    }
}
