//
//  ShoppingCartViewController.swift
//  CatCart
//
//  Created by Jessie Ann Griffin on 6/22/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import UIKit

class ShoppingCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var numberOfItemsLabel: UILabel!


    var cartController: ShoppingCartController?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "ShowPaymentPage" {
            let paymentPageVC = segue.destination as! PaymentPageViewController
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartController?.itemNames.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell

        cell.nameLabel.text = cartController?.itemNames[indexPath.row]
        if let price = cartController?.itemPrices[indexPath.row] {
            cell.priceLabel.text = "$\(price)"
        }
        
        return cell
    }

    @IBAction func checkoutButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "ShowPaymentPage", sender: self)
    }

    func updateViews() {
        tableView.reloadData()
        guard let cartController = cartController else { return }
        var subtotal = 0.0
        for price in cartController.itemPrices {
            subtotal += price
        }
        subtotalLabel.text = "$\(subtotal)"
    }
}
