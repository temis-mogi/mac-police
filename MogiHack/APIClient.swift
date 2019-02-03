//
//  APIClient.swift
//  MogiHack
//
//  Created by jeanpaul on 2/2/19.
//  Copyright © 2019 Jean Paul Marinho. All rights reserved.
//

import Foundation
import MapKit

class APIClient {
    
    static func getCalls() {
        
    }
    
    static func getMockCalls() -> [Call] {
        var calls = [Call]()
        for _ in 0...Int.random(in: 0...100) {
            let lat = "-23.51\(Int.random(in: 0...9))120"
            let long = "-46.15\(Int.random(in: 0...9))390"
            let call = Call(priority: Priority(rawValue: Int.random(in: 0...2))!, coordinate: CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(long)!))
            calls.append(call)
        }
        return calls
    }
}
