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
    let darkGold = UIColor.rgb(red: 255, green: 0, blue: 0)
    let darkRed = UIColor.rgb(red: 135, green: 0, blue: 0)
    
    
}

class Fonts {
    
    static let shared = Fonts()
    
    let productNameFont = UIFont(name: "HelveticaNeue", size: 15)
    let productNameFontHeight = 18
    
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

    var adsEnabled = true
}


enum GoldSubscription: String {
    case twelveMonths = "TwelveMonths_auto"
    case sixMonths = "SixMonths_auto"
    case oneMonth = "OneMonth_auto"
}

