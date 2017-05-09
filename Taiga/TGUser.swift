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

