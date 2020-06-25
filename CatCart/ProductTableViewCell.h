//
//  ProductTableViewCell.h
//  CatCart
//
//  Created by Christy Hicks on 6/24/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CatCart-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *productImageView;
@property (strong, nonatomic) IBOutlet UILabel *productNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *productPriceLabel;
// TODO: fix to correctly read as CKProduct
// TODO: verify that this is formatted correctly
@property (strong, nonatomic) Product *product;

@end

NS_ASSUME_NONNULL_END
