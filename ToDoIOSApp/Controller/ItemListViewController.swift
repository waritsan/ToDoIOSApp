//
//  ItemListViewController.swift
//  ToDoIOSApp
//
//  Created by Warit Santaputra on 4/20/16.
//  Copyright © 2016 Warit Santaputra. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var dataProvider: protocol<UITableViewDelegate, UITableViewDataSource, ItemManagerSettable>!
    let itemManager = ItemManager()
    
    override func viewDidLoad() {
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
        dataProvider.itemManager = itemManager
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func addItem(sender: UIBarButtonItem) {
        if let nextViewController = storyboard?.instantiateViewControllerWithIdentifier("InputViewController") as? InputViewController {
            nextViewController.itemManager = self.itemManager
            presentViewController(nextViewController, animated: true, completion: nil)
        }
    }//end addItem(_)
}// end class ItemListViewController