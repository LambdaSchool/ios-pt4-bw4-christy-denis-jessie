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
    // swiftlint:disable line_length
    // swiftlint:disable function_parameter_count
    // swiftlint:disable function_body_length

    private let baseURL = URL(string: "https://catcart-65be0.firebaseio.com/user")!

    var passwordMatch: Bool = false
    var usernameMatch: Bool = false

    var user: User? {
        guard let username = UserDefaults.standard.value(forKey: "LoggedInUser") as? String else { return nil }
        return loadFromPersistentStore(username: username)
    }

    var currentUser: User?

    // MARK: - Register New User
    func signUp(with user: UserRepresentation, completion: @escaping (Error?) -> Void) {

        createUserWithUserNameAndPassword(userName: user.userName, password: user.password)

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

    private func saveToPersistentStore() {
        let moc = CoreDataStack.shared
        do {
            try moc.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }

    func loadFromPersistentStore(username: String) -> User? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userName == %@", username)
        let moc = CoreDataStack.shared.mainContext
        do {
            let user = try moc.fetch(fetchRequest).first
            if let currentUser = user,
                let username = currentUser.userName,
                let password = currentUser.password {
                print(username)
                print(password)
            }
            return user
        } catch {
            print("Error fetching users: \(error)")
            return nil
        }
    }

    func create(userName: String, password: String, firstName: String?, lastName: String?, email: String?, longitude: Double?, latitude: Double?, streetAddress: String?, city: String?, state: String?, zipCode: Int16?) {
        _ = User(userName: userName, password: password, firstName: firstName, lastName: lastName, email: email, longitude: longitude, latitude: latitude, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode)
        saveToPersistentStore()
    }

    func createUserWithUserNameAndPassword(userName: String, password: String) {

        currentUser = User(userName: userName, password: password, firstName: nil, lastName: nil, email: nil, longitude: nil, latitude: nil, streetAddress: nil, city: nil, state: nil, zipCode: nil)

        print("User created with UserName: \(String(describing: currentUser?.userName)) and password: \(String(describing: currentUser?.password))")

        saveToPersistentStore()
    }

    //    func update(user: User, firstName: String?, lastName: String?, email: String?, longitude: Double?, latitude: Double?, streetAddress: String?, city: String?, state: String?, zipCode: Int16?) {
    //
    //        guard let userIndex = users.firstIndex(of: user) else { return }
    //
    //
    //        users[userIndex].firstName = firstName
    //        users[userIndex].lastName = lastName
    //        users[userIndex].email = email
    //        users[userIndex].longitude = longitude ?? 0.0
    //        users[userIndex].latitude = latitude ?? 0.0
    //        users[userIndex].streetAddress = streetAddress
    //        users[userIndex].city = city
    //        users[userIndex].state = state
    //        users[userIndex].zipCode = zipCode ?? 0
    //
    //        print("User: \(users[userIndex])")
    //
    //        saveToPersistentStore()
    //    }
    //
}
