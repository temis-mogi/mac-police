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
            return "Em progresso"
        case 2:
            return "Resolvido"
        default:
            return "'"
        }
    }
}


class Call: NSObject, MKAnnotation {
    
    var id: String
    var priority: Priority
    var shortDescription: String
    var local: String
    var status: Status
    var coordinate: CLLocationCoordinate2D
    var title: String? {
        return priority.description()
    }
    var subtitle: String? {
        return local
    }
    
    init(id: String, priority: Priority, shortDescription: String, local: String, status: Status, coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.priority = priority
        self.shortDescription = shortDescription
        self.local = local
        self.status = status
        self.coordinate = coordinate
    }
    
    class func convert(response: [CallsResponse]) -> [Call] {
        var calls = [Call]()
        for element in response {
            let call = Call(id: element._id, priority: Priority(rawValue: element.priority)!, shortDescription: element.description, local: element.local, status: Status(rawValue: element.status)!, coordinate: CLLocationCoordinate2D(latitude: element.latitude, longitude: element.longitude))
            calls.append(call)
        }
        return calls
    }
}
