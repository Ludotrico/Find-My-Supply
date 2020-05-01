//
//  Submissions.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 4/11/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import Foundation


class Submissions {
    static let shared = Submissions()
    
    var supply = "nil"
    
    func initialize(withSupply s: String) {
        supply = s
    }
    
    

    //POST
    //addSubmission/<str:supply>/<str:token>
    func addSubmission(completion: @escaping(Result<String, Error>) -> ()) {
        print("===https://find-my-supply-274702.uc.r.appspot.com/addSubmission/\(supply)/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")")
     
        guard let url = URL(string: "https://find-my-supply-274702.uc.r.appspot.com/addSubmission/\(supply)/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")") else { return }
        
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
