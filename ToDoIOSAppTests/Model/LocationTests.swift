//
//  LocationTests.swift
//  ToDoIOSApp
//
//  Created by Warit Santaputra on 4/19/16.
//  Copyright © 2016 Warit Santaputra. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ToDoIOSApp

class LocationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit_ShouldSetName() {
        let location = Location(name: "Test name")
        XCTAssertEqual(location.name, "Test name", "Initializer should set name")
    }
    
    func testInit_ShouldSetNameAndCoordinate() {
        let testCoordinate = CLLocationCoordinate2D(latitude: 1, longitude: 2)
        let location = Location(name: "", coordinate: testCoordinate)
        XCTAssertEqual(location.coordinate?.latitude, testCoordinate.latitude, "Initializer should set latitude")
        XCTAssertEqual(location.coordinate?.longitude, testCoordinate.longitude, "Initializer should set longitude")
    }
    
    func testEqualLocations_ShouldBeEqual() {
        let firstLocation = Location(name: "Home")
        let secondLocation = Location(name: "Home")
        
        XCTAssertEqual(firstLocation, secondLocation)
    }
    
    func testWhenLatitudeDifferes_ShouldNotBeEqual() {
        performNotEqualTestWithLocationProperties("Home", secondName: "Home", firstLongLat: (1.0, 0.0), secondLongLat: (0.0, 0.0))
    }
    
    func testWhenLongitudeDifferes_ShouldNotBeEqual() {
        performNotEqualTestWithLocationProperties("Home", secondName: "Home", firstLongLat: (0.0, 1.0), secondLongLat: (0.0, 0.0))
    }
    
    func testWhenOneHasCoordinateAndTheOtherDoesnt_ShouldBeNotEqual() {
        performNotEqualTestWithLocationProperties("Home", secondName: "Home", firstLongLat: (0.0, 0.0), secondLongLat: nil)
    }
    
    func testWhenNameDifferes_ShouldBeNotEqual() {
        performNotEqualTestWithLocationProperties("Home", secondName: "Office", firstLongLat: nil, secondLongLat: nil)
    }
    
    //Helpers
    func performNotEqualTestWithLocationProperties(firstName: String, secondName: String, firstLongLat: (Double, Double)?, secondLongLat: (Double, Double)?) {
        let firstCoordinate: CLLocationCoordinate2D?
        if let firstLongLat = firstLongLat {
            firstCoordinate = CLLocationCoordinate2D(latitude: firstLongLat.0, longitude: firstLongLat.1)
        } else {
            firstCoordinate = nil
        }
        let firstLocation = Location(name: firstName, coordinate: firstCoordinate)
        
        let secondCoordinate: CLLocationCoordinate2D?
        if let secondLongLat = secondLongLat {
            secondCoordinate = CLLocationCoordinate2D(latitude: secondLongLat.0, longitude: secondLongLat.1)
        } else {
            secondCoordinate = nil
        }
        let secondLocation = Location(name: secondName, coordinate: secondCoordinate)
        
        XCTAssertNotEqual(firstLocation, secondLocation, line: #line)
    }
}
