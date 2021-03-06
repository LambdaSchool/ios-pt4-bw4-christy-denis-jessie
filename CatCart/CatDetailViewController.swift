//
//  CatDetailViewController.swift
//  CatCart
//
//  Created by Jessie Ann Griffin on 6/18/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import UIKit

class CatDetailViewController: UIViewController {
    // swiftlint:disable force_cast

    // MARK: - Outlets
    @IBOutlet var catImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var yearsLabel: UILabel!
    @IBOutlet var monthsLabel: UILabel!
    @IBOutlet weak var cartButton: UIBarButtonItem!

    // MARK: - Properties
    var cat: Cat?
    var cartController = ShoppingCartController.shared

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
        guard let cat = cat, let name = cat.name else { return }

        cartController.addItem(itemName: name, itemPrice: cat.price)

        if let name = cat.name {
            DispatchQueue.main.async {
                let alertController = UIAlertController(
                    title: "Meow!",
                    message: "\(String(describing: name)) was added to your cart!",
                    preferredStyle: .alert)
                let alertAction = UIAlertAction(
                    title: "OK",
                    style: UIAlertAction.Style.default,
                    handler: { _ in
                        self.navigationController?.popToRootViewController(animated: true)
                })
                alertController.addAction(alertAction)
                self.present(alertController, animated: true)
            }
        }
    }

    @IBAction func cartButtonPressed(_ sender: UIBarButtonItem) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "ShoppingCart", bundle: nil)
        let shoppingCart = storyBoard.instantiateViewController(withIdentifier: "ShoppingCartViewController")
            as! ShoppingCartViewController
        navigationController?.pushViewController(shoppingCart, animated: true)
    }
}
