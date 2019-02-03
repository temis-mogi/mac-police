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
    
    func description() -> String {
        switch self.rawValue {
        case 0:
            return "Leve"
        case 1:
            return "Moderado"
        case 2:
            return "Crítico"
        default:
            return "'"
        }
    }
}

enum Status: Int {
    case pending = 0, solved
    
    func description() -> String {
        switch self.rawValue {
        case 0:
            return "Pendente"
        case 1:
            return "Resolvido"
        default:
            return "'"
        }
    }
}


class Call: NSObject, MKAnnotation {
    
    var priority: Priority
    var shortDescription: String
    var local: String
    var status: Status
    var coordinate: CLLocationCoordinate2D
    
    init(priority: Priority, shortDescription: String, local: String, status: Status, coordinate: CLLocationCoordinate2D) {
        self.priority = priority
        self.shortDescription = shortDescription
        self.local = local
        self.status = status
        self.coordinate = coordinate
    }
}
