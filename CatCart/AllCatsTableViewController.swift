//
//  AllCatsTableViewController.swift
//  CatCart
//
//  Created by Jessie Ann Griffin on 6/18/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import UIKit

class AllCatsTableViewController: UITableViewController {

    static func seeTheCats() -> AllCatsTableViewController {
        let storyboard = UIStoryboard(name: "CatsForSale", bundle: nil)
        let catsForSaleVC = storyboard.instantiateViewController(withIdentifier: "AllCatsTableViewController") as! AllCatsTableViewController
        return catsForSaleVC
    }

//    let cat1 = Cat(name: "Bosco", price: 250.00, latitude: 0.0, longitude: 0.0, years: 13, months: 3, imageURL: nil)
    var cats: [Cat] = []

    override func viewDidLoad() {
        super.viewDidLoad()
//        cats.append(cat1)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CatCell", for: indexPath)as? CatTableViewCell
            else { return UITableViewCell() }

        cell.cat = cats[indexPath.row]

        return cell
    }

    @IBAction func addACatButtonPressed(_ sender: UIBarButtonItem) {
        
    }
}
