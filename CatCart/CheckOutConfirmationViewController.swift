//
//  CheckOutConfirmationViewController.swift
//  CatCart
//
//  Created by denis cedeno on 6/26/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import UIKit

class CheckOutConfirmationViewController: UIViewController {

    
    var currentUser: User?
    var currentUserCreditCard: CreditCard?
    var currentUserShippingAddress: ShippingAdress?
    var cartController = ShoppingCartController.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if currentUser == currentUser {
        print("First Name: \(String(describing: currentUser?.firstName)), CVV Code: \(String(describing: currentUserCreditCard?.creditCardCVV)), Shipping Address: \(String(describing: currentUserShippingAddress?.shippingAddress)), number of items: \(String(describing: cartController.itemNames.count))")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
