//
//  UserLoginViewController.swift
//  CatCart
//
//  Created by Jessie Ann Griffin on 6/17/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import UIKit

class UserLoginViewController: UIViewController {
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var userController =  UserController()
    
    //TODO: need a user model from core data
    //    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        if let userEmail = userEmailTextField.text,
            !userEmail.isEmpty,
            let password = userPasswordTextField.text,
            !password.isEmpty {
            
            let user = UserRepresentation(password: password,
                                          userEmail: userEmail)
            
            //                   currentUser = User(password: password,
            //                                      username: userEmail)
            
            //run sign in API call
            userController.signIn(with: user) { error in
                
                if let error = error {
                    print("Error occurred during sign up: \(error)")
                }
                
                if self.userController.passwordMatch == true {
                    print("true")
                    DispatchQueue.main.async {
                        self.userEmailTextField.text = ""
                        self.userPasswordTextField.text = ""
                        self.performSegue(withIdentifier: "PlantSegue", sender: self)
                    }
                } else {
                    print("false")
                    DispatchQueue.main.async {
                        self.userEmailTextField.text = ""
                        self.userPasswordTextField.text = ""
                        
                        let alertController = UIAlertController(
                            title: "Sign In UnSuccessfull",
                            message: "Incorrect Password.",
                            preferredStyle: .alert)
                        
                        let alertAction = UIAlertAction(
                            title: "OK",
                            style: UIAlertAction.Style.default,
                            handler: nil)
                        
                        alertController.addAction(alertAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        }
        
    }
    
    private func updateViews() {
        guard isViewLoaded else { return }
        //        guard let currentUser = currentUser else { return }
        //
        //        userEmailTextField.text = currentUser.username
        //        passwordTextField.text = currentUser.password
    }
    
    // MARK: - Navigation
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if sugue.identifier == "MAYBECatCartTableViewSegue" {
    //            if let catCartUserVC = segue.destination as? MAYBECatCartTableViewController {
    //                catCartUserVC.user = currentUser
    //            }
    //        }
    //    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
