//
//  CreateUserAccountViewController.swift
//  CatCart
//
//  Created by Jessie Ann Griffin on 6/17/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import UIKit

class CreateUserAccountViewController: UIViewController {
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    
    var userController = UserController()
    //    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    @IBAction func createAccount(_ sender: UIButton) {
        if let userEmail = userEmailTextField.text,
            !userEmail.isEmpty,
            let password = userPasswordTextField.text,
            !password.isEmpty {
            
//            currentUser = User(password: password,
//                               username: userEmail)
            let user = UserRepresentation(password: password,
                                          userEmail: userEmail)
            
            userController.signUp(with: user) { error in
                
                if let error = error {
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(
                            title: "Sign Up Successfull",
                            message: "Now please log in.",
                            preferredStyle: .alert)
                        let alertAction = UIAlertAction(
                            title: "OK",
                            style: UIAlertAction.Style.default,
                            handler: { action -> Void in
                                self.performSegue(withIdentifier: "SignInSegue", sender: self)
                        })
                        alertController.addAction(alertAction)
                        self.present(alertController, animated: true)
                        self.userEmailTextField.text = ""
                        self.userPasswordTextField.text = ""
                    }
                    print("Error did not occur during sign up: \(error)")
                } else {
                    DispatchQueue.main.async {
                        self.userEmailTextField.text = ""
                        self.userPasswordTextField.text = ""
                        
                        let alertController = UIAlertController(
                            title: "Sign Up not Successfull",
                            message: "Username already exists, please try again.",
                            preferredStyle: .alert)
                        let alertAction = UIAlertAction(
                            title: "OK",
                            style: UIAlertAction.Style.default,
                            handler: nil)
                        alertController.addAction(alertAction)
                        self.present(alertController, animated: true)
                        
                    }
                }
            }
            
        }
    }
    
    // MARK: - Navigation
    //     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //         if segue.identifier == "SignInSegue" {
    //             if let signInVC = segue.destination as? UserSignInViewController {
    //                 signInVC.currentUser = currentUser
    //             }
    //         }
    //     }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
