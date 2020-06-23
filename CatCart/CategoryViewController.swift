//
//  CategoryViewController.swift
//  CatCart
//
//  Created by Jessie Ann Griffin on 6/18/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet weak var categoryCollectionView: UICollectionView!

    let userController = UserController()

    static func goToStore() -> CategoryViewController {
        let storyboard = UIStoryboard(name: "CatsForSale", bundle: nil)
        print(storyboard)
        let categoryVC = storyboard.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
        
        categoryVC.modalPresentationStyle = .fullScreen
        
        return categoryVC
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performSegue(withIdentifier: "ToLandingPage", sender: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
