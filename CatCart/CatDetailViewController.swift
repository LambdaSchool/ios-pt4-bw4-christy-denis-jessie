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
    
    // MARK: - Properties
    var cat: Cat?
    
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
}
