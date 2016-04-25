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
        // completionHandler
        let task = session.dataTaskWithURL(url) {
            (data, response, error) -> Void in
            if error != nil {
                completion(WebserviceError.ResponseError)
                return
            }
            if data != nil {
                do {
                    let responseDict = try
                        NSJSONSerialization.JSONObjectWithData(data!, options: [])
                    let token = responseDict["token"] as! String
                    self.keychainManager?.setPassword(token, account: "token")
                } catch {
                    completion(error)
                }// end catch
            } else {
                completion(WebserviceError.DataEmptyError)
            }// end if/else let theData = data
        }// end completionHandler
        task.resume()
    }
}

protocol ToDoURLSession {
    func dataTaskWithURL(url: NSURL, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask
}

extension NSURLSession: ToDoURLSession {
}

enum WebserviceError: ErrorType {
    case DataEmptyError
    case ResponseError
}