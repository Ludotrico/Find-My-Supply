//
//  AddNotification.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 4/7/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import Foundation


struct Notifications {
    static var shared = Notifications()
    
    var SKU = -1
    var storeID = -1
    var supply = "nil"
    var city = "nil"
    var date = "nil"
    var productID = -1
    var radius = -1
    
    mutating func initialize(withSKU sku: Int, withStoreID id: Int) {
        SKU = sku
        storeID = id
    }
    
    
    //POST
    //addSKUStoreNotification/<int:userID>/<int:sku>/<int:storeID>/<str:token>
    func addSKUStoreNotification(completion: @escaping(Result<String, Error>) -> ()) {
        print("===https://find-my-supply-274702.uc.r.appspot.com/addSKUStoreNotification/\(UserDefaults.standard.string(forKey: "userID")!)/\(SKU)/\(storeID)/\(date)/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")")
     
        guard let url = URL(string: "https://find-my-supply-274702.uc.r.appspot.com/addSKUStoreNotification/\(UserDefaults.standard.string(forKey: "userID")!)/\(SKU)/\(storeID)/\(date)/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // handle error
            if let error = error {
                completion(.failure(error))
                print("Finished RTS with Error\n")
                return
            }
            
            // decode data
            do {
                let message = try JSONDecoder().decode(Message.self, from: data!)
                print("Finished RTS\n")
                completion(.success(message.message))
            } catch let error {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    
    //POST
    //addSKURegionNotification/<int:userID>/<int:sku>/<int:radius><str:metric>/<latitude>/<longitude>/<str:token>
    func addSKURegionNotification(completion: @escaping(Result<String, Error>) -> ()) {
        print("===https://find-my-supply-274702.uc.r.appspot.com/addSKURegionNotification/\(UserDefaults.standard.string(forKey: "userID")!)/\(SKU)/\(UserDefaults.standard.integer(forKey: "radius"))mi/\(city)/\(Location.shared.coordinates.latitude)/\(Location.shared.coordinates.longitude)/\(date)/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")")
     
        guard let url = URL(string: "https://find-my-supply-274702.uc.r.appspot.com/addSKURegionNotification/\(UserDefaults.standard.string(forKey: "userID")!)/\(SKU)/\(UserDefaults.standard.integer(forKey: "radius"))mi/\(city)/\(Location.shared.coordinates.latitude)/\(Location.shared.coordinates.longitude)/\(date)/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // handle error
            if let error = error {
                completion(.failure(error))
                print("Finished RTS with Error\n")
                return
            }
            
            // decode data
            do {
                let message = try JSONDecoder().decode(Message.self, from: data!)
                print("Finished RTS\n")
                completion(.success(message.message))
            } catch let error {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    
    //POST
    //addSKURegionNotification/<int:userID>/<int:sku>/<int:radius><str:metric>/<latitude>/<longitude>/<str:token>
    func addSupplyRegionNotification(completion: @escaping(Result<String, Error>) -> ()) {
        print("===https://find-my-supply-274702.uc.r.appspot.com/addSupplyRegionNotification/\(UserDefaults.standard.string(forKey: "userID")!)/\(supply)/\(UserDefaults.standard.integer(forKey: "radius"))mi/\(city)/\(Location.shared.coordinates.latitude)/\(Location.shared.coordinates.longitude)/\(date)/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")")
     
        guard let url = URL(string: "https://find-my-supply-274702.uc.r.appspot.com/addSupplyRegionNotification/\(UserDefaults.standard.string(forKey: "userID")!)/\(supply)/\(UserDefaults.standard.integer(forKey: "radius"))mi/\(city)/\(Location.shared.coordinates.latitude)/\(Location.shared.coordinates.longitude)/\(date)/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // handle error
            if let error = error {
                completion(.failure(error))
                print("Finished RTS with Error\n")
                return
            }
            
            // decode data
            do {
                let message = try JSONDecoder().decode(Message.self, from: data!)
                print("Finished RTS\n")
                completion(.success(message.message))
            } catch let error {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    
    //https://find-my-supply-274702.uc.r.appspot.com/getNotifications/<int:userID>/<str:token>
    func getAreaNotifications(completion: @escaping(Result<[notification], Error>) -> ()) {
        
        print("===https://find-my-supply-274702.uc.r.appspot.com/getAreaNotifications/\(UserDefaults.standard.string(forKey: "userID")!)/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")")
        print("===Entering get Notifs")
        guard let url = URL(string: "https://find-my-supply-274702.uc.r.appspot.com/getAreaNotifications/\(UserDefaults.standard.string(forKey: "userID")!)/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // handle error
            if let error = error {
                print("===Exiting FP with ERROR")
                completion(.failure(error))
                return
            }
            
            // decode data
            do {
                let notifications = try JSONDecoder().decode([notification].self, from: data!)
                //print("===Name: \(products[0].name)")
                completion(.success(notifications))
            } catch let error {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    //https://find-my-supply-274702.uc.r.appspot.com/getNotifications/<int:userID>/<str:token>
    func getStoreNotifications(completion: @escaping(Result<[notification], Error>) -> ()) {
        
        print("===https://find-my-supply-274702.uc.r.appspot.com/getStoreNotifications/\(UserDefaults.standard.string(forKey: "userID")!)/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")")
        print("===Entering get Notifs")
        guard let url = URL(string: "https://find-my-supply-274702.uc.r.appspot.com/getStoreNotifications/\(UserDefaults.standard.string(forKey: "userID")!)/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // handle error
            if let error = error {
                print("===Exiting FP with ERROR")
                completion(.failure(error))
                return
            }
            
            // decode data
            do {
                let notifications = try JSONDecoder().decode([notification].self, from: data!)
                //print("===Name: \(products[0].name)")
                completion(.success(notifications))
            } catch let error {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    //POST
    //deleteSupplyRegionNotification/<int:userID>/<str:supply>/<int:radius>/<str:city>/<str:date>/<str:token>
    func deleteSupplyRegionNotification(completion: @escaping(Result<String, Error>) -> ()) {
        print("===https://find-my-supply-274702.uc.r.appspot.com/deleteSupplyRegionNotification/\(UserDefaults.standard.string(forKey: "userID")!)/\(supply)/\(radius)/\(city)/\(date)/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")")
     
        guard let url = URL(string: "https://find-my-supply-274702.uc.r.appspot.com/deleteSupplyRegionNotification/\(UserDefaults.standard.string(forKey: "userID")!)/\(supply)/\(radius)/\(city)/\(date)/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // handle error
            if let error = error {
                completion(.failure(error))
                print("Finished RTS with Error\n")
                return
            }
            
            completion(.success("Success"))
            
        }.resume()
    }
    
    //POST
    //deleteSKUStoreNotification/<int:userID>/<int:productID>/<int:storeID>/<str:date>/<str:token>
    func deleteSKUStoreNotification(completion: @escaping(Result<String, Error>) -> ()) {
        print("===https://find-my-supply-274702.uc.r.appspot.com/deleteSKUStoreNotification/\(UserDefaults.standard.string(forKey: "userID")!)/\(productID)/\(storeID)/\(date)/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")")
     
        guard let url = URL(string: "https://find-my-supply-274702.uc.r.appspot.com/deleteSKUStoreNotification/\(UserDefaults.standard.string(forKey: "userID")!)/\(productID)/\(storeID)/\(date)/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // handle error
            if let error = error {
                completion(.failure(error))
                print("Finished RTS with Error\n")
                return
            }
            
            completion(.success("Success"))
            
        }.resume()
    }
    
    //POST
    //deleteSKURegionNotification/<int:userID>/<int:productID>/<int:radius>/<str:city>/<str:date>/<str:token>
    func deleteSKURegionNotification(completion: @escaping(Result<String, Error>) -> ()) {
        print("===https://find-my-supply-274702.uc.r.appspot.com/deleteSKURegionNotification/\(UserDefaults.standard.string(forKey: "userID")!)/\(productID)/\(radius)/\(city)/\(date)/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")")
     
        guard let url = URL(string: "https://find-my-supply-274702.uc.r.appspot.com/deleteSKURegionNotification/\(UserDefaults.standard.string(forKey: "userID")!)/\(productID)/\(radius)/\(city)/\(date)/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // handle error
            if let error = error {
                completion(.failure(error))
                print("Finished RTS with Error\n")
                return
            }
            
            completion(.success("Success"))
            
        }.resume()
    }
    


    
}

