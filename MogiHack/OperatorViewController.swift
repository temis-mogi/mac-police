//
//  OperatorViewController.swift
//  MogiHack
//
//  Created by jeanpaul on 2/2/19.
//  Copyright © 2019 Jean Paul Marinho. All rights reserved.
//

import Cocoa

fileprivate enum CellIdentifiers {
    static let priorityCell = "PriorityCellID"
    static let descriptionCell = "DescriptionCellID"
    static let locationCell = "LocationCellID"
    static let statusCell = "StatusCellID"
}

class OperatorViewController: NSViewController {
    
    @IBOutlet var tableView: NSTableView!
    @IBOutlet var infoView: InfoView!
    @IBOutlet var segmentedControl: NSSegmentedControl!
    var mapViewController: MapViewController!
    var calls = [Call]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.target = self
        tableView.doubleAction = #selector(tableViewDoubleClick(_:))
        segmentedControl.isEnabled = false
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
    
    @objc func tableViewDoubleClick(_ sender:AnyObject) {
    }
    
    @IBAction public func refreshPressed(_ sender: NSToolbarItem) {
        loadCalls()
    }
    
    @IBAction func segmentedControlChanged(_ sender: NSSegmentedControl) {
        guard tableView.selectedRow >= 0 else { return }
        APIClient.postResolvedCall(with: calls[tableView.selectedRow], to: sender.selectedSegment) { (success) in
            if success {
                self.loadCalls()
                DispatchQueue.main.async {
                    self.segmentedControl.isEnabled = false
                }
            }
        }
    }
    
    func loadCalls() {
        APIClient.getCalls(completion: { calls in
            DispatchQueue.main.async {
                if let calls = calls {
                    self.calls = calls
                    self.mapViewController.add(calls: calls)
                    self.infoView.add(calls: calls)
                    self.tableView.reloadData()
                }
            }
        })
    }
}



extension OperatorViewController: NSTableViewDelegate, NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return calls.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var cellIdentifier = ""
        var text = ""
        var image: NSImage?
        let call = calls[row]
        switch tableColumn {
        case tableView.tableColumns[0]:
            cellIdentifier = CellIdentifiers.priorityCell
            image = NSImage(named: "\(call.priority.description().folding(options: .diacriticInsensitive, locale: .current).lowercased())-icon")
            text = call.priority.description()
        case tableView.tableColumns[1]:
            cellIdentifier = CellIdentifiers.descriptionCell
            text = call.shortDescription
        case tableView.tableColumns[2]:
            cellIdentifier = CellIdentifiers.locationCell
            text = call.local
        case tableView.tableColumns[3]:
            cellIdentifier = CellIdentifiers.statusCell
            text = call.status.description()
        default:
            cellIdentifier = ""
        }
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView
        cell?.textField?.stringValue = text
        cell?.imageView?.image = image ?? nil
        return cell
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        guard tableView.selectedRow >= 0 else {
            mapViewController.deselect()
            mapViewController.mockFocus()
            segmentedControl.isEnabled = false
            return
        }
        let call = calls[tableView.selectedRow]
        mapViewController.select(call: call)
        segmentedControl.isEnabled = true
        segmentedControl.selectedSegment = call.status.rawValue
    }
}
