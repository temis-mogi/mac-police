//
//  TotalCallBox.swift
//  MogiHack
//
//  Created by jeanpaul on 2/2/19.
//  Copyright © 2019 Jean Paul Marinho. All rights reserved.
//

import Cocoa

class TotalCallsBox: NSBox {

    @IBOutlet var minorTextField: NSTextField!
    @IBOutlet var majorTextField: NSTextField!
    @IBOutlet var criticalTextField: NSTextField!

    func add(calls: [Call]) {
        let minor = calls.filter {$0.priority == .minor}
        minorTextField.stringValue = "\(minor.count)"
        let major = calls.filter {$0.priority == .major}
        majorTextField.stringValue = "\(major.count)"
        let critical = calls.filter {$0.priority == .critical}
        criticalTextField.stringValue = "\(critical.count)"
    }
}
