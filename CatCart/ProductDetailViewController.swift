//
//  ProductDetailViewController.swift
//  CatCart
//
//  Created by Jessie Ann Griffin on 6/22/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var colorLabel: UILabel!
    @IBOutlet var sizeLabel: UILabel!
    
    // MARK: - Properties
    var product: Product?
    var cartController = ShoppingCartController.shared

    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    func updateViews() {
        guard let product = product else { return }
        nameLabel.text = product.name
        priceLabel.text = "$\(product.price)"
        typeLabel.text = product.type
        colorLabel.text = product.color
        sizeLabel.text = product.size
        getImage()
    }
    
    func getImage() {
        guard let product = product else { return }
        if let productImageURLString = product.imageURL {
            guard let productImageURL = URL(string: productImageURLString) else { return }
            DispatchQueue.global().async {
                guard let imageData = try? Data(contentsOf: productImageURL) else { return }
                
                let productImage = UIImage(data: imageData)
                DispatchQueue.main.async {
                    self.productImageView.image = productImage
                }
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func addToCart(_ sender: Any) {
        guard let product = product, let name = product.name else { return }
        if let productImageURLString = product.imageURL {
            guard let productImageURL = URL(string: productImageURLString) else { return }
            DispatchQueue.global().async {
                guard let imageData = try? Data(contentsOf: productImageURL) else { return }
                
                guard let productImage = UIImage(data: imageData) else { return }
                self.cartController.addItem(itemName: name, itemPrice: product.price)
            }
        }
        //        cartButton.badge = cartController.itemNames.count
    }
    
    @IBAction func cartButtonPressed(_ sender: UIBarButtonItem) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "ShoppingCart", bundle: nil)
        let shoppingCart = storyBoard.instantiateViewController(withIdentifier: "ShoppingCartViewController") as! ShoppingCartViewController
        navigationController?.pushViewController(shoppingCart, animated: true)
    }
    
    // MARK: - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ShowShoppingCart" {
//            let shoppingCartVC = segue.destination as! ShoppingCartViewController
//            shoppingCartVC.cartController = cartController
//        }
//    }
}
