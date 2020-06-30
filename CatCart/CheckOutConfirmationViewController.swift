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

    @IBOutlet weak var itemCountLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var streetAddress: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var zipCodeLabel: UILabel!
    @IBOutlet weak var cardEndingInLabel: UILabel!
    @IBAction func placeOrderButton(_ sender: Any) {

        DispatchQueue.main.async {
            let alertController = UIAlertController(
                title: "Thank You!!",
                message: "Your Order has been placed",
                preferredStyle: .alert)
            let alertAction = UIAlertAction(
                title: "OK",
                style: UIAlertAction.Style.default,
                handler: { _ in
                    self.navigationController?.popToRootViewController(animated: true)
            })
            alertController.addAction(alertAction)
            self.present(alertController, animated: true)
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current

        updateViews(formatter: currencyFormatter)
    }

    func updateViews(formatter: NumberFormatter) {

        var subtotal = 0.0
        for price in cartController.itemPrices {
            subtotal += price
        }
        if let total = formatter.string(from: NSNumber(value: subtotal)) {
            totalLabel.text = "\(total)"
        }

        itemCountLabel.text = "\(cartController.itemNames.count)"

        if currentUser == currentUser {
            firstNameLabel.text = currentUser?.firstName
            lastNameLabel.text = currentUser?.lastName
        }

        streetAddress.text = currentUserShippingAddress?.shippingAddress
        cityLabel.text = currentUserShippingAddress?.shippingCity
        stateLabel.text = currentUserShippingAddress?.shippingState

        zipCodeLabel.text = "\(currentUserShippingAddress?.shippingZip ?? 0)"

        let ccNumber = "\(String(describing: currentUserCreditCard?.creditCardNumber ?? 1111))"
        let last4 = ccNumber.suffix(4)

        cardEndingInLabel.text = String(last4)

    }
}
