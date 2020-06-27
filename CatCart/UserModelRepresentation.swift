//
//  UserModelRepresentation.swift
//  CatCart
//
//  Created by denis cedeno on 6/18/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import Foundation

struct UserRepresentation: Codable {
    var password: String
    var userName: String
    var firstName: String?
    var lastName: String?
    var email: String?
    var longitude: Double?
    var latitude: Double?
    var streetAddress: String?
    var city: String?
    var state: String?
    var zipCode: Int16?
}

func == (lhs: UserRepresentation, rhs: User) -> Bool {
    return rhs.password == lhs.password &&
        rhs.userName == lhs.userName &&
        rhs.firstName == lhs.firstName &&
        rhs.lastName == lhs.lastName &&
        rhs.email == lhs.email &&
        rhs.longitude == lhs.longitude &&
        rhs.latitude == lhs.latitude &&
        rhs.streetAddress == lhs.streetAddress &&
        rhs.city == lhs.city &&
        rhs.state == lhs.state &&
        rhs.state == lhs.state &&
        rhs.zipCode == lhs.zipCode
}

func == (lhs: User, rhs: UserRepresentation) -> Bool {
    return rhs == lhs
}

func != (lhs: UserRepresentation, rhs: User) -> Bool {
    return !(lhs == rhs)
}

func != (lhs: User, rhs: UserRepresentation) -> Bool {
    return rhs != lhs
}
