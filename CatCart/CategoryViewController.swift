//
//  CategoryViewController.swift
//  CatCart
//
//  Created by Jessie Ann Griffin on 6/18/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet weak var allCatsButton: UIButton!
    @IBOutlet weak var catsNearbyButton: UIButton!
    @IBOutlet var productsButtons: [UIButton]!


    let userController = UserController()
    var user: UserRepresentation?

    static func goToStore() -> CategoryViewController {
        let storyboard = UIStoryboard(name: "CategoryCollection", bundle: nil)
        print(storyboard)
        let categoryVC = storyboard.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
        //categoryVC.modalPresentationStyle = .fullScreen
        return categoryVC
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // If user is logged in
        // Go to CategoryView
        if !userController.userIsLoggedIn {
            performSegue(withIdentifier: "ToLandingPage", sender: nil)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToLandingPage" {
            let landingPageVC = segue.destination as? LandingPageViewController
            landingPageVC?.userController = userController
        }
    }

    @IBAction func viewAllCatsButton(_ sender: Any) {
    }
    @IBAction func viewCatsNearbyButton(_ sender: Any) {
    }

    @IBAction func viewProductsButton() {
        
    }
}

