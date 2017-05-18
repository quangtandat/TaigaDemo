//
//  ProjectDetailViewController.swift
//  Taiga
//
//  Created by Quang Dat on 5/17/17.
//  Copyright © 2017 Quang Dat. All rights reserved.
//

import UIKit

class ProjectDetailViewController: ViewController {
var arrayProjectDetail = [TGProject]()
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var lblUsername: UILabel!
   
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var lblMembers: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.view.removeGestureRecognizer(tapGesture)
        NotificationCenter.default.removeObserver(self)
        lblName.text = "Name:" + " ".appending(arrayProjectDetail[0].name)
        lblDescription.text = "Description:" + " ".appending(arrayProjectDetail[0].description)
        lblMembers.text = "Members:" + " ".appending(String(describing: arrayProjectDetail[0].members))
        lblDate.text = "Date:" + " ".appending(arrayProjectDetail[0].date)
        lblUsername.text = "Created by:" + " ".appending(arrayProjectDetail[0].username)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}
