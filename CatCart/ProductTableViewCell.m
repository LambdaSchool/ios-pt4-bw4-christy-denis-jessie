//
//  ProductTableViewCell.m
//  CatCart
//
//  Created by Christy Hicks on 6/24/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

#import "ProductTableViewCell.h"
#import "CatCart-Swift.h"

@implementation ProductTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setProduct:(Product *)product {
    _productNameLabel.text = product.name;
    _productPriceLabel.text=[NSString stringWithFormat:@"$%.2lf", product.price];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
