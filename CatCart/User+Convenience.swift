//
//  User+Convenience.swift
//  CatCart
//
//  Created by denis cedeno on 6/23/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import Foundation
import CoreData

extension User {

    @discardableResult convenience init(
        userName: String,
        password: String,
        firstName: String?,
        lastName: String?,
        email: String?,
        longitude: Double?,
        latitude: Double?,
        streetAddress: String?,
        city: String?,
        state: String?,
        zipCode: Int16?,
        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {

        self.init(context: context)
        self.userName = userName
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.longitude = longitude ?? 0.0
        self.latitude = latitude ?? 0.0
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zipCode = zipCode ?? 0
    }

   @discardableResult convenience init?(userRepresentation: UserRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {

        let userName = userRepresentation.userName
        let password = userRepresentation.password

        guard let firstName = userRepresentation.firstName,
            let lastName = userRepresentation.lastName,
            let email = userRepresentation.email,
            let longitude = userRepresentation.longitude,
            let latitude = userRepresentation.latitude,
            let streetAddress = userRepresentation.streetAddress,
            let city = userRepresentation.city,
            let state = userRepresentation.state,
            let zipCode = userRepresentation.zipCode else {return nil}

        self.init(userName: userName,
                  password: password,
                  firstName: firstName,
                  lastName: lastName,
                  email: email,
                  longitude: longitude,
                  latitude: latitude,
                  streetAddress: streetAddress,
                  city: city,
                  state: state,
                  zipCode: zipCode)
    }
}
