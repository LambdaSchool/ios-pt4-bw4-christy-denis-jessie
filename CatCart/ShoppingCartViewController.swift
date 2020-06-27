//
//  ShoppingCartViewController.swift
//  CatCart
//
//  Created by Jessie Ann Griffin on 6/22/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import UIKit

class ShoppingCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // swiftlint:disable force_cast

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var numberOfItemsLabel: UILabel!

    var cartController = ShoppingCartController.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current

        updateViews(formatter: currencyFormatter)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPaymentPage" {
            let paymentPageVC = segue.destination as! PaymentPageViewController
            paymentPageVC.cartController = cartController
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartController.itemNames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell

        cell.nameLabel.text = cartController.itemNames[indexPath.row]
        let price = cartController.itemPrices[indexPath.row]
        cell.priceLabel.text = "$\(price)"

        cell.itemImageView?.image = cartController.itemImages[indexPath.row]
//        guard let cat = item else { return }
//        if let catImageURLString = cat.imageURL {
//            guard let catImageURL = URL(string: catImageURLString) else { return }
//            DispatchQueue.global().async {
//                guard let imageData = try? Data(contentsOf: catImageURL) else { return }
//
//                let catImage = UIImage(data: imageData)
//                DispatchQueue.main.async {
//                    cell.catImageView.image = catImage
//                }
//            }
//        }
        return cell
    }

    @IBAction func checkoutButtonPressed(_ sender: Any) {
//        performSegue(withIdentifier: "ShowPaymentPage", sender: self)
    }

    func updateViews(formatter: NumberFormatter) {

        tableView.reloadData()
        var subtotal = 0.0
        for price in cartController.itemPrices {
            subtotal += price
        }

        if let total = formatter.string(from: NSNumber(value: subtotal)) {
            subtotalLabel.text = "\(total)"
        }
        numberOfItemsLabel.text = "Subtotal (\(cartController.itemNames.count) items):"
    }
}
