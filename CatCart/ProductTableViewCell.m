//
//  ProductTableViewCell.m
//  CatCart
//
//  Created by Christy Hicks on 6/24/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

#import "ProductTableViewCell.h"

@implementation ProductTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (_product!=nil) {
        _productNameLabel.text=_product.name;
        _productPriceLabel.text=[NSString stringWithFormat:@"$%.2lf", _product.price];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
