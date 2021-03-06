//
//  InputViewControllerTests.swift
//  ToDoIOSApp
//
//  Created by Warit Santaputra on 4/23/16.
//  Copyright © 2016 Warit Santaputra. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ToDoIOSApp

class InputViewControllerTests: XCTestCase {
    var sut: InputViewController!
    var placemark: MockPlacemark!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewControllerWithIdentifier("InputViewController") as! InputViewController
        _ = sut.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_HasTextFieldsAndButtons() {
        XCTAssertNotNil(sut.titleTextField)
        XCTAssertNotNil(sut.dateTextField)
        XCTAssertNotNil(sut.addressTextField)
        XCTAssertNotNil(sut.descriptionTextField)
        XCTAssertNotNil(sut.saveButton)
        XCTAssertNotNil(sut.cancelButton)
    }
    
    func testSave_UsesGeoCoderToGetCoordinateFromAddress() {
        let mockInputViewController = MockInputViewController()
        
        mockInputViewController.titleTextField = UITextField()
        mockInputViewController.dateTextField = UITextField()
        mockInputViewController.locationTextField = UITextField()
        mockInputViewController.addressTextField = UITextField()
        mockInputViewController.descriptionTextField = UITextField()
        
        mockInputViewController.titleTextField.text = "Test Title"
        mockInputViewController.dateTextField.text = "22/02/2016"
        mockInputViewController.locationTextField.text = "Office"
        mockInputViewController.addressTextField.text = "Infinite Lopp 1, Cupertino"
        mockInputViewController.descriptionTextField.text = "Test Description"
        
        let mockGeocoder = MockGeocoder()
        mockInputViewController.geocoder = mockGeocoder
        
        mockInputViewController.itemManager = ItemManager()
        
        let expectation = expectationWithDescription("bla")
        mockInputViewController.completionHandler = {
            expectation.fulfill()
        }
        
        mockInputViewController.save()
        
        placemark = MockPlacemark()
        let coordinate = CLLocationCoordinate2DMake(37.3316851, -122.0300674)
        placemark.mockCoordinate = coordinate
        mockGeocoder.completionHandler?([placemark], nil)
        
        waitForExpectationsWithTimeout(1, handler: nil)
        
        let item = mockInputViewController.itemManager?.itemAtIndex(0)
        let testItem = ToDoItem(title: "Test Title", itemDescription: "Test Description", timestamp: 1456074000, location: Location(name: "Office", coordinate: coordinate))
        XCTAssertEqual(item, testItem)
    }
    
    func testSave_NotAddItemIfTitleIsEmpty() {
        sut.titleTextField.text = ""
        sut.itemManager = ItemManager()
        sut.save()
        XCTAssertEqual(sut.itemManager?.toDoCount, 0)
    }
    
    func test_SaveButtonHasSaveAction() {
        let saveButton: UIButton = sut.saveButton
        guard let actions = saveButton.actionsForTarget(sut, forControlEvent: .TouchUpInside) else {
            XCTFail()
            return
        }
        XCTAssertTrue(actions.contains("save"))
    }
    
    // Need internet access
    func xtest_GeocoderWordsAsExpected() {
        let expectation = expectationWithDescription("Wait for geocode")
        CLGeocoder().geocodeAddressString("Infinite Loop 1, Cupertino") {
            (placemarks, error) -> Void in
            let placemark = placemarks?.first
            let coordinate = placemark?.location?.coordinate
            guard let latitude = coordinate?.latitude else {
                XCTFail()
                return
            }
            guard let longitude = coordinate?.longitude else {
                XCTFail()
                return
            }
            XCTAssertEqualWithAccuracy(latitude, 37.3316941, accuracy: 0.000001)
            XCTAssertEqualWithAccuracy(longitude, -122.030127, accuracy: 0.000001)
            expectation.fulfill()
        }
        waitForExpectationsWithTimeout(3, handler: nil)
    }
    
    func testSave_DismissesViewController() {
        let mockInputViewController = MockInputViewController()
        mockInputViewController.titleTextField = UITextField()
        mockInputViewController.dateTextField = UITextField()
        mockInputViewController.locationTextField = UITextField()
        mockInputViewController.addressTextField = UITextField()
        mockInputViewController.descriptionTextField = UITextField()
        mockInputViewController.titleTextField.text = "Test Title"
        mockInputViewController.save()
        XCTAssertTrue(mockInputViewController.dismissGotCalled)
    }
}

extension InputViewControllerTests {
    class MockGeocoder: CLGeocoder {
        var completionHandler: CLGeocodeCompletionHandler?
        
        override func geocodeAddressString(addressString: String, completionHandler: CLGeocodeCompletionHandler) {
            self.completionHandler = completionHandler
        }
    }// end class MockGeocoder
    
    class MockPlacemark: CLPlacemark {
        var mockCoordinate: CLLocationCoordinate2D?
        
        override var location: CLLocation? {
            guard let coordinate = mockCoordinate else {
                return CLLocation()
            }
            return CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        }
    }// end class MockPlacemark
    
    class MockInputViewController: InputViewController {
        var dismissGotCalled = false
        var completionHandler: (() -> Void)?
        
        override func dismissViewControllerAnimated(flag: Bool, completion: (() -> Void)?) {
            dismissGotCalled = true
            completionHandler?()
        }
    }// end class MockInputViewController
}// end extension InputViewControllerTests