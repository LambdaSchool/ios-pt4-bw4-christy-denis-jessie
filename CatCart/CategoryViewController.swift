//
//  CategoryViewController.swift
//  CatCart
//
//  Created by Jessie Ann Griffin on 6/18/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UIViewController {

    // MARK: - Properties
    var currentUser: User?
    var cartController = ShoppingCartController.shared
    let userController = UserController()
    
    // MARK: - Setup
    //    static func goToStore() -> CategoryViewController {
    //        let storyboard = UIStoryboard(name: "CatsForSale", bundle: nil)
    //        print(storyboard)
    //        let categoryVC = storyboard.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
    //
    //        categoryVC.modalPresentationStyle = .fullScreen
    //
    //        return categoryVC
    //    }
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        // currentUser = fetchResultsController
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDefaults.standard.value(forKey: "LoggedInUser") == nil {
            performSegue(withIdentifier: "ToLandingPage", sender: nil)
        } else {
            currentUser = userController.user
            if let currentUser = currentUser,
                let username = currentUser.userName,
                let password = currentUser.password {
                
                print(username)
                print(password)
            }
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCatsForSale" {
            let destinationVC = segue.destination as! AllCatsTableViewController
            destinationVC.cartController = cartController
        } else if segue.identifier == "ToLandingPage" {
            let destinationVC = segue.destination as! UserLoginViewController
            if let user = currentUser {
                destinationVC.currentUser = user
            }
            destinationVC.delegate = self
        } else if segue.identifier == "ShowProductsPage" {
            let destinationVC = segue.destination as! AllProductsTableViewController
            destinationVC.cartController = cartController
        }
    }

    @IBAction func cartButtonPressed(_ sender: UIBarButtonItem) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "ShoppingCart", bundle: nil)
        let shoppingCart = storyBoard.instantiateViewController(withIdentifier: "ShoppingCartViewController") as! ShoppingCartViewController
        navigationController?.pushViewController(shoppingCart, animated: true)
    }
}

extension CategoryViewController: UserLoginViewControllerDelegate {
    func userLoginViewController(_ viewController: UserLoginViewController, loggedInUser: User) {
        currentUser = loggedInUser
        viewController.dismiss(animated: true, completion: nil)
    }
}
