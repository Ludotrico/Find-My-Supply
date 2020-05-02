//
//  UpdateUser.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 4/9/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import Foundation


class UpdateUser {
    static let shared = UpdateUser()
    
    var fName = "_"
    var email = "_"
    var username = "_"
    var newPassword = "_"
    var salt = "_"
    var zip = -1
    var type = "_"

    
    func initialize(withFname n: String, withEmail e: String, withUsername u: String) {
        fName = n
        email = e
        username = u
    }
    
    
    //POST
    //updateUserProfile/<str:oldUsername>/<str:fName>/<str:usrname>/<str:email>/<str:token>
    func update(completion: @escaping(Result<String, Error>) -> ()) {
        print("===https://find-my-supply-274702.uc.r.appspot.com/updateUserProfile/\(UserDefaults.standard.string(forKey: "username")!)/\(fName)/\(username)/\(email)/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")")
     
        guard let url = URL(string: "https://find-my-supply-274702.uc.r.appspot.com/updateUserProfile/\(UserDefaults.standard.string(forKey: "username")!)/\(fName)/\(username)/\(email)/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")") else { return }
        
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
    //changePassword/<str:login>/<str:salt>/<str:newPsw>/<str:type>
    func changePassword(completion: @escaping(Result<String, Error>) -> ()) {
        print("===https://find-my-supply-274702.uc.r.appspot.com/changePassword/\(UserDefaults.standard.string(forKey: "username") ?? UserDefaults.standard.string(forKey: "login")!)/\(salt)/\((newPassword+salt).sha256())/\(type)")
     
        guard let url = URL(string: "https://find-my-supply-274702.uc.r.appspot.com/changePassword/\(UserDefaults.standard.string(forKey: "username") ?? UserDefaults.standard.string(forKey: "login")!)/\(salt)/\((newPassword+salt).sha256())/\(type)") else { return }
        
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
    //'updateUserZip/<str:username>/<int:zip>/<str:token>'
    func updateUserZip(completion: @escaping(Result<String, Error>) -> ()) {
        print("===https://find-my-supply-274702.uc.r.appspot.com/updateUserZip/\(UserDefaults.standard.string(forKey: "username")!)/\(zip)/\(UserDefaults.standard.string(forKey: "salt")!)")
     
        guard let url = URL(string: "https://find-my-supply-274702.uc.r.appspot.com/updateUserZip/\(UserDefaults.standard.string(forKey: "username")!)/\(zip)/\(UserDefaults.standard.string(forKey: "salt")!)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // handle error
            if let error = error {
                completion(.failure(error))
                print("Finished RTS with Error\n")
                return
            }
            
            do {
                let message = try JSONDecoder().decode(Message.self, from: data!)
                print("Finished RTS\n")
                completion(.success(message.message))
            } catch let error {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    
}
