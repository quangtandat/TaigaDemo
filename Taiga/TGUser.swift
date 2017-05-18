//
//  TGUser.swift
//  Taiga
//
//  Created by Quang Dat on 5/3/17.
//  Copyright © 2017 Quang Dat. All rights reserved.
//

import UIKit

class TGUser:NSObject,NSCoding {
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
    required init(coder aDecoder: NSCoder) {
        super.init()
         self.id = aDecoder.decodeInteger(forKey: "id")
         self.username = aDecoder.decodeObject(forKey: "username") as! String
        self.email = aDecoder.decodeObject(forKey: "email") as! String
        self.fullname = aDecoder.decodeObject(forKey: "fullname") as! String
       
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(username, forKey: "username")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(fullname, forKey: "fullname")
    }
    static func currentUser() -> TGUser?{
        var user : TGUser? = nil
        let data = UserDefaults.standard.value(forKey: "currentUser") as! Data?
        if(data != nil){
            user = NSKeyedUnarchiver.unarchiveObject(with: data!) as! TGUser?
        }
        return user
    }

    
    
    func save() {
        let data = NSKeyedArchiver.archivedData(withRootObject: self)
        UserDefaults.standard.set(data, forKey: "currentUser")
        print(data)
    }
    func clear() {
        UserDefaults.standard.removeObject(forKey: "currentUser")
    }
}

