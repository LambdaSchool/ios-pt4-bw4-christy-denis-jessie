//
//  UserLoginViewController.swift
//  CatCart
//
//  Created by Jessie Ann Griffin on 6/17/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import UIKit

protocol UserLoginViewControllerDelegate: class {
    // swiftlint:disable force_cast

    func userLoginViewController(_ viewController: UserLoginViewController, loggedInUser: User)
}

class UserLoginViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    // MARK: - Properties
    var userController = UserController()
    var currentUser: User?
    weak var delegate: UserLoginViewControllerDelegate?

    // MARK: - Setup
    static func newLogin() -> UserLoginViewController {
        let storyboard = UIStoryboard(name: "UserLogin", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "UserLoginViewController") as! UserLoginViewController

        print("received loginVC user: \(String(describing: loginVC.currentUser?.userName)) password: \(String(describing: loginVC.currentUser?.password))")

        return loginVC
    }

    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateViews()
    }

    private func updateViews() {
        guard isViewLoaded else { return }
        guard let user = currentUser else { return }
        userNameTextField.text = user.userName
        userPasswordTextField.text = user.password

        print("received loginVC user: \(String(describing: currentUser?.userName)) password: \(String(describing: currentUser?.password))")
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    // MARK: - Actions
//    @IBAction func showStore() {
//        let storeVC = CategoryViewController.goToStore()
//        storeVC.currentUser = currentUser
//        show(storeVC, sender: self)
//    }
    @IBAction func showSignUp() {
        let signupVC = UserSignUpViewController.newSignUp()
        signupVC.userController = userController
        present(signupVC, animated: true, completion: nil)
    }

    @IBAction func loginTapped(_ sender: UIButton) {

        if let userName = userNameTextField.text,
            !userName.isEmpty,
            let password = userPasswordTextField.text,
            !password.isEmpty {

            let user = UserRepresentation(password: password,
                                          userName: userName)

            currentUser = User(userName: user.userName,
                               password: user.password,
                               firstName: nil,
                               lastName: nil,
                               email: nil,
                               longitude: nil,
                               latitude: nil,
                               streetAddress: nil,
                               city: nil,
                               state: nil,
                               zipCode: nil)

            UserDefaults.standard.set(currentUser?.userName, forKey: "LoggedInUser")

            userController.signIn(with: user) { error in

                if let error = error {
                    print("Error occurred during sign up: \(error)")
                }

                if self.userController.passwordMatch == true {
                    print("password match: true")
                    DispatchQueue.main.async {
                        self.userNameTextField.text = ""
                        self.userPasswordTextField.text = ""

                        self.delegate?.userLoginViewController(self, loggedInUser: self.currentUser!)
                    }

                } else {
                    print("password match: false")
                    DispatchQueue.main.async {
                        self.userNameTextField.text = ""
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

// MARK: - Navigation
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "ShowStoreSegue" {
//                if let catCartUserVC = segue.destination as? CategoryViewController {
//                    catCartUserVC.user = user
//                }
//            }
//        }

}
