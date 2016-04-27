//
//  ItemManager.swift
//  ToDoIOSApp
//
//  Created by Warit Santaputra on 4/19/16.
//  Copyright © 2016 Warit Santaputra. All rights reserved.
//

import UIKit

class ItemManager: NSObject {
    var toDoCount: Int { return toDoItems.count }
    var doneCount: Int { return doneItems.count }
    private var toDoItems = [ToDoItem]()
    private var doneItems = [ToDoItem]()
    var toDoPathURL: NSURL {
        let fileURLs = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        guard let documentURL = fileURLs.first else {
            print("Something went wrong. Documents url could not be found")
            fatalError()
        }
        return documentURL.URLByAppendingPathComponent("toDoItems.plist")
    }
    
    override init() {
        super.init()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ItemManager.save), name: UIApplicationWillResignActiveNotification, object: nil)
        if let nsTodoItems = NSArray(contentsOfURL: toDoPathURL) {
            for dict in nsTodoItems {
                if let toDoItem = ToDoItem(dict: dict as! NSDictionary) {
                    toDoItems.append(toDoItem)
                }
            }
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        save()
    }

    func save() {
        var nsToDoItems = [AnyObject]()
        
        for item in toDoItems {
            nsToDoItems.append(item.plistDict)
        }
        if nsToDoItems.count > 0 {
            (nsToDoItems as NSArray).writeToURL(toDoPathURL, atomically: true)
        } else {
            do {
                try NSFileManager.defaultManager().removeItemAtURL(toDoPathURL)
            } catch {
                print(error)
            }
        }
    }
    
    func addItem(item: ToDoItem) {
        if !toDoItems.contains(item) {
            toDoItems.append(item)
        }
    }
    
    func itemAtIndex(index: Int) -> ToDoItem {
        return toDoItems[index]
    }
    
    func checkItemAtIndex(index: Int) {
        let item = toDoItems.removeAtIndex(index)
        doneItems.append(item)
    }
    
    func uncheckItemAtIndex(index: Int) {
        let item = doneItems.removeAtIndex(index)
        toDoItems.append(item)
    }
    
    func doneItemAtIndex(index: Int) -> ToDoItem {
        return doneItems[index]
    }
    
    func removeAllItems() {
        toDoItems.removeAll()
        doneItems.removeAll()
    }
}