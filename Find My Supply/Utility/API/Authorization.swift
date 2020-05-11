//
//  BackendCommunication.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 3/28/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import Foundation
import CryptoSwift

class UserAuth{
    //registerUser/<str:fname>/<str:email>/<str:username>/<str:salt>/<str:psw>
    static let shared = UserAuth()
    var fName = ""
    var email = ""
    var username = ""
    var salt = ""
    var password = ""
    var message = "alsdkfjalskdfjslk"
    var login = ""
    var zipcode = ""

    
    public func initRegisterUser(withName name: String,  withEmail eml: String, withUsername usr: String, withPassword psw: String, withZip zip: String) {
        fName = name
        email = eml
        username = usr
        password = psw
        zipcode = zip
    }
    
    public func initLoginUser(withLogin l: String, withPassword psw: String) {
        login = l
        password = psw
    }
    
    func fetchNewSalt(completion: @escaping(Result<String, Error>) -> ()) {
        //print("+++Entered Salt Fetch\n")

        guard let url = URL(string: "https://find-my-supply-274702.uc.r.appspot.com/getSalt") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // handle error
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // decode data
            do {
                let salt = try JSONDecoder().decode(Salt.self, from: data!)
                //print("Finished Salt Fetch\n")
                completion(.success(salt.salt))
            } catch let error {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    //POST
    func registerToServer(completion: @escaping(Result<String, Error>) -> ()) {
        //print("Entered RTS with Salt: \(salt)\n")
        //print("UserAuth Password: \(password)\nUserAuth salt: \(salt)\n")
        //print("UserAuth Hashed password: \((password+salt).sha256())\n")
        let base_url = "https://find-my-supply-274702.uc.r.appspot.com/registerUser/\(fName)/\(email)/\(username)/\(salt)/\((password+salt).sha256())/\(zipcode)"
        //print("+ + +" + base_url)
        guard let url = URL(string: base_url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // handle error
            if let error = error {
                completion(.failure(error))
                //print("Finished RTS with Error\n")
                return
            }
            
            // decode data
            do {
                let login = try JSONDecoder().decode(Message.self, from: data!)
                //print("Finished RTS\n")
                completion(.success(login.message))
            } catch let error {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    func fetchUserInfo(completion: @escaping(Result<UserInfo, Error>) -> ()) {
        //print("Entered User Info Fetch\n")
        
        //print("===+ \("https://find-my-supply-274702.uc.r.appspot.com/getUserInfo/\(login)")")
        guard let url = URL(string: "https://find-my-supply-274702.uc.r.appspot.com/getUserInfo/\(login)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // handle error
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // decode data
            do {
                let user = try JSONDecoder().decode(UserInfo.self, from: data!)
                //print("===+Finished User Info Fetch\n")
                completion(.success(user))
            } catch let error {
                completion(.failure(error))
                //print("===+Crashed User Info Fetch\n")
            }
            
        }.resume()
    }
    
    
    //POST
    func loginToServer(completion: @escaping(Result<String, Error>) -> ()) {
        ////print("Entered RTS with Salt: \(salt)\n")
        ////print("UserAuth Password: \(password)\nUserAuth salt: \(salt)\n")
        ////print("UserAuth Hashed password: \((password+salt).sha256())\n")
        let base_url = "https://find-my-supply-274702.uc.r.appspot.com/loginUser/\(UserDefaults.standard.string(forKey: "userID") ?? "nil")/\(UserDefaults.standard.string(forKey: "password") ?? "nil")/\(Location.shared.coordinates.latitude)/\(Location.shared.coordinates.longitude)/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")"
        
        //print(base_url)
        guard let url = URL(string: base_url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // handle error
            if let error = error {
                completion(.failure(error))
                ////print("Finished RTS with Error\n")
                return
            }
            
            // decode data
            do {
                let login = try JSONDecoder().decode(Message.self, from: data!)
                //print("===+Finished LTS\n")
                completion(.success(login.message))
            } catch let error {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    

    
    
    //'isUserVerified/<int:userID>/<str:token>'
    func checkIfVerified(completion: @escaping(Result<Bool, Error>) -> ()) {
        let base_url = "https://find-my-supply-274702.uc.r.appspot.com/isUserVerified/\(UserDefaults.standard.string(forKey: "userID") ?? "nil")/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")"
        //print("+ + +" + base_url)
        guard let url = URL(string: base_url) else { return }


        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // handle error
            if let error = error {
                completion(.failure(error))
                //print("Finished RTS with Error\n")
                return
            }
            
            // decode data
            do {
                let response = try JSONDecoder().decode(Verified.self, from: data!)
                //print("Finished RTS\n")
                completion(.success(response.isVerified))
            } catch let error {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    //sendVerificationEmail/<int:userID>/<str:token>
    func sendVerificationEmail(completion: @escaping(Result<Bool, Error>) -> ()) {
        let base_url = "https://find-my-supply-274702.uc.r.appspot.com/sendVerificationEmail/\(UserDefaults.standard.string(forKey: "userID") ?? "nil")/\(UserDefaults.standard.string(forKey: "salt") ?? "nil")"
        //print("+ + +" + base_url)
        guard let url = URL(string: base_url) else { return }


        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // handle error
            if let error = error {
                completion(.failure(error))
                //print("Finished RTS with Error\n")
                return
            }
            

            completion(.success(true))
    
            
        }.resume()
    }
    
    //sendResetPasswordEmail/<str:login>
    func sendResetPasswordEmail(completion: @escaping(Result<String, Error>) -> ()) {
        let base_url = "https://find-my-supply-274702.uc.r.appspot.com/sendResetPasswordEmail/\(login)"
        //print("+ + +" + base_url)
        guard let url = URL(string: base_url) else { return }


        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // handle error
            if let error = error {
                completion(.failure(error))
                //print("Finished RTS with Error\n")
                return
            }
            

            // decode data
            do {
                let response = try JSONDecoder().decode(Message.self, from: data!)
                //print("Finished RTS\n")
                completion(.success(response.message))
            } catch let error {
                completion(.failure(error))
            }

            
        }.resume()
    }

    //canUserChangePassword/<str:login>
    func checkIfForgotPassword(completion: @escaping(Result<Bool, Error>) -> ()) {
        let base_url = "https://find-my-supply-274702.uc.r.appspot.com/canUserChangePassword/\(UserDefaults.standard.string(forKey: "login")!)"
        //print("+ + +" + base_url)
        guard let url = URL(string: base_url) else { return }


        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // handle error
            if let error = error {
                completion(.failure(error))
                //print("Finished RTS with Error\n")
                return
            }
            
            // decode data
            do {
                let response = try JSONDecoder().decode(Verified.self, from: data!)
                //print("Finished RTS\n")
                completion(.success(response.isVerified))
            } catch let error {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    
    
    
    
    
}
