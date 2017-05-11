//
//  RegisterViewViewController.swift
//  Taiga
//
//  Created by Quang Dat on 4/28/17.
//  Copyright © 2017 Quang Dat. All rights reserved.
//

import UIKit
protocol didGetData {
    func getData(username:String, password: String)
}
class RegisterViewViewController: UIViewController {
    var delegate: didGetData?
var jsonManager = ParseJson()
    var userInfo = [TGUser]()
  
    var staticComponent = StaticClass()
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtFullname: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var constraintBottomScroolView: NSLayoutConstraint!
    
    @IBOutlet weak var topConstraintNavigationBar: NSLayoutConstraint!
    @IBOutlet weak var navigationBar: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
         NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(self.isTap))
        self.view.addGestureRecognizer(tapGesture)
        NotificationCenter.default.addObserver(self, selector: #selector(self.isLanscape), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func isLanscape(){
        if(UIDevice.current.orientation.isLandscape){
          topConstraintNavigationBar.constant = 0
        }
        else{
            topConstraintNavigationBar.constant = 20
        }

    
    }
    func isTap(){
        constraintBottomScroolView.constant = 50
        self.view.endEditing(true)
    }
    func keyboardWillShow(notification: NSNotification){
        var height = CGFloat()
       // print(UIScreen.main.bounds.height)
        let screenSize = UIScreen.main.bounds.height
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            height = keyboardSize.height
        }
        if (txtUsername.isFirstResponder){
            if height - txtUsername.frame.maxY  > screenSize {
                let addConstant = constraintBottomScroolView.constant + height
                constraintBottomScroolView.constant  = addConstant
                scrollView.setContentOffset(CGPoint(x: 0, y: txtUsername.frame.minY - 80), animated: true)
        }
        }
        else if (txtPassword.isFirstResponder){
                if height + txtPassword.frame.maxY  > screenSize {
                    let addConstant = constraintBottomScroolView.constant + height
                    constraintBottomScroolView.constant  = addConstant
                    scrollView.setContentOffset(CGPoint(x: 0, y: txtPassword.frame.minY - 80), animated: true)
        }
            }
        else if txtEmail.isFirstResponder{
                    if height + txtEmail.frame.maxY > screenSize {
                        let addConstant = constraintBottomScroolView.constant + height
                        constraintBottomScroolView.constant  = addConstant
                        scrollView.setContentOffset(CGPoint(x: 0, y: txtEmail.frame.minY - 80), animated: true)
        }
}
        else{
                        if height + txtFullname.frame.maxY  > screenSize {
                            let addConstant = constraintBottomScroolView.constant + height
                            constraintBottomScroolView.constant  = addConstant
                            scrollView.setContentOffset(CGPoint(x: 0, y: txtFullname.frame.minY - 80), animated: true)
        }
    
    }
    }
    
        @IBAction func btnRegister(_ sender: AnyObject) {
        var username = txtUsername.text
            username = username?.trimmingCharacters(in: .whitespaces)
        var password = txtPassword.text
           password = password?.trimmingCharacters(in: .whitespaces)
        var email    = txtEmail.text
             email = email?.trimmingCharacters(in: .whitespaces)
        var fullName = txtFullname.text
             fullName = fullName?.trimmingCharacters(in: .whitespaces)
        jsonManager.signIn(parameter: ["email":email!, "full_name":fullName! , "password":password!,"type":"public","username":username!],link: linkSignUp,success: {(statusCode,dict)-> Void in
            if statusCode != 201{
                let actionOK = UIAlertAction(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
                })
                if let sessions = dict["email"] as? [String] {
                    let sessionInfo = sessions[0]
                self.showAlert("Alert", message:sessionInfo , actions:[actionOK])
                }
                if let sessions = dict["password"] as? [String] {
                    let sessionInfo = sessions[0]
                    self.showAlert("Alert", message:sessionInfo  , actions:[actionOK])
                }
                if let sessions = dict["full_name"] as? [String] {
                    let sessionInfo = sessions[0]
                    self.showAlert("Alert", message:sessionInfo  , actions:[actionOK])
                }
                if let sessions = dict["username"] as? [String] {
                    let sessionInfo = sessions[0]
                    self.showAlert("Alert", message:sessionInfo , actions:[actionOK])
                }
                if let sessions =  dict["_error_message"] as? String{
                    self.showAlert("Alert", message:sessions , actions:[actionOK])
                }
            }
            else{
                let actionOK = UIAlertAction(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
                  self.delegate?.getData(username: username!, password: password!)
                    self.dismiss(animated: true, completion: nil)
                    
                  
                })
                self.showAlert("Alert", message:"Success", actions:[actionOK])
            }
            },failure: {(Bool) in
                
                let actionOK = UIAlertAction(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
                })
                self.showAlert("Alert", message:"No Internet", actions:[actionOK])

        })
    }
    func showAlert(_ title: String?, message: String?,actions:[UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        DispatchQueue.main.async {
           self.present(alert, animated: true, completion: nil)
            
        }
    }
    
}
extension RegisterViewViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        }
        else{
            let username = txtUsername.text
            let password = txtPassword.text
            let email    = txtEmail.text
            let fullName = txtFullname.text
            jsonManager.signIn(parameter: ["email":email!, "full_name":fullName! , "password":password!,"type":"public","username":username!],link: linkSignUp,success: {(statusCode,dict)-> Void in
                if statusCode != 201{
                    let actionOK = UIAlertAction(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
                    })
                    if let sessions = dict["email"] as? [String] {
                        let sessionInfo = sessions[0]
                        self.staticComponent.showAlert("Alert", message:sessionInfo , actions:[actionOK])
                    }
                    if let sessions = dict["password"] as? [String] {
                        let sessionInfo = sessions[0]
                        self.staticComponent.showAlert("Alert", message:sessionInfo  , actions:[actionOK])
                    }
                    if let sessions = dict["full_name"] as? [String] {
                        let sessionInfo = sessions[0]
                        self.staticComponent.showAlert("Alert", message:sessionInfo  , actions:[actionOK])
                    }
                    if let sessions = dict["username"] as? [String] {
                        let sessionInfo = sessions[0]
                        self.staticComponent.showAlert("Alert", message:sessionInfo , actions:[actionOK])
                    }
                    if let sessions = dict["_error_message"] as? String{
                        self.staticComponent.showAlert("Alert", message:sessions , actions:[actionOK])
                    }
                }
                },failure: {(Bool) in
                   
                    let actionOK = UIAlertAction(title: "Ok", style: .default, handler: { (action:UIAlertAction) in
                    })
                    self.staticComponent.showAlert("Alert", message:"No Internet", actions:[actionOK])
                    
            })
        

        }
        return true
    }

}
