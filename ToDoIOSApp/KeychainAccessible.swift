//
//  KeychainAccessible.swift
//  ToDoIOSApp
//
//  Created by Warit Santaputra on 4/24/16.
//  Copyright © 2016 Warit Santaputra. All rights reserved.
//

import Foundation

protocol KeychainAccessible {
    func setPassword(password: String, account: String)
    
    func deletePasswordForAccount(account: String)
    
    func passwordForAccount(account: String) -> String?
}