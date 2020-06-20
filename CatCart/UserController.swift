//
//  UserController.swift
//  CatCart
//
//  Created by denis cedeno on 6/18/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import Foundation
import UIKit
import CoreData

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class UserController {

    private let baseURL = URL(string: "https://catcart-65be0.firebaseio.com/user")!
    
    var passwordMatch: Bool = false
    var usernameMatch: Bool = false
    
    // MARK: - Register New User
    func signUp(with user: UserRepresentation, completion: @escaping (Error?) -> Void) {
        
        let getUserURL = baseURL
            .appendingPathComponent(user.userName)
            .appendingPathComponent("email")
            .appendingPathExtension("json")
        var getUserRequest = URLRequest(url: getUserURL)
        getUserRequest.httpMethod = HTTPMethod.get.rawValue
        print("\(getUserURL)")
        
        
        URLSession.shared.dataTask(with: getUserRequest) { data, response, error in
            
            if let error = error {
                completion(error)
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            
            guard let data = data else {
                completion(NSError())
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let userName = try decoder.decode(String.self, from: data)
                print("\(userName)")
                if user.userName == userName {
                    print("\(userName) already exists")
                    self.usernameMatch = true
                } else {
                    print("\(user.userName) does not exist")
                    self.usernameMatch = false
                }
            } catch {
                print("Username \(user.userName) does not exist or there was an error docoding username: \(error)")
                
                let registerUserURL = self.baseURL
                    .appendingPathComponent(user.userName)
                    .appendingPathExtension("json")
                
                var request = URLRequest(url: registerUserURL)
                request.httpMethod = HTTPMethod.put.rawValue
                
                do {
                    request.httpBody = try JSONEncoder().encode(user)
                } catch {
                    print("Error encoding user object: \(error)")
                    completion(error)
                    return
                }
                
                URLSession.shared.dataTask(with: request) { _, _, error in
                    if let error = error {
                        completion(error)
                        return
                    }
                    
                    completion(nil)
                }.resume()
                completion(error)
                return
            }
            completion(nil)
        }.resume()
        
        
    }
    
    // MARK: - Log In Existing User
    func signIn(with user: UserRepresentation, completion: @escaping (Error?) -> Void) {
        
        let logInURL = baseURL
            .appendingPathComponent(user.userName)
            .appendingPathComponent("password")
            .appendingPathExtension("json")
        
        var request = URLRequest(url: logInURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(error)
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            
            guard let data = data else {
                completion(NSError())
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let password = try decoder.decode(String.self, from: data)
                print("firebase password: \(password)")
                print("text field password: \(user.password)")
                
                if user.password == password {
                    print("We HAVE a match!!!!!!!!!!!!")
                    self.passwordMatch = true
                } else {
                    print("We DON'T have a match!!!!!!!!!!!!")
                    self.passwordMatch = false
                }
            } catch {
                print("Erorr decoding password object: \(error)")
                completion(error)
                return
            }
            completion(nil)
        } .resume()
    }
}

