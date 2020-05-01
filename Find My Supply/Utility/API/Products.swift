//
//  Products.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 4/3/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import Foundation

struct Products {
    static var shared = Products()
    
    var supply = "nil"
    var storeID = -1
    
    mutating func initialize(withSupply s: String, withStoreID id: Int) {
        supply = s
        storeID = id
    }
    
    
    //https://find-my-supply-274702.uc.r.appspot.com/getProductsInStore/Toilet_Paper/7/86d2a2f7970bf859fdac7b2c99712485e59deaa7b57eea64e8702504f87c9757
    func fetchProducts(completion: @escaping(Result<[product], Error>) -> ()) {
        
        print("===https://find-my-supply-274702.uc.r.appspot.com/getProductsInStore/\(supply)/\(storeID)/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")")
        print("===Entering Fetch products")
        guard let url = URL(string: "https://find-my-supply-274702.uc.r.appspot.com/getProductsInStore/\(supply)/\(storeID)/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // handle error
            if let error = error {
                print("===Exiting FP with ERROR")
                completion(.failure(error))
                return
            }
            
            // decode data
            do {
                let products = try JSONDecoder().decode([product].self, from: data!)
                print("===Finished FP\n")
                //print("===Name: \(products[0].name)")
                completion(.success(products))
            } catch let error {
                completion(.failure(error))
            }
            
        }.resume()
    }

    
}
