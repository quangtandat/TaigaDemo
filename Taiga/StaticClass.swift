//
//  StaticClass.swift
//  Taiga
//
//  Created by Quang Dat on 5/3/17.
//  Copyright © 2017 Quang Dat. All rights reserved.
//

import UIKit

class StaticClass: NSObject {
    static let staticAlertView = StaticClass()
    /**
     show alertView
     
     - parameter title:      title of Alert
     - parameter message:    message whant to show
     - parameter actions:     button in AlertView
     */
    func showAlert(_ title: String?, message: String?,actions:[UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController!.present(alert, animated: true, completion: nil)
            
        }
        
    }
    

}
