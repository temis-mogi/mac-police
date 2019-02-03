//
//  Call.swift
//  MogiHack
//
//  Created by jeanpaul on 2/2/19.
//  Copyright © 2019 Jean Paul Marinho. All rights reserved.
//

import Foundation
import MapKit

enum Priority: Int {
    case minor = 0, major, critical
}

class Call: NSObject, MKAnnotation {
    
    var priority: Priority
    var coordinate: CLLocationCoordinate2D
    
    init(priority: Priority, coordinate: CLLocationCoordinate2D) {
        self.priority = priority
        self.coordinate = coordinate
    }
}
