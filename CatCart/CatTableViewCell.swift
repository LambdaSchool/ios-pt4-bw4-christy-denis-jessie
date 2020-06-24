//
//  CatTableViewCell.swift
//  CatCart
//
//  Created by Jessie Ann Griffin on 6/23/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import UIKit

class CatTableViewCell: UITableViewCell {

    @IBOutlet weak var catImageView: UIImageView!

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    var cat: Cat?


}
