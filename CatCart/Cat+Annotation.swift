//
//  Cat+Annotation.swift
//  CatCart
//
//  Created by denis cedeno on 6/25/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import Foundation
import MapKit

extension Cat: MKAnnotation {
    
    public var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    public var title: String? {
        name
    }
    public var subtitle: String? {
        "Price: $\(price)"
    }
}
