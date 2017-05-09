//
//  ParseJson.swift
//  Taiga
//
//  Created by Quang Dat on 4/28/17.
//  Copyright © 2017 Quang Dat. All rights reserved.
//

import UIKit

class ParseJson: NSObject {
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    func signIn(parameter:[String:String], link:String, success: @escaping (_ statusCode:Int,_ dict:[String:Any]) -> Void,
                failure: @escaping (Bool) -> Void) {
        var dict = [String:Any]()
        var request = URLRequest(url: URL(string: link)!)
        
        let parameter = parameter
        request.httpMethod = "POST"
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted)
        }
        catch let error{
            print(error.localizedDescription)
        }
        request.addValue(contentTypeValue, forHTTPHeaderField: contentTypeKey)
        request.addValue(authorizationValue, forHTTPHeaderField: authorizationKey)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                failure(true)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                let responseString = String(data: data, encoding:.utf8)
                dict = self.convertToDictionary(text: responseString!)!
               // completionHandler(httpStatus.statusCode,dict)
              success(httpStatus.statusCode,dict)
                
            }
            else{
                 let httpStatus = response as? HTTPURLResponse
               print(httpStatus?.statusCode)
                let responseString = String(data: data, encoding:.utf8)
                dict = self.convertToDictionary(text: responseString!)!
               // completionHandler((httpStatus?.statusCode)!,dict)
                success((httpStatus?.statusCode)!,dict)
            }
          
           print(dict)
           
           
        }
        task.resume()
     
    }
    func getApi( link:String, success: @escaping (_ statusCode:Int,_ dict:[[String:Any]]) -> Void,
                 failure: @escaping (Bool) -> Void) {
       
        var request = URLRequest(url: URL(string: link)!)
        
        
        request.httpMethod = "GET"
        request.addValue(contentTypeValue, forHTTPHeaderField: contentTypeKey)
        request.addValue(authorizationValue, forHTTPHeaderField: authorizationKey)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                failure(true)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                
                
            }
            else{
                 let httpStatus = response as? HTTPURLResponse
                let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String:Any]]
                  success((httpStatus?.statusCode)!,json)
            }
            
            
            
            
        }
        task.resume()
        
    }

    
   
   }
