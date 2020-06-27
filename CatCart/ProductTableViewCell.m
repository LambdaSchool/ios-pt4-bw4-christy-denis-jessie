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
    [self loadImage:product.imageURL];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadImage:(NSString *)productImageURLString {
    NSURL *productImageURL = [NSURL URLWithString:productImageURLString];
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(requestRemoteImage:) object:productImageURL];
    [queue addOperation:operation];
}

- (void)requestRemoteImage:(NSURL *)productImageURL {
    NSData *productImageData = [[NSData alloc] initWithContentsOfURL:productImageURL];
    UIImage *productImage = [[UIImage alloc] initWithData:productImageData];
    
    [self performSelectorOnMainThread:@selector(placeImageInUI:) withObject:productImage waitUntilDone:YES];
}

- (void)placeImageInUI:(UIImage *)productImage {
    [_productImageView setImage:productImage];
}

@end
