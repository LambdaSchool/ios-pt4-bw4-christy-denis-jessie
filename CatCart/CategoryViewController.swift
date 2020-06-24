//
//  CategoryViewController.swift
//  CatCart
//
//  Created by Jessie Ann Griffin on 6/18/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    // MARK: - Properties
    var currentUser: User?

    // MARK: - Setup
    static func goToStore() -> CategoryViewController {
        let storyboard = UIStoryboard(name: "CatsForSale", bundle: nil)
        print(storyboard)
        let categoryVC = storyboard.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
        
        categoryVC.modalPresentationStyle = .fullScreen
        
        return categoryVC
    }

    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // If user is logged in
        // Go to CategoryView
        if currentUser == nil {
            performSegue(withIdentifier: "ToLandingPage", sender: nil)
        }
    }
}

