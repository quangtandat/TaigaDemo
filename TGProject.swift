//
//  TGProject.swift
//  Taiga
//
//  Created by Quang Dat on 5/8/17.
//  Copyright © 2017 Quang Dat. All rights reserved.
//

import UIKit

struct TGProject {
    var name = ""
    var username = ""
    var description = ""
    var members = [Int]()
    var date = ""
    
    init(name:String,username:String,description: String, members:[Int],date:String) {
        self.name = name
        self.username = username
        self.description = description
        self.members = members
        self.date = date
    }
    
    
}
