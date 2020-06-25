//
//  CatDetailViewController.swift
//  CatCart
//
//  Created by Jessie Ann Griffin on 6/18/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import UIKit

class CatDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var catImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var yearsLabel: UILabel!
    @IBOutlet var monthsLabel: UILabel!
    @IBOutlet weak var cartButton: UIBarButtonItem!

    // MARK: - Properties
    var cat: Cat?
    var cartController: ShoppingCartController?
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    func updateViews() {
        guard let cat = cat else { return }
        priceLabel.text = "$\(cat.price)"
        nameLabel.text = cat.name
        yearsLabel.text = "\(cat.years)"
        monthsLabel.text = "\(cat.months)"
        getImage()
    }
    
    func getImage() {
        guard let cat = cat else { return }
        if let catImageURLString = cat.imageURL {
            guard let catImageURL = URL(string: catImageURLString) else { return }
            DispatchQueue.global().async {
                guard let imageData = try? Data(contentsOf: catImageURL) else { return }
                
                let catImage = UIImage(data: imageData)
                DispatchQueue.main.async {
                    self.catImageView.image = catImage
                }
            }
        }
    }
    @IBAction func addToCart(_ sender: Any) {
        guard let cartController = cartController, let cat = cat, let name = cat.name else { return }
        cartController.addItem(itemName: name, itemPrice: cat.price)
//        cartButton.badge = cartController.itemNames.count

    }

    @IBAction func cartButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "ShowShoppingCart", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowShoppingCart" {
            let shoppingCartVC = segue.destination as! ShoppingCartViewController
            shoppingCartVC.cartController = cartController
        }
    }
}
