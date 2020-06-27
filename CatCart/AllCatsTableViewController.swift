//
//  AllCatsTableViewController.swift
//  CatCart
//
//  Created by Jessie Ann Griffin on 6/18/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import UIKit

class AllCatsTableViewController: UITableViewController {
    // swiftlint:disable force_cast

    var cartController = ShoppingCartController.shared

    // MARK: - Mock Data
    let cat1 = Cat(name: "Mysty",
                   price: 14.99,
                   latitude: 50,
                   longitude: -100,
                   years: 0,
                   months: 2,
                   imageURL: "https://imagizer.imageshack.com/img922/2816/kDUKLs.jpg")
    let cat2 = Cat(name: "Arya",
                   price: 2.49,
                   latitude: 41,
                   longitude: -100,
                   years: 0,
                   months: 6,
                   imageURL: "https://imagizer.imageshack.com/img923/6269/C6kuyK.jpg")
    let cat3 = Cat(name: "Eclipse",
                   price: 74.99,
                   latitude: 45,
                   longitude: -99,
                   years: 1,
                   months: 3,
                   imageURL: "https://imagizer.imageshack.com/img923/762/dhCFUn.jpg")
    let cat4 = Cat(name: "Soledad",
                   price: 0.99,
                   latitude: 27,
                   longitude: -81,
                   years: 5,
                   months: 3,
                   imageURL: "https://imagizer.imageshack.com/img922/7587/3rbsUm.jpg")
    let cat5 = Cat(name: "Thunder",
                   price: 49.99,
                   latitude: 40,
                   longitude: -75,
                   years: 0,
                   months: 7,
                   imageURL: "https://imagizer.imageshack.com/img923/1834/py9HKC.jpg")

    func addMockData() {
        cats.append(cat1)
        cats.append(cat2)
        cats.append(cat3)
        cats.append(cat4)
        cats.append(cat5)
    }

    // MARK: - Properties
    var cats: [Cat] = []
    var cat: Cat? {
        guard let indexPath = tableView.indexPathForSelectedRow else { return nil }
        let cat = cats[indexPath.row]
        return cat
    }

    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        addMockData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatCell", for: indexPath) as! CatTableViewCell

        cell.cat = cats[indexPath.row]

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCatDetailSegue" {
            let catDetailVC = segue.destination as! CatDetailViewController
            catDetailVC.cat = self.cat
            catDetailVC.cartController = cartController
        }
    }
}
