//
//  APIClient.swift
//  MogiHack
//
//  Created by jeanpaul on 2/2/19.
//  Copyright © 2019 Jean Paul Marinho. All rights reserved.
//

import Foundation
import MapKit

struct CallsResponse: Codable {
    var _id: String
    var priority: Int
    var description: String
    var local: String
    var latitude: Double
    var longitude: Double
    var status: Int
}

class APIClient {
    
    static func getCalls(completion: @escaping ([Call]?) -> ()) {
        var request = URLRequest(url: URL(string: "https://api.myjson.com/bins/t7lws")!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(nil)
                return
            }
            if let jsonData = data {
                let decoder = JSONDecoder()
                do {
                    let callsResp = try decoder.decode([CallsResponse].self, from: jsonData)
                    var calls = Call.convert(response: callsResp)
                    calls.sort(by: {$0.priority.rawValue > $1.priority.rawValue})
                    completion(calls)
                } catch {
                    completion(nil)
                }
            }
        }.resume()
    }
    
    static func getMockCalls() -> [Call] {
        var calls = [Call]()
        for _ in 0...Int.random(in: 0...100) {
            let lat = "-23.51\(Int.random(in: 0...9))120"
            let long = "-46.15\(Int.random(in: 0...9))390"
            let call = Call(id: "mock", priority: Priority(rawValue: Int.random(in: 0...2))!, shortDescription: "Assalto mão armada", local: "Rua Armando Noro", status: Status(rawValue: Int.random(in: 0...1))!, coordinate: CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(long)!))
            calls.append(call)
        }
        return calls
    }
    
    static func postResolvedCall(with call: Call, completion: @escaping (Bool) -> ()) {
        var nextStatus = call.status.rawValue+1
        if nextStatus > 2 {
            nextStatus = 0
        }
        var request = URLRequest(url: URL(string: "http://temis.mybluemix.net/\(call.id)/\(nextStatus)")!)
        request.httpMethod = "POST"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(false)
                return
            }
            completion(true)
            }.resume()
    }
}
