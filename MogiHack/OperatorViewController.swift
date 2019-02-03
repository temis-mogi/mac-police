//
//  OperatorViewController.swift
//  MogiHack
//
//  Created by jeanpaul on 2/2/19.
//  Copyright © 2019 Jean Paul Marinho. All rights reserved.
//

import Cocoa

class OperatorViewController: NSViewController {
    
    @IBOutlet var infoView: InfoView!
    var mapViewController: MapViewController!
    var calls = [Call]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        loadCalls()
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.destinationController is MapViewController {
            mapViewController = segue.destinationController as? MapViewController
        }
    }
    
    @IBAction public func refreshPressed(_ sender: NSToolbarItem) {
        loadCalls()
    }
    
    func loadCalls() {
        calls = APIClient.getMockCalls()
        mapViewController.add(calls: calls)
        infoView.add(calls: calls)
    }
}
