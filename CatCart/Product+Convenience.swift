//
//  Product+Convenience.swift
//  CatCart
//
//  Created by Christy Hicks on 6/22/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import Foundation
import CoreData

@objc(CKProduct)
extension Product {
    
    convenience init(id: UUID = UUID(),
                     name: String,
                     price: Double,
                     type: String,
                     size: String?,
                     color: String?,
                     imageURL: String?,
                     context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: context)
        
        self.id = id
        self.name = name
        self.price = price
        self.type = type
        self.size = size
        self.color = color
        self.imageURL = imageURL
    }
    
    @nonobjc convenience init?(productRepresentation: ProductRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        guard let id = productRepresentation.id,
            let name = productRepresentation.name,
            let price = productRepresentation.price,
            let type = productRepresentation.type,
            let size = productRepresentation.size,
            let color = productRepresentation.color,
            let imageURL = productRepresentation.imageURL else { return nil }
        
        self.init(id: id, name: name, price: price, type: type, size: size, color: color, imageURL: imageURL, context: context)
    }
}
