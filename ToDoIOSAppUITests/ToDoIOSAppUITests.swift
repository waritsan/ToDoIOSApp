//
//  ToDoIOSAppUITests.swift
//  ToDoIOSAppUITests
//
//  Created by Warit Santaputra on 4/27/16.
//  Copyright © 2016 Warit Santaputra. All rights reserved.
//

import XCTest

class ToDoIOSAppUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        let app = XCUIApplication()
        let addButton = app.navigationBars["ToDoIOSApp.ItemListView"].buttons["Add"]
        addButton.tap()
        
        let titleTextField = app.textFields["Title"]
        titleTextField.tap()
        app.textFields["Title"]
        titleTextField.typeText("Meeting")
        
        let saveButton = app.buttons["Save"]
        saveButton.tap()
        
        XCTAssertTrue(app.tables.staticTexts["Meeting"].exists)
    }
}
