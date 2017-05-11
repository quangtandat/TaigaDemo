//
//  ViewController.swift
//  Taiga
//
//  Created by Quang Dat on 4/27/17.
//  Copyright © 2017 Quang Dat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
var jsonManager = ParseJson()
   var staticComponent = StaticClass()
    var userInfo = [TGUser]()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contraintScrollView: NSLayoutConstraint!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
       NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(self.isTap))
        self.view.addGestureRecognizer(tapGesture)
        NotificationCenter.default.addObserver(self, selector: #selector(self.isLanscape), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardIsHide), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
      

}
    override func viewWillAppear(_ animated: Bool) {
        userInfo.removeAll()
    }
        
    
    
    func keyboardIsHide(){
        contraintScrollView.constant = 50
    }
    func isLanscape(){
        if(UIDevice.current.orientation.isLandscape){
           scrollView.setContentOffset(CGPoint(x: 0, y: txtUsername.frame.minY - 80), animated: true)
        }
        else{
        print("portrait")
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        var height = CGFloat()
         let screenSize = UIScreen.main.bounds.height
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            height = keyboardSize.height
        }
        if (txtUsername.isFirstResponder)
        {
            print(height + txtUsername.frame.maxY)
            if height + txtUsername.frame.maxY + 60 > screenSize{
            let addConstant = contraintScrollView.constant + height
            contraintScrollView.constant  = addConstant
            scrollView.setContentOffset(CGPoint(x: 0, y: (height + txtUsername.frame.maxY + 60) - screenSize), animated: true)
        }
    }
        else{
                print(height + txtPassword.frame.maxY + 60)
          print(UIScreen.main.bounds.height)
            if height + txtPassword.frame.maxY + 60 > screenSize{
            let addConstant = contraintScrollView.constant + height
            contraintScrollView.constant  = addConstant
            scrollView.setContentOffset(CGPoint(x: 0, y:(height + txtUsername.frame.maxY + 60) - screenSize), animated: true)
        }
        
    }

    }
    func isTap(){
         contraintScrollView.constant = 50
    self.view.endEditing(true)
    }
    
    
    
    func login(){
        let username = txtUsername.text
        let password = txtPassword.text
        jsonManager.signIn(parameter: ["password":password!,"type":"normal","username":username!],link: linkSignIn,success: {(statusCode,dict) in
            if statusCode != 200{
                let actionOK = UIAlertAction(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
                })
                self.staticComponent.showAlert("Alert", message:dict["_error_message"] as! String?, actions:[actionOK])
            }
            else if statusCode == 200{
                self.userInfo.append(TGUser.init(fullname: dict["full_name"] as! String, username: dict["username"] as! String, email:dict["email"] as! String,id:dict["id"] as! Int))
                print(self.userInfo)
                DispatchQueue.main.async {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListProjectViewController") as! ListProjectViewController
                       vc.idUser = self.userInfo[0].id
                  
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            }
            ,failure: {(Bool) in
                let actionOK = UIAlertAction(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
                })
                self.staticComponent.showAlert("Alert", message:"No Internet", actions:[actionOK])
                
        })
    }
    
    
    
    
    @IBAction func btnRegister(_ sender: AnyObject) {
       
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterView") as! RegisterViewViewController
        vc.delegate = self
     
        self.navigationController?.present(vc, animated: true, completion: nil)
       
    }
    
    @IBAction func btnLogin(_ sender: AnyObject) {
        self.login()
        
           }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}
extension ViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        }
        else{
            let username = txtUsername.text
            let password = txtPassword.text
            jsonManager.signIn(parameter: ["password":password!,"type":"normal","username":username!],link: linkSignIn,success: {(statusCode,dict) in
                if statusCode != 200{
                    let actionOK = UIAlertAction(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
                    })
                    self.staticComponent.showAlert("Alert", message:dict["_error_message"] as! String?, actions:[actionOK])
                }
                else if statusCode == 200{
                    self.userInfo.append(TGUser.init(fullname: dict["full_name"] as! String, username: dict["username"] as! String, email:dict["email"] as! String,id:dict["id"] as! Int))
                    print(self.userInfo)
                    DispatchQueue.main.async {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListProjectViewController") as! ListProjectViewController
                          vc.idUser = self.userInfo[0].id
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                }
                ,failure: {(Bool) in
                    let actionOK = UIAlertAction(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
                    })
                    self.staticComponent.showAlert("Alert", message:"No Internet", actions:[actionOK])
                    
            })

        }
        return true
    }
   

}
// Delegate
extension ViewController:didGetData{
    func getData(username: String, password: String) {
        self.txtUsername.text = username
        self.txtPassword.text = password
         self.login()
    }
}






