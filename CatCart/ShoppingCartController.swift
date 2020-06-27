//
//  ShoppingCartController.swift
//  CatCart
//
//  Created by Jessie Ann Griffin on 6/24/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import Foundation
import UIKit

class ShoppingCartController {

    var cat: Cat?
    var product: Product?

    var itemNames: [String] = []
    var itemPrices: [Double] = []
    var itemImages: [UIImage] = []

    var userController: UserController?
    var currentUser: User?

    func addItem(itemName: String, itemPrice: Double) {
        itemNames.append(itemName)
        itemPrices.append(itemPrice)
    }

    func updateCart() { // POST

    }

    func deleteFromCart() { // DELETE

    }
}
