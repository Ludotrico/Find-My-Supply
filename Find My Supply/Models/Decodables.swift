//
//  Backend.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 3/28/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import Foundation

struct Salt: Decodable {
    var salt: String
}

struct Message: Decodable {
    var message: String
}

struct Verified: Decodable {
    var isVerified: Bool
}

struct UserInfo: Decodable {
    var message: String
    var ID: Int
    var fName: String
    var email: String
    var username: String
    var salt: String
    var password: String
    var identifiedByEmail: Bool
    var zip: Int
}

struct supplyOption: Decodable {
    
    var supplyName: String
}


struct store: Decodable {
    var store__id: Int
    var store__address: String
    var store__chainName: String
    var store__latitude: Double
    var store__longitude: Double
    var store__rating: Float
    var store__storeImage: String
    var store__weekdayText: [String]
    var store__openingHours: [String]
    var store__googlePlaceID: String
    
    
    init() {
        store__id = -1
        store__address = ""
        store__chainName = ""
        store__latitude = -1
        store__longitude = -1
        store__rating = -1
        store__storeImage = ""
        store__weekdayText = [""]
        store__openingHours = [""]
        store__googlePlaceID = ""
        
        
    }
    
    
}

struct storeQuantity: Decodable {
    var totalQuantity: Int
}

struct product: Decodable  {
    var SKU: Int
    var name: String
    var quantity: String
    var minQuantity: Int
    var price: Float
    var clearance: Int
    var inStock: Bool
    var imageLink: String
    var affiliates__affiliateStore: String?
    var affiliates__affiliatePrice: Float?
    var affiliates__affiliateLink: String?
    
    init() {
        SKU = -1
        name = ""
        quantity = ""
        minQuantity = -1
        price = -1
        clearance = -1
        inStock = false
        imageLink = ""
        affiliates__affiliateLink = ""
        affiliates__affiliatePrice = -1
        affiliates__affiliateStore = ""
    }
    
}

struct nearbyStore: Decodable {
    //"store__id", 'store__chainName', 'store__address', "store__latitude", "store__longitude", "price", "quantity", 'minQuantity', 'clearance', "store__rating", "store__storeImage", "store__weekdayText", "store__openingHours"
    var store__id: Int
    var store__chainName: String
    var store__address: String
    var store__latitude: Double
    var store__longitude: Double
    var price: Float
    var quantity: String
    var minQuantity: Int
    var clearance: Int
    var store__rating: Float
    var store__storeImage: String
    var store__weekdayText: [String]
    var store__openingHours: [String]
    var store__googlePlaceID: String
    
    func convertToStore() -> store {
        var s = store()
        s.store__id = store__id
        s.store__address = store__address
        s.store__chainName = store__chainName
        s.store__latitude = store__latitude
        s.store__longitude = store__longitude
        s.store__rating = store__rating
        s.store__storeImage = store__storeImage
        s.store__weekdayText = store__weekdayText
        s.store__openingHours = store__openingHours
        s.store__googlePlaceID = store__googlePlaceID
        return s
    }
    

}

struct notification: Decodable {
    var radius: Int?
    var city: String?
    var store__id: Int?
    var store__chainName: String?
    var store__address: String?
    var supplyName: String?
    var product__id: Int?
    var product__name: String?
    var product__imageLink: String?
    var date: String?
    
}







