//
//  PaymentPageViewController.swift
//  CatCart
//
//  Created by Jessie Ann Griffin on 6/22/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

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
    // swiftlint:disable line_length
    // swiftlint:disable force_cast
    // swiftlint:disable function_body_length

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
    var cartController = ShoppingCartController.shared
    var userController = UserController()
    var audioPlayer: AVAudioPlayer? {
           didSet {
               guard let audioPlayer = audioPlayer else { return }
               audioPlayer.delegate = self
               audioPlayer.isMeteringEnabled = true
           }
       }

    func updateViews() {
           checkOutButton.isSelected = isPlaying
       }

    var isPlaying: Bool {
        audioPlayer?.isPlaying ?? false
    }

    func loadAudio() {
        let songURL = Bundle.main.url(forResource: "CHMeow10", withExtension: "m4a")!
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: songURL)
        } catch {
            preconditionFailure("Failure to load audio file: \(error)")
        }
    }

     func prepareAudioSession() throws {
         let session = AVAudioSession.sharedInstance()
         try session.setCategory(.playAndRecord, options: [.defaultToSpeaker])
         try session.setActive(true, options: [])
     }

     func play() {
         do {
             try prepareAudioSession()
             audioPlayer?.play()
             updateViews()
         } catch {
             print("cannot play audio: \(error)")
         }
     }

    @IBAction func isShippingTheSameAsBillingSwitch(_ sender: UISwitch) {

        if sender.isOn == true {
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

        } else if sender.isOn == false {
            shippingAddressTextFeild.text = ""
            shippingCityTextField.text = ""
            shippingStateTextField.text = ""
            shippingZipCodeTextField.text = ""
        }
    }

    @IBAction func checkOutButtonTapped(_ sender: UIButton) {

        play()

        if  firstNameTextField.text == "" ||
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
            cVVCodeTextField.text == "" {

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

            // MARK: - Added fetch from Core Data
            let moc = CoreDataStack.shared.mainContext
            let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "userName == %@", UserDefaults.standard.value(forKey: "LoggedInUser") as! String)
            if let user = try? moc.fetch(fetchRequest).first {
                user.firstName = firstName
                user.lastName = lastName
                user.email = email
                user.streetAddress = address
                user.city = city
                user.state = state
                user.zipCode = zipCode!
            }

            currentUser = User(
            userName: "testUserName",
            password: "testPassword",
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

            performSegue(withIdentifier: "ShowCheckOutSegue", sender: AnyObject.self)

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadAudio()
        updateViews()
        // MARK: - Added fetch from Core Data
        let moc = CoreDataStack.shared.mainContext
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userName == %@", UserDefaults.standard.value(forKey: "LoggedInUser") as! String)

        if let user = try? moc.fetch(fetchRequest).first {

            firstNameTextField.text = "\(String(describing: user.firstName))"
            lastNameTextField.text = "\(String(describing: user.lastName))"
            emailTextField.text = "\(String(describing: user.email))"
            billingAddressTextField.text = "\(String(describing: user.streetAddress))"
            billingCityTextField.text = "\(String(describing: user.city))"
            billingStateTextField.text = "\(String(describing: user.state))"
            billingZipCodeTextField.text = "\(user.zipCode)"

        }

    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCheckOutSegue" {
            if let checkOutVC = segue.destination as? CheckOutConfirmationViewController {
                checkOutVC.currentUser = self.currentUser
                checkOutVC.cartController = self.cartController
                checkOutVC.currentUserCreditCard = self.currentUserCreditCard
                checkOutVC.currentUserShippingAddress = self.currentUserShippingAddress
            }
        }
    }
}

extension PaymentPageViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        updateViews()
    }
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        if let error = error {
            print("Audio Player error: \(error)")
        }
    }
}
