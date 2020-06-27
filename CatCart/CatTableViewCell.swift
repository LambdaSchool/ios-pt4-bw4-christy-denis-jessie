//
//  CatTableViewCell.swift
//  CatCart
//
//  Created by Christy Hicks on 6/24/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import UIKit

class CatTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet var catImageView: UIImageView!
    @IBOutlet var catPriceLabel: UILabel!
    @IBOutlet var catNameLabel: UILabel!

    // MARK: - Properties
    var cat: Cat? {
        didSet {
            updateViews()
        }
    }

    // MARK: - View
    func updateViews() {
        guard let cat = cat else { return }
            catPriceLabel.text = "$\(cat.price)"
            catNameLabel.text = cat.name
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
}
