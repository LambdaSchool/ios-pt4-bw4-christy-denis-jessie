//
//  Cat+Convenience.swift
//  CatCart
//
//  Created by Christy Hicks on 6/22/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import Foundation
import CoreData

extension Cat {
    // swiftlint:disable identifier_name

    convenience init(id: UUID = UUID(),
                     name: String,
                     price: Double,
                     latitude: Double,
                     longitude: Double,
                     years: Int16?,
                     months: Int16?,
                     imageURL: String?,
                     context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {

        self.init(context: context)

        self.id = id
        self.name = name
        self.price = price
        self.latitude = latitude
        self.longitude = longitude
        self.years = years ?? 0
        self.months = months ?? 0
        self.imageURL = imageURL
    }

    convenience init?(catRepresentation: CatRepresentation,
                      context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {

        guard let id = catRepresentation.id,
            let name = catRepresentation.name,
            let price = catRepresentation.price,
            let latitude = catRepresentation.latitude,
            let longitude = catRepresentation.longitude,
            let years = catRepresentation.years,
            let months = catRepresentation.months,
            let imageURL = catRepresentation.imageURL else { return nil }

        self.init(id: id,
                  name: name,
                  price: price,
                  latitude: latitude,
                  longitude: longitude,
                  years: years,
                  months: months,
                  imageURL: imageURL,
                  context: context)
    }
}
