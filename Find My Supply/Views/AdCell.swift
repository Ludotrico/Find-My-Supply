//
//  AdCell.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 4/19/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import UIKit
import GoogleMobileAds
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
    
    

    
    func configureViewComponents() {

        addSubview(bannerAd)
        bannerAd.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
  
        
        
    }
}
