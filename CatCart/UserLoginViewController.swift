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
    
    var userController: UserController?
    var user: UserRepresentation?
    
    //TODO: need a user model from core data
    //    var currentUser: User?

    static func newLogin() -> UserLoginViewController {
        let storyboard = UIStoryboard(name: "UserLogin", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "UserLoginViewController") as! UserLoginViewController
        return loginVC
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }

    @IBAction func showStore() {
        let storeVC = CategoryViewController.goToStore()
        show(storeVC, sender: self)
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {

        guard let userController = userController else { return }
        
        if let userEmail = userEmailTextField.text,
            !userEmail.isEmpty,
            let password = userPasswordTextField.text,
            !password.isEmpty {
            
            user = UserRepresentation(password: password,
                                          userName: userEmail)
            
            //                   currentUser = User(password: password,
            //                                      email: userEmail)
            guard let user = user else { return }
            userController.signIn(with: user) { error in
                
                if let error = error {
                    print("Error occurred during sign up: \(error)")
                }
                
                if userController.passwordMatch == true {
                    print("password match: true")
                    DispatchQueue.main.async {
                        self.userEmailTextField.text = ""
                        self.userPasswordTextField.text = ""
                        self.showStore()
//                        self.performSegue(withIdentifier: "ShowStoreSegue", sender: self)
                    }
                } else {
                    print("password match: false")
                    DispatchQueue.main.async {
                        self.userEmailTextField.text = ""
                        self.userPasswordTextField.text = ""
                        
                        let alertController = UIAlertController(
                            title: "Sign In Un-Successfull",
                            message: "Incorrect Password or Username.",
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
        guard let user = user else { return }
        
        userEmailTextField.text = user.userName
        userPasswordTextField.text = user.password
    }
    
//     MARK: - Navigation
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "ShowStoreSegue" {
//                if let catCartUserVC = segue.destination as? CategoryViewController {
//                    catCartUserVC.user = user
//                }
//            }
//        }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
