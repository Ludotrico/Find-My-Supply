//
//  Stores.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 3/29/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import Foundation
import MapKit

struct Stores {
    static var shared = Stores()
    
    var supply = "nil"
    var coordinates =  CLLocationCoordinate2D.init(latitude: 0, longitude: 0)
    var radius = 20
    var storeID = -1
    var SKU = -1
    
    mutating func initialize(withSupply s: String, withCoor coor: CLLocationCoordinate2D) {
        supply = s
        coordinates =  coor
        radius = UserDefaults.standard.integer(forKey: "radius")
    }
    
    
    //https://find-my-supply-274702.uc.r.appspot.com/getStoresWithSupply/<str:supply>/<int:radius><str:metric>/<latitude>/<longitude>/<str:token>
    func fetchStoresWithSupply(completion: @escaping(Result<[store], Error>) -> ()) {
        
        print("https://find-my-supply-274702.uc.r.appspot.com/getStoresWithSupply/\(supply)/\(UserDefaults.standard.integer(forKey: "radius"))mi/\(coordinates.latitude)/\(coordinates.longitude)/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")")
        print("Entering FSWS")
        guard let url = URL(string: "https://find-my-supply-274702.uc.r.appspot.com/getStoresWithSupply/\(supply)/\(radius)mi/\(coordinates.latitude)/\(coordinates.longitude)/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // handle error
            if let error = error {
                print("Exiting FSWS with ERROR")
                completion(.failure(error))
                return
            }
            
            // decode data
            do {
                let stores = try JSONDecoder().decode([store].self, from: data!)
                print("Finished FSWS\n")
                //print(stores[0].store__latitude)
                completion(.success(stores))
            } catch let error {
                completion(.failure(error))
            }
            
        }.resume()
    }
    //https://find-my-supply-274702.uc.r.appspot.com/getTotalQuantityOf/Toilet_Paper/7/86d2a2f7970bf859fdac7b2c99712485e59deaa7b57eea64e8702504f87c9757
    func fetchTotalQuantity(completion: @escaping(Result<Int, Error>) -> ()) {
        
        print("https://find-my-supply-274702.uc.r.appspot.com/getTotalQuantityOf/\(supply)/\(storeID)/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")")

        guard let url = URL(string: "https://find-my-supply-274702.uc.r.appspot.com/getTotalQuantityOf/\(supply)/\(storeID)/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // handle error
            if let error = error {
                print("Exiting FSWS with ERROR")
                completion(.failure(error))
                return
            }
            
            // decode data
            do {
                let quantity = try JSONDecoder().decode(storeQuantity.self, from: data!)
                completion(.success(quantity.totalQuantity))
            } catch let error {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    
    //https://find-my-supply-274702.uc.r.appspot.com/getNearbyStores/<int:sku>/<int:radius><str:metric>/<latitude>/<longitude>/<int:storeID>/86d2a2f7970bf859fdac7b2c99712485e59deaa7b57eea64e8702504f87c9757
    
    func fetchNearbyStores(completion: @escaping(Result<[nearbyStore], Error>) -> ()) {
        
        print("https://find-my-supply-274702.uc.r.appspot.com/getNearbyStores/\(SKU)/\(UserDefaults.standard.integer(forKey: "radius"))mi/\(coordinates.latitude)/\(coordinates.longitude)/\(storeID)/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")")

        guard let url = URL(string: "https://find-my-supply-274702.uc.r.appspot.com/getNearbyStores/\(SKU)/\(UserDefaults.standard.integer(forKey: "radius"))mi/\(coordinates.latitude)/\(coordinates.longitude)/\(storeID)/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // handle error
            if let error = error {
                print("Exiting FNS with ERROR")
                completion(.failure(error))
                return
            }
            
            // decode data
            do {
                let stores = try JSONDecoder().decode([nearbyStore].self, from: data!)
                completion(.success(stores))
            } catch let error {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    
    
}
