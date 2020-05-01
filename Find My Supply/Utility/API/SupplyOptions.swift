//
//  SupplOptions.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 3/29/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import Foundation


struct supplyOptions {
    static let shared = supplyOptions()
    
    
    func fetchOptions(completion: @escaping(Result<[supplyOption], Error>) -> ()) {
        guard let url = URL(string: "https://find-my-supply-274702.uc.r.appspot.com/getSupplyOptions/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // handle error
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // decode data
            do {
                let options = try JSONDecoder().decode([supplyOption].self, from: data!)
                print("Finished Salt Fetch\n")
                completion(.success(options))
            } catch let error {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
}
