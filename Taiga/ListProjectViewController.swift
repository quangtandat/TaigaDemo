//
//  ListProjectViewController.swift
//  Taiga
//
//  Created by Quang Dat on 5/4/17.
//  Copyright © 2017 Quang Dat. All rights reserved.
//

import UIKit

class ListProjectViewController: UIViewController {
var jsonManager = ParseJson()
      var idUser = Int()
     var leftBarButton:UIBarButtonItem = UIBarButtonItem()
     var staticComponent = StaticClass()
    var arrayOfContent = [[String:Any]]()
    var arrayOfName = [TGProject]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        leftBarButton = UIBarButtonItem.init(title: "Log out", style: .plain, target: self, action: #selector(self.logout))
        self.navigationItem.leftBarButtonItem = leftBarButton
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 103
        
        jsonManager.getApi(link: linkGetList.appending(String(idUser)),
        success: {(statusCode,dict) in
            if statusCode != 200{
                
            }
            else if statusCode == 200{
      
                for pointer in dict{
                   
                let name = pointer["name"]
                   var userInfo = pointer["owner"] as! [String:Any]
                  let username = userInfo["username"]
                let projecInfo = TGProject.init(name: name as! String, username: username as! String)
                   self.arrayOfName.append(projecInfo)
                }
              
                  DispatchQueue.main.async {
                self.tableView.reloadData()
                }
            }
        }
        ,failure: {(Bool) in
            let actionOK = UIAlertAction(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
            })
            self.staticComponent.showAlert("Alert", message:"No Internet", actions:[actionOK])
            
        })
         print(idUser)
}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func logout(){

        self.navigationController?.popViewController(animated: true)
    }
}
extension ListProjectViewController:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfName.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ListProjectCell
       // cell.lblName.numberOfLines = 0
        cell.lblName.text = "Project name:" + " ".appending((arrayOfName[indexPath.row].name))
        cell.lblAuthor.text = "User:" + " ".appending((arrayOfName[indexPath.row].username))
        
        return cell
    }
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 103
    }
}
