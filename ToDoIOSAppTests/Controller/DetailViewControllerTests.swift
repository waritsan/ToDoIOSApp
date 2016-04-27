//
//  DetailViewControllerTests.swift
//  ToDoIOSApp
//
//  Created by Warit Santaputra on 4/23/16.
//  Copyright © 2016 Warit Santaputra. All rights reserved.
//

import XCTest
import CoreLocation

@testable import ToDoIOSApp

class DetailViewControllerTests: XCTestCase {
    var sut: DetailViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        _ = sut.view
    }
    
    override func tearDown() {
        sut.itemInfo?.0.removeAllItems()
        super.tearDown()
    }
    
    func test_HasTitleLabel() {
        XCTAssertNotNil(sut.titleLabel)
    }
    
    func test_HasMapView() {
        XCTAssertNotNil(sut.mapView)
    }
    
    func testSettingItemInfo_SetsTextsToLabels() {
        let coordinate = CLLocationCoordinate2D(latitude: 51.2277, longitude: 6.7735)
        let itemManager = ItemManager()
        itemManager.addItem(ToDoItem(title: "The title", itemDescription: "The description", timestamp: 1456150025, location: Location(name: "Home", coordinate: coordinate)))
        sut.itemInfo = (itemManager, 0)
        
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        XCTAssertEqual(sut.titleLabel.text, "The title")
        XCTAssertEqual(sut.dateLabel.text, "22/02/2016")
        XCTAssertEqual(sut.descriptionLabel.text, "The description")
        XCTAssertEqual(sut.locationLabel.text, "Home")
        XCTAssertEqualWithAccuracy(sut.mapView.centerCoordinate.latitude, coordinate.latitude, accuracy: 0.001)
    }
    
    func testCheckItem_ChecksItemInItemManager() {
        let itemManager = ItemManager()
        itemManager.addItem(ToDoItem(title: "The title"))
        sut.itemInfo = (itemManager, 0)
        sut.checkItem()
        XCTAssertEqual(itemManager.toDoCount, 0)
        XCTAssertEqual(itemManager.doneCount, 1)
    }
}
