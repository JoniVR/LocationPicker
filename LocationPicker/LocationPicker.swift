//
//  LocationPicker.swift
//  LocationPicker
//
//  Created by Jerome Tan on 3/28/16.
//  Copyright © 2016 Jerome Tan. All rights reserved.
//

import UIKit
import MapKit

@objc public protocol LocationPickerDelegate {
    optional func locationDidSelect(locationItem: LocationItem)
    optional func locationDidPick(locationItem: LocationItem)
    optional func historyLocationAtIndex(index: Int) -> LocationItem
    optional func deleteHistoryLocation(locationItem: LocationItem, AtIndex index: Int)
}



public class LocationPicker: UIViewController {
    
    // MARK: - Completion handler
    
    public var selectCompletion: ((LocationItem) -> Void)?
    public var pickCompletion: ((LocationItem) -> Void)?
    
    // MARK: Optional varaiables
    
    public var delegate: LocationPickerDelegate?
    public var historyLocationList: [LocationItem]?
    public var doneButtonItem: UIBarButtonItem?
    
    // MARK: Configurations
    
    public var mapViewDraggable = true
    public var historyLocationEditable = true
    public var divideSection = false
    
    public var currentLocationColor = UIColor.blackColor()
    public var searchResultLocationColor = UIColor.blackColor()
    public var historyLocationColor = UIColor.blackColor()
    public var pinColor = UIColor.blackColor()
    
    public var currentLocationImage = UIImage()
    public var searchResultLocationImage = UIImage()
    public var historyLocationImage = UIImage()
    
    
    
    private var selectedLocationItem: LocationItem?
    
    private let searchBar = UISearchBar()
    private let tableView = UITableView()

    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    public override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let locationItem = selectedLocationItem {
            locationDidPick(locationItem)
        }
    }
    
    
    
    public func setThemeColor(color: UIColor) {
        currentLocationColor = color
        searchResultLocationColor = color
        historyLocationColor = color
        pinColor = color
    }
    
    
    
    public func locationDidSelect(locationItem: LocationItem) {
        enableDoneButton()
        selectCompletion?(locationItem)
        delegate?.locationDidSelect?(locationItem)
        NSNotificationCenter.defaultCenter().postNotificationName("LocationSelect", object: locationItem)
    }
    
    public func locationDidPick(locationItem: LocationItem) {
        pickCompletion?(locationItem)
        delegate?.locationDidSelect?(locationItem)
        NSNotificationCenter.defaultCenter().postNotificationName("LocationPick", object: locationItem)
    }
    
    
    
    private func setupViews() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        view.backgroundColor = UIColor.whiteColor()
        
        
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = view.layoutMarginsGuide
        
        searchBar.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor).active = true
        searchBar.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor, constant: -view.layoutMargins.left * 2).active = true
        searchBar.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor, constant: view.layoutMargins.right * 2).active = true
        
        tableView.topAnchor.constraintEqualToAnchor(searchBar.bottomAnchor).active = true
        tableView.leadingAnchor.constraintEqualToAnchor(searchBar.leadingAnchor).active = true
        tableView.trailingAnchor.constraintEqualToAnchor(searchBar.trailingAnchor).active = true
        tableView.bottomAnchor.constraintEqualToAnchor(bottomLayoutGuide.topAnchor).active = true
    }
    
    
    
    private func enableDoneButton() {
        if let doneButtonItem = doneButtonItem {
            doneButtonItem.enabled = true
        }
    }
    
}