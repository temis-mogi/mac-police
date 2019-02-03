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
        mockFocus()
    }
    
    public func mockFocus() {
        let centerCoordinate = CLLocationCoordinate2D(latitude: -23.524003, longitude: -46.193399)
        focus(in: centerCoordinate, with: 5000)
    }
    
    func focus(in coordinate: CLLocationCoordinate2D, with distance: CLLocationDistance) {
        mapView.setRegion(MKCoordinateRegion(center: coordinate, latitudinalMeters: distance, longitudinalMeters: distance), animated: true)
    }
    
    func add(calls: [Call]) {
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(calls)
    }
    
    func select(call: Call) {
        focus(in: call.coordinate, with: 700)
        mapView.selectAnnotation(call, animated: true)
    }
    
    func deselect(call: Call? = nil) {
        mapView.deselectAnnotation(mapView.selectedAnnotations.first, animated: true)
    }
}



extension MapViewController: MKMapViewDelegate {
}
