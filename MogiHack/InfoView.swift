//
//  InfoView.swift
//  MogiHack
//
//  Created by jeanpaul on 2/2/19.
//  Copyright © 2019 Jean Paul Marinho. All rights reserved.
//

import Cocoa

class InfoView: NSView {

    @IBOutlet var totalCallsBox: TotalCallsBox!
    @IBOutlet var availableUnits: NSBox!
    
    func add(calls: [Call]) {
        totalCallsBox.title = "Total de chamadas (\(calls.count))"
        totalCallsBox.add(calls: calls)
    }
}
