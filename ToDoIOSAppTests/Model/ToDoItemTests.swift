//
//  ToDoItemTests.swift
//  ToDoIOSApp
//
//  Created by Warit Santaputra on 4/19/16.
//  Copyright © 2016 Warit Santaputra. All rights reserved.
//

import XCTest
@testable import ToDoIOSApp

class ToDoItemTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit_ShouldTakeTitle() {
        let item = ToDoItem(title: "Test title")
        XCTAssertEqual(item.title, "Test title", "Test title, initializer should set the item title")
    }
    
    func testInit_ShouldTakeTitleAndDescription() {
        let item = ToDoItem(title: "Test title", itemDescription: "Test description")
        XCTAssertEqual(item.itemDescription, "Test description", "Test description, initializer should set the item description")
    }
    
    func testInit_ShouldTakeTitleAndDescriptionAndTimestamp() {
        let item = ToDoItem(title: "Test title", itemDescription: "Test description", timestamp: 0.0)
        XCTAssertEqual(item.timestamp, 0.0, "Test timestamp, initializer should set the item timestamp")
    }
    
    func testInit_ShouldTestTitleAndDescriptionAndTimestampAndLocation() {
        let location = Location(name: "Test name")
        let item = ToDoItem(title: "Test title", itemDescription: "Test description", timestamp: 0.0, location: location)
        XCTAssertEqual(location.name, item.location?.name, "Test location, initializer should set the item location")
    }
}
