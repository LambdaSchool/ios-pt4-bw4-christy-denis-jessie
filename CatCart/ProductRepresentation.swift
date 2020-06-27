//
//  ProductRepresentation.swift
//  CatCart
//
//  Created by Christy Hicks on 6/22/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import Foundation

struct ProductRepresentation: Codable {
    // swiftlint:disable identifier_name

    var id: UUID?
    var name: String?
    var price: Double?
    var type: String?
    var size: String?
    var color: String?
    var imageURL: String?
}

func == (lhs: ProductRepresentation, rhs: Product) -> Bool {
    return rhs.id == lhs.id &&
        rhs.name == lhs.name &&
        rhs.price == lhs.price &&
        rhs.type == lhs.type &&
        rhs.size == lhs.size &&
        rhs.color == lhs.color &&
        rhs.imageURL == lhs.imageURL
}

func == (lhs: Product, rhs: ProductRepresentation) -> Bool {
    return rhs == lhs
}

func != (lhs: ProductRepresentation, rhs: Product) -> Bool {
    return !(lhs == rhs)
}

func != (lhs: Product, rhs: ProductRepresentation) -> Bool {
    return rhs != lhs
}
