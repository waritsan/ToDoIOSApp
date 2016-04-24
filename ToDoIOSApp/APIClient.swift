//
//  APIClient.swift
//  ToDoIOSApp
//
//  Created by Warit Santaputra on 4/24/16.
//  Copyright © 2016 Warit Santaputra. All rights reserved.
//

import Foundation

class APIClient {
    lazy var session: ToDoURLSession = NSURLSession.sharedSession()
    var keychainManager: KeychainAccessible?
    
    func loginUserWithName(username: String, password: String, completion: (ErrorType?) -> Void) {
        let allowedCharacters = NSCharacterSet(charactersInString: "/%&=?$#+-~@<>|\\*,.()[]{}^!").invertedSet
        guard let encodedUsername = username.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters) else {
            fatalError()
        }
        guard let encodedPassword = password.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters) else {
            fatalError()
        }
        
        guard let url = NSURL(string: "https://awesometodos.com/login?username=\(encodedUsername)&password=\(encodedPassword)") else {
            fatalError()
        }
        let task = session.dataTaskWithURL(url) {
            (data, response, error) -> Void in
            let responseDict = try!
                NSJSONSerialization.JSONObjectWithData(data!, options: [])
            let token = responseDict["token"] as! String
            self.keychainManager?.setPassword(token, account: "token")
        }
        task.resume()
    }
}

protocol ToDoURLSession {
    func dataTaskWithURL(url: NSURL, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask
}

extension NSURLSession: ToDoURLSession {
    
}