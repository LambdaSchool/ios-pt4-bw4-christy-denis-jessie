//
//  AllProductsTableViewController.swift
//  CatCart
//
//  Created by Jessie Ann Griffin on 6/22/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import UIKit

class AllProductsTableViewController: UITableViewController {
    
    // MARK: - Mock Data
    let product1 = Product(name: "Mouse", price: 1.49, type: "toy", size: "small", color: "grey", imageURL: "https://imagizer.imageshack.com/img924/3826/Fl99JW.jpg")
    let product2 = Product(name: "Bowls", price: 4.99, type: "bowl", size: "adult cat", color: "blue and orange", imageURL: "https://imagizer.imageshack.com/img923/2845/VstMaE.jpg")
    let product3 = Product(name: "Collar", price: 2.99, type: "collar", size: "adult cat", color: "orange", imageURL: "https://imagizer.imageshack.com/img923/4295/6FwdGx.jpg")
    let product4 = Product(name: "Kitty Kibble", price: 5.99, type: "food", size: "3 lbs.", color: "", imageURL: "https://imagizer.imageshack.com/img924/549/jaeGJJ.jpg")
    let product5 = Product(name: "Litter Pan", price: 14.99, type: "litter", size: "multi-cat", color: "beige", imageURL: "https://imagizer.imageshack.com/img922/8766/J8cQ6o.jpg")
    let product6 = Product(name: "Track Ball", price: 7.99, type: "toy", size: "", color: "dark grey", imageURL: "https://imagizer.imageshack.com/img922/6684/DlrUW8.jpg")
    let product7 = Product(name: "Yummies Cat Treats", price: 2.99, type: "food", size: "6 oz.", color: "", imageURL: "https://imagizer.imageshack.com/img922/3392/9NrBBC.jpg")
    
    func addMockData() {
    products.append(product1)
    products.append(product2)
    products.append(product3)
    products.append(product4)
    products.append(product5)
    products.append(product6)
    products.append(product7)
    }
    
    // MARK: - Properties
    var products: [Product] = []
    var product: Product? {
        guard let indexPath = tableView.indexPathForSelectedRow else { return nil }
        let product = products[indexPath.row]
        return product
    }
    
     var cartController: ShoppingCartController?
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        addMockData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // TODO: Sort products by type into different sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell

        cell.product = products[indexPath.row]

        return cell
    }
    
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProductSegue" {
            let productDetailVC = segue.destination as! ProductDetailViewController
            productDetailVC.product = self.product
            productDetailVC.cartController = cartController
        }
    }
}
