//
//  MapViewController.swift
//  MogiHack
//
//  Created by jeanpaul on 2/2/19.
//  Copyright © 2019 Jean Paul Marinho. All rights reserved.
//

import Cocoa
import MapKit

class MapViewController: NSViewController {

    @IBOutlet var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let centerCoordinate = CLLocationCoordinate2D(latitude: -23.511200, longitude: -46.153950)
        let distMeters: CLLocationDistance = 1000
        mapView.setRegion(MKCoordinateRegion(center: centerCoordinate, latitudinalMeters: distMeters, longitudinalMeters: distMeters), animated: false)
    }
    
    func add(calls: [Call]) {
        mapView.addAnnotations(calls)
    }
}



extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
    }
}
