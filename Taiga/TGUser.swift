//
//  TGUser.swift
//  Taiga
//
//  Created by Quang Dat on 5/3/17.
//  Copyright © 2017 Quang Dat. All rights reserved.
//

import UIKit

struct TGUser {
   var fullname = ""
   var username = ""
   var email = ""
    var id = 0
    
    
    init(fullname:String, username:String,email:String,id:Int) {
        self.fullname = fullname
        self.username = username
        self.email = email
        self.id = id
    }
    
    
}
//let actionOK = UIAlertAction(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
//})

//viewController.jsonManager.showAlert("Alert", message:"username and password wrong", actions:[actionOK])


//let vc = viewController.storyboard?.instantiateViewController(withIdentifier: "RegisterView") as! RegisterViewViewController
//viewController.navigationController?.pushViewController(vc, animated: true)
