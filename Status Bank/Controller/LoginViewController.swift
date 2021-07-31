//
//  LoginViewController.swift
//  Status Bank
//
//  Created by admin on 4/10/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Toast_Swift
import MBProgressHUD

class LoginViewController: UIViewController {
    
    var jsonfetch = jasonFetchClass()
    
    @IBOutlet weak var usernameTxt : UITextField!
    @IBOutlet weak var passwordTxt : UITextField!
    @IBOutlet weak var remberBtn : UIButton!
    @IBOutlet weak var submitBtn : UIButton!
    
    @IBOutlet weak var UsernameVW : UIView!
    @IBOutlet weak var PasswordVW : UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        jsonfetch.jsondata = self
        
        usernameTxt.delegate = self
        passwordTxt.delegate = self
        
        textFieldDesigin()
        
 
    }
    
    func textFieldDesigin(){
        
        usernameTxt.textfieldRoundBoderShadow()
         passwordTxt.textfieldRoundBoderShadow()
                
         textfieldpaddingset(textfield: usernameTxt)
         textfieldpaddingset(textfield: passwordTxt)
        
        if  UIDevice.current.model == "iPad"{
        
         let attributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                               .font : UIFont.systemFont(ofSize: 24, weight: .regular)]
            
            usernameTxt.attributedPlaceholder = NSAttributedString(string: "E-mail", attributes:attributes)
              passwordTxt.attributedPlaceholder = NSAttributedString(string: "Password", attributes:attributes)
        }else{
            let attributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray,
            .font : UIFont.systemFont(ofSize: 19, weight: .regular)]
            
            usernameTxt.attributedPlaceholder = NSAttributedString(string: "E-mail", attributes:attributes)
              passwordTxt.attributedPlaceholder = NSAttributedString(string: "Password", attributes:attributes)
        }

  
        
        designBtnLbl(name : remberBtn, radius : 0, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        designBtnLbl(name : submitBtn, radius : 30, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        
        hideKeyboardWhenTappedAround()
        
    }
    
    @IBAction func LogInActn(_ sender: Any){
        ToastManager.shared.style.backgroundColor = UIColor.clear
        ToastManager.shared.style.messageColor = UIColor.red
        ToastManager.shared.style.titleFont =  UIFont.systemFont(ofSize: 20.0)

          
        //  ToastManager.shared.style.messageFont.withSize(20)
          
          if  UIDevice.current.model == "iPad"{
              ToastManager.shared.style.imageSize = CGSize.init(width: 55, height: 55)
              var point : CGPoint = CGPoint(x: 580.0, y: 55.0)
              
              if usernameTxt.text == ""{
                  UsernameVW.makeToast("Fiil in the blank", duration: 2.0, position: .center)
                  usernameTxt.makeToast("", duration: 2.0, point: point, title: "", image: UIImage(named: "warning_icon.png")) { didTap in
                                       if didTap {
                                           print("userNameText completion from tap")
                                       } else {
                                           print("userNameText completion without tap")
                                       }
                                   }
                  }else if passwordTxt.text == ""{
                  PasswordVW.makeToast("Fiil in the blank", duration: 2.0, position: .center)
                   passwordTxt.makeToast("", duration: 2.0, point: point, title: "", image: UIImage(named: "warning_icon.png")) { didTap in
                                       if didTap {
                                           print("emailText completion from tap")
                                       } else {
                                           print("emailText completion without tap")
                                       }
                                   }
              }else{
                
                fetcLoginData()
                
                }
                  
              }else{
            
              ToastManager.shared.style.imageSize = CGSize.init(width: 30, height: 30)
              var point : CGPoint = CGPoint(x: 310.0, y: 30.0)
              
              if usernameTxt.text == ""{
                  UsernameVW.makeToast("Fiil in the blank", duration: 2.0, position: .center)
                  usernameTxt.makeToast("", duration: 2.0, point: point, title: "", image: UIImage(named: "warning_icon.png")) { didTap in
                                       if didTap {
                                           print("userNameText completion from tap")
                                       } else {
                                           print("userNameText completion without tap")
                                       }
                                   }
                  }else if passwordTxt.text == ""{
                  PasswordVW.makeToast("Fiil in the blank", duration: 2.0, position: .center)
                   passwordTxt.makeToast("", duration: 2.0, point: point, title: "", image: UIImage(named: "warning_icon.png")) { didTap in
                                       if didTap {
                                           print("emailText completion from tap")
                                       } else {
                                           print("emailText completion without tap")
                                       }
                                   }
                                }else{
         
                                fetcLoginData()
                          }
                        }
                    }
    
    
    @IBAction func signUpBtnActn(_sender : Any){
        
        let vc = storyboard?.instantiateViewController(identifier: "RegistrationViewController") as! RegistrationViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    func fetcLoginData(){
        let parms = [
                      "actiontype":"login",
                      "user_name":usernameTxt.text!,
                      "password":passwordTxt.text!

                       ]
                      print(parms)
                      
                      MBProgressHUD.showAdded(to: (self.view)!, animated: true)
                      
                      jsonfetch.fetchData(parms, methodtype: "post", url: BaseUrl, jsonname: "Login Code")
        
            }
    
        }
        


extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == usernameTxt
        {
            passwordTxt.becomeFirstResponder()
           
        }
     
        else {
            passwordTxt.resignFirstResponder()
         
        }
       
        return true
        
    }
    

}
extension LoginViewController : jsonDataDelegate{
     func didReceivedData(_ data: Any, jsonname: String) {
         print("Raw Data",data)
         print("jsonname",jsonname)
        
        ToastManager.shared.style.backgroundColor = UIColor.black
        ToastManager.shared.style.messageColor = UIColor.white
        ToastManager.shared.style.titleFont =  UIFont.systemFont(ofSize: 30.0)
        
         if data as? String ==  "NO INTERNET CONNECTION" {
             
             DispatchQueue.main.async {
                 MBProgressHUD.hide(for: (self.view)!, animated: true)
                 }
             
             showAlertMessageokkk(alertTitle: "Network !", alertMsg: "Check your internet connection please")
         }
         else{
            
            var message = ""
              print("codable",data as! NSDictionary)
            
            do{
                let jsonData = try JSONDecoder().decode(loginData.self, from: convertToData(givingValue: data)!)
                print("Status==>",jsonData.data?.status)
             //   print("UserID==>",jsonData.data?.user_id)
              
                message = (jsonData.data?.message)!
                
                if jsonData.data?.status == "Yes"{
                    
                     //UserDefaults.standard.set(true, forKey: "message")
                    
                    UserDefaults.standard.set("User login Successfully.", forKey: "message")
                    store_User_id = jsonData.data?.user_id ?? "0"
                    
                    
                                
                    DispatchQueue.main.async {
                    MBProgressHUD.hide(for: (self.view)!, animated: true)
                            }
                    self.view.makeToast(message , duration: 3.0, position: .bottom)
                                
                    let vc = storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                               
                        }else{
                    
                        DispatchQueue.main.async {
                        MBProgressHUD.hide(for: (self.view)!, animated: true)
                               }
                        self.view.makeToast(message , duration: 3.0, position: .bottom)
                    
                        }
                
            }catch(let err){
                print("error",err.localizedDescription)
            }
            
          DispatchQueue.main.async {
              MBProgressHUD.hide(for: (self.view)!, animated: true)
          }
            self.view.makeToast(message, duration: 3.0, position: .bottom)
                 
             }
        
         }
    
     
     func didFailedReceivedData(_ error: Error) {
         print(error.localizedDescription)
         
             DispatchQueue.main.async {
                 MBProgressHUD.hide(for: (self.view)!, animated: true)
                 }
                  showAlert(title: "Error", message: "Something going wrong,try latter", noOfButton: 1,selectorMethod:())
         }
    
     func convertToData(givingValue: Any) -> Data? {
            return try? JSONSerialization.data(withJSONObject: givingValue, options: [])
     
          }
     
}
