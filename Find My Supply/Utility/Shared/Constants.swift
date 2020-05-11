//
//  Constants.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 3/30/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit


class Color {
    static let shared = Color()
    
    
    let brown = UIColor.rgb(red: 167, green: 94, blue: 39)
    let blue = UIColor.rgb(red: 0, green: 122, blue: 225)
    let theme = UIColor.black
    //let tasteyBrown = UIColor.rgb(red: 173, green: 137, blue: 123)
    let lightRed = UIColor.rgb(red: 180, green: 0, blue: 0)
    let gold = UIColor.rgb(red:235, green: 219, blue:0)
    let red = UIColor.rgb(red: 255, green: 70, blue: 56)
    let lightGold = UIColor.rgb(red: 255, green: 236, blue: 117)
    let darkGold = UIColor.rgb(red: 59, green: 55, blue: 0)
    let darkRed = UIColor.rgb(red: 135, green: 0, blue: 0)
    
    
}

class Fonts {
    
    static let shared = Fonts()
    

    let menu = UIFont(name: "BrandonGrotesque-Black", size: 25)!
    let homeButton = UIFont(name: "BrandonGrotesque-Black", size: 20)!
    let homeSupplies = UIFont(name: "BrandonGrotesque-Light", size: 18)!
    
    let popupBtn = UIFont(name: "BrandonGrotesque-Black", size: 20)!
    let slideInMessage = UIFont(name: "BrandonGrotesque-RegularItalic", size: 18)!
    let calloutBtn = UIFont(name: "BrandonGrotesque-Black", size: 120)!
    let callout = UIFont(name: "BrandonGrotesque-Light", size: 32)!
    let calloutBold = UIFont(name: "BrandonGrotesque-Black", size: 32)!
    
    let navigationTitle = UIFont(name: "BrandonGrotesque-Black", size: 35)!
    let storeChainName = UIFont(name: "BrandonGrotesque-Black", size: 25)!
    let storeInfo = UIFont(name: "BrandonGrotesque-Light", size: 18)!
    let storeHours = UIFont(name: "BrandonGrotesque-Light", size: 12)!
    let storeButton = UIFont(name: "BrandonGrotesque-Black", size: 20)!
    
    let tableRowTitle = UIFont(name: "BrandonGrotesque-Black", size: 15)
     let tableRowTitleLarge = UIFont(name: "BrandonGrotesque-Black", size: 25)!
    let tableRowContent = UIFont(name: "BrandonGrotesque-Light", size: 15)!
    let tableRowBtn = UIFont(name: "BrandonGrotesque-Black", size: 15)!
    
    let XLBold = UIFont(name: "BrandonGrotesque-Black", size: 30)!
    let XLLight = UIFont(name: "BrandonGrotesque-Light", size: 30)!
    
    let largeBold = UIFont(name: "BrandonGrotesque-Black", size: 25)!
    let largeLight = UIFont(name: "BrandonGrotesque-Light", size: 20)!
    
    let mediumBold = UIFont(name: "BrandonGrotesque-Black", size: 18)!
    let mediumLight = UIFont(name: "BrandonGrotesque-Light", size: 18)!
    
    let smallBold = UIFont(name: "BrandonGrotesque-Black", size: 14)!
    let smallLight = UIFont(name: "BrandonGrotesque-Light", size: 14)!
}

class System {
    static let shared = System()
    var firstVC = true
}

class Location {
    static let shared = Location()
    
    var coordinates = CLLocationCoordinate2D()
    
    
}


class StatusBarColor {
    static let shared = StatusBarColor()
    
    var isDark = false
}

class Ads {
    static let shared = Ads()
    
    let appID = "ca-app-pub-7180024158512245~7111316337"
    
    
    let tableViewBannerID = "ca-app-pub-7180024158512245/2015736475"
    let interstitialHomeID = "ca-app-pub-7180024158512245/6813234175"
    
    //let bannerTest = "ca-app-pub-3940256099942544/2934735716"
    //let interstitialTest = "ca-app-pub-3940256099942544/4411468910"
    

    var adsEnabled = true
}


enum GoldSubscription: String {
    case twelveMonths = "TwelveMonths_auto"
    case sixMonths = "SixMonths_auto"
    case oneMonth = "OneMonth_auto"
}


struct Random {
    static let shared = Random()
    
    let goldPopup = 11
    let adPopup = 5
    let tableRowStart = 5
    let tableRowEnd = 9
    
    var showedGoldPopup = false
    var showedAdPopup = false
    
}
