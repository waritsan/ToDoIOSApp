//
//  ItemListDataProvider.swift
//  ToDoIOSApp
//
//  Created by Warit Santaputra on 4/20/16.
//  Copyright © 2016 Warit Santaputra. All rights reserved.
//

import UIKit

class ItemListDataProvider: NSObject, UITableViewDataSource {
    var itemManager: ItemManager!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let itemManager = itemManager
            else { return 0 }
        guard let itemSection = Section(rawValue: section)
            else { fatalError() }
        let numberOfRows: Int
        switch itemSection {
        case .ToDo:
            numberOfRows = itemManager.toDoCount
        case .Done:
            numberOfRows = itemManager.doneCount
            print(numberOfRows)
        }
        return numberOfRows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return ItemCell()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
}

enum Section: Int {
    case ToDo
    case Done
}