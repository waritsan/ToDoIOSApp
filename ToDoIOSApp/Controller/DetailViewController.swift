//
//  DetailViewController.swift
//  ToDoIOSApp
//
//  Created by Warit Santaputra on 4/23/16.
//  Copyright © 2016 Warit Santaputra. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    var itemInfo: (ItemManager, Int)?
    let dateFormatter: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        guard let itemInfo = itemInfo else {
            return
        }
        let item = itemInfo.0.itemAtIndex(itemInfo.1)
        titleLabel.text = item.title
        descriptionLabel.text = item.itemDescription
        locationLabel.text = item.location?.name
        if let timestamp = item.timestamp {
            let date = NSDate(timeIntervalSince1970: timestamp)
            dateLabel.text = dateFormatter.stringFromDate(date)
        }
        if let coordinate = item.location?.coordinate {
            let region = MKCoordinateRegionMakeWithDistance(coordinate, 100, 100)
            mapView.region = region
        }// end if let coordinate
    }// end func viewWillAppear
    
    func checkItem() {
        if let itemInfo = itemInfo {
            itemInfo.0.checkItemAtIndex(itemInfo.1)
        }
    }
}// end class DetailViewController
