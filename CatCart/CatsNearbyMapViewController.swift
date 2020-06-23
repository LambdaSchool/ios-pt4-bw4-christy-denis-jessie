//
//  MapViewController.swift
//  CatCart
//
//  Created by Jessie Ann Griffin on 6/18/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import UIKit
import MapKit
import CoreData

extension String {
    static let annotationReuseIdentifier = "CatAnnotationView"
}

class MapViewController: UIViewController {
    
    var cats: [Cat] = []
    
    @IBOutlet var mapView: MKMapView!
    
    private var userTrackingButton: MKUserTrackingButton!
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager?.requestWhenInUseAuthorization()
        
        userTrackingButton = MKUserTrackingButton(mapView: mapView)
        userTrackingButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userTrackingButton)
        
        NSLayoutConstraint.activate([
            userTrackingButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 20),
            mapView.bottomAnchor.constraint(equalTo: userTrackingButton.bottomAnchor, constant: 20)
        ])
        
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: .annotationReuseIdentifier)
        
        fetchCats(cats)
    }
    
    func fetchCats(_ cats: [Cat]) {
        for cat in cats {
            let annotations = MKPointAnnotation()
            annotations.title = cat.name
            annotations.subtitle = "\(String(describing: cat.price))"
            annotations.coordinate = CLLocationCoordinate2D(latitude:
                cat.latitude, longitude: cat.longitude)
            mapView.addAnnotation(annotations)
        }
    }
}

