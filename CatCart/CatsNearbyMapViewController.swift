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

class CatsNearbyMapViewController: UIViewController, CLLocationManagerDelegate {
    // swiftlint:disable force_cast

    // MARK: - Mock Data
    let cat1 = Cat(name: "Mysty",
                   price: 14.99,
                   latitude: 37.333768,
                   longitude: -122.033954,
                   years: 0,
                   months: 2,
                   imageURL: "https://imagizer.imageshack.com/img922/2816/kDUKLs.jpg")
    let cat2 = Cat(name: "Arya",
                   price: 2.49,
                   latitude: 37.337830,
                   longitude: -122.033493,
                   years: 0,
                   months: 6,
                   imageURL: "https://imagizer.imageshack.com/img923/6269/C6kuyK.jpg")
    let cat3 = Cat(name: "Eclipse",
                   price: 74.99,
                   latitude: 37.370036,
                   longitude: -122.032052,
                   years: 1,
                   months: 3,
                   imageURL: "https://imagizer.imageshack.com/img923/762/dhCFUn.jpg")
    let cat4 = Cat(name: "Soledad",
                   price: 0.99,
                   latitude: 37.325935,
                   longitude: -122.020652,
                   years: 5,
                   months: 3,
                   imageURL: "https://imagizer.imageshack.com/img922/7587/3rbsUm.jpg")
    let cat5 = Cat(name: "Thunder",
                   price: 49.99,
                   latitude: 37.328590,
                   longitude: -122.037386,
                   years: 0,
                   months: 7,
                   imageURL: "https://imagizer.imageshack.com/img923/1834/py9HKC.jpg")

    func addMockData() {
        cats.append(cat1)
        cats.append(cat2)
        cats.append(cat3)
        cats.append(cat4)
        cats.append(cat5)
    }

    var cats: [Cat] = []
    private var userTrackingButton: MKUserTrackingButton!
    var locationManager = CLLocationManager()

    @IBOutlet var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }

        mapView.delegate = self
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "CatAnnotationView")
        addMockData()

        DispatchQueue.main.async {
            self.mapView.addAnnotations(self.cats)
            guard let cat = self.cats.first else {return}

            let span = MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25)
            let region = MKCoordinateRegion(center: cat.coordinate, span: span)
            self.mapView.setRegion(region, animated: true)
        }

        userTrackingButton = MKUserTrackingButton(mapView: mapView)
        userTrackingButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userTrackingButton)

        NSLayoutConstraint.activate([
            userTrackingButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 20),
            mapView.bottomAnchor.constraint(equalTo: userTrackingButton.bottomAnchor, constant: 20)
        ])
    }

}

extension CatsNearbyMapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard let cat = annotation as? Cat else { return nil }
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: "CatAnnotationView", for: cat)
            as? MKMarkerAnnotationView

        view?.glyphImage = UIImage(named: "KittyIcon")
        view?.markerTintColor = .black
        view?.canShowCallout = true

        let detailView = CatAnnotationDetailView()
        detailView.delegate = self
        detailView.cat = cat
        view?.detailCalloutAccessoryView = detailView
        return view
    }
}

extension CatsNearbyMapViewController: MapDetailViewDelegate {
    func didPressButton(with cat: Cat) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "CatsForSale", bundle: nil)
        let detailView = storyBoard.instantiateViewController(withIdentifier: "CatDetailViewController")
            as! CatDetailViewController
        detailView.cat = cat
        navigationController?.pushViewController(detailView, animated: true)
    }
}
