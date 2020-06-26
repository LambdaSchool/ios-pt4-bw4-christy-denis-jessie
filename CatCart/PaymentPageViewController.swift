//
//  PaymentPageViewController.swift
//  CatCart
//
//  Created by Jessie Ann Griffin on 6/22/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import UIKit

struct CreditCard {
    let creditCardNumber: Int
    let creditCardEXP: Int // convert to date
    let creditCardCVV: Int
}

struct ShippingAdress {
    let shippingAddress: String
    let shippingCity: String
    let shippingState: String
    let shippingZip: Int
}

class PaymentPageViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var billingAddressTextField: UITextField!
    @IBOutlet weak var billingCityTextField: UITextField!
    @IBOutlet weak var billingStateTextField: UITextField!
    @IBOutlet weak var billingZipCodeTextField: UITextField!
    
    @IBOutlet weak var shippingAddressTextFeild: UITextField!
    @IBOutlet weak var shippingCityTextField: UITextField!
    @IBOutlet weak var shippingStateTextField: UITextField!
    @IBOutlet weak var shippingZipCodeTextField: UITextField!
    
    @IBOutlet weak var creditCardNumberTextField: UITextField!
    @IBOutlet weak var expDateTextField: UITextField!
    @IBOutlet weak var cVVCodeTextField: UITextField!
    
    @IBOutlet weak var checkOutButton: UIButton!
    
    var currentUser: User?
    var currentUserCreditCard: CreditCard?
    var currentUserShippingAddress: ShippingAdress?
    
    @IBAction func isShippingTheSameAsBillingSwitch(_ sender: UISwitch) {
        
        if (sender.isOn == true) {
            if billingAddressTextField.text == "" || billingCityTextField.text == "" ||
                billingStateTextField.text == "" ||  billingZipCodeTextField.text == "" {
                DispatchQueue.main.async {
                    let alertController = UIAlertController(
                        title: "Billing Address needed",
                        message: "Please fill required Billing address fields.",
                        preferredStyle: .alert)
                    let alertAction = UIAlertAction(
                        title: "OK",
                        style: UIAlertAction.Style.default,
                        handler: nil)
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true)
                    sender.isOn = false
                    
                    self.shippingAddressTextFeild.text = ""
                    self.shippingCityTextField.text = ""
                    self.shippingStateTextField.text = ""
                    self.shippingZipCodeTextField.text = ""
                }
            }
            
            shippingAddressTextFeild.text = billingAddressTextField.text
            shippingCityTextField.text = billingCityTextField.text
            shippingStateTextField.text = billingStateTextField.text
            shippingZipCodeTextField.text = billingZipCodeTextField.text
            
        } else if (sender.isOn == false) {
            shippingAddressTextFeild.text = ""
            shippingCityTextField.text = ""
            shippingStateTextField.text = ""
            shippingZipCodeTextField.text = ""
        }
    }
    
    
    @IBAction func checkOutButtonTapped(_ sender: UIButton) {
        
        if  (firstNameTextField.text == "" ||
            lastNameTextField.text == "" ||
            emailTextField.text == "" ||
            billingAddressTextField.text == "" ||
            billingCityTextField.text == "" ||
            billingStateTextField.text == "" ||
            billingZipCodeTextField.text == "" ||
            shippingAddressTextFeild.text == "" ||
            shippingCityTextField.text == "" ||
            shippingStateTextField.text == "" ||
            shippingZipCodeTextField.text == "" ||
            creditCardNumberTextField.text == "" ||
            expDateTextField.text == "" ||
            cVVCodeTextField.text == "" ) {
            
            DispatchQueue.main.async {
                let alertController = UIAlertController(
                    title: "Missing Information",
                    message: "Please fill all fields.",
                    preferredStyle: .alert)
                let alertAction = UIAlertAction(
                    title: "OK",
                    style: UIAlertAction.Style.default,
                    handler: nil)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true)
            }
        } else {
            
            let firstName = firstNameTextField.text
            let lastName = lastNameTextField.text
            let email = emailTextField.text
            let address = billingAddressTextField.text
            let city = billingCityTextField.text
            let state = billingStateTextField.text
            let zipCode = Int16(billingZipCodeTextField.text ?? "0")
            
            let shippingAddress = shippingAddressTextFeild.text
            let shippingCity = shippingCityTextField.text
            let shippingState = shippingStateTextField.text
            let shippingZip = Int(shippingZipCodeTextField.text ?? "0")
            
            let creditCardNumber = Int(creditCardNumberTextField.text ?? "0")
            let creditCardEXP = Int(expDateTextField.text ?? "0") // convert to date formatt
            let creditCardCVV = Int(cVVCodeTextField.text ?? "0")
            
            currentUser = User(
                userName: "user1",
                password: "password123",
                firstName: firstName,
                lastName: lastName,
                email: email,
                longitude: nil,
                latitude: nil,
                streetAddress: address,
                city: city,
                state: state,
                zipCode: zipCode)
            

            currentUserShippingAddress = ShippingAdress(
                shippingAddress: shippingAddress!,
                shippingCity: shippingCity!,
                shippingState: shippingState!,
                shippingZip: shippingZip!)
            
            currentUserCreditCard = CreditCard(
                creditCardNumber: creditCardNumber!,
                creditCardEXP: creditCardEXP!,
                creditCardCVV: creditCardCVV!)
            
            print("Name: \(String(describing: currentUser?.firstName))")
            print("State: \(String(describing: currentUserShippingAddress?.shippingState))")
            print("CVV: \(String(describing: currentUserCreditCard?.creditCardCVV))")
        }
   
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     
    
}
