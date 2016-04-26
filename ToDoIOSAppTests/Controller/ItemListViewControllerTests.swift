//
//  ItemListViewControllerTests.swift
//  ToDoIOSApp
//
//  Created by Warit Santaputra on 4/20/16.
//  Copyright © 2016 Warit Santaputra. All rights reserved.
//

import XCTest
@testable import ToDoIOSApp

class ItemListViewControllerTests: XCTestCase {
    var sut: ItemListViewController!
    var inputViewController: InputViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewControllerWithIdentifier("ItemListViewController") as! ItemListViewController
        _ = sut.view
        
        XCTAssertNil(sut.presentedViewController)
        guard let addButton = sut.navigationItem.rightBarButtonItem else {
            XCTFail()
            return
        }
        UIApplication.sharedApplication().keyWindow?.rootViewController = sut
        sut.performSelector(addButton.action, withObject: addButton)
        XCTAssertNotNil(sut.presentedViewController)
        XCTAssertTrue(sut.presentedViewController is InputViewController)
        inputViewController = sut.presentedViewController as! InputViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_TableViewIsNotNillAfterViewDidLoad() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func testViewDidLoad_ShouldSetTableViewDataSource() {
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertTrue(sut.tableView.dataSource is ItemListDataProvider)

    }
    
    func testViewDidLoad_ShouldSetTableViewDelegate() {
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertTrue(sut.tableView.delegate is ItemListDataProvider)
    }
    
    func testViewDidLoad_ShouldSetDelegateAndDataSoureToTheSameObject() {
        XCTAssertEqual(sut.tableView.dataSource as? ItemListDataProvider, sut.tableView.delegate as? ItemListDataProvider)
    }
    
    func testItemListViewController_HasAddBarButtonWithSelfAsTarget() {
        XCTAssertEqual(sut.navigationItem.rightBarButtonItem?.target as? UIViewController, sut)
    }
    
    func testAddItem_PresentsInputViewController() {
        XCTAssertNotNil(inputViewController.titleTextField)
    }
    
    func testItemListVC_SharesItemManagerWithInputVC() {
        guard let inputItemManager = inputViewController.itemManager else {
            XCTFail()
            return
        }
        XCTAssertTrue(sut.itemManager === inputItemManager)
    }
    
    func testViewDidLoad_SetsItemManagerToDataProvider() {
        XCTAssertTrue(sut.itemManager === sut.dataProvider.itemManager)
    }
    
//    func testViewWillAppear_ReloadsTableView() {
//        let mockTableView = MockTableView()
//        sut.tableView = mockTableView
//        sut.beginAppearanceTransition(true, animated: true)
//        sut.endAppearanceTransition()
//        XCTAssertTrue(mockTableView.reloadDataIsCalled)
//    }
}

extension ItemListViewControllerTests {
    class MockTableView: UITableView {
        var reloadDataIsCalled = false
        
        override func reloadData() {
            reloadDataIsCalled = true
        }
    }
}