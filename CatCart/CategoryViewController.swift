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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // If user is logged in
        // Go to CategoryView
        if user == nil {
            performSegue(withIdentifier: "ToLandingPage", sender: nil)
        }
    }
}
//
//extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 6
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowAllCats", for: indexPath)
//            else { return UICollectionViewCell() }
//
//        return cell
//    }
//}
