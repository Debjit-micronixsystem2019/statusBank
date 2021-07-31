//
//  RegistrationViewController.swift
//  Status Bank
//
//  Created by admin on 4/10/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import MBProgressHUD
import Toast_Swift

class RegistrationViewController: UIViewController {
    
    var jsonfetch = jasonFetchClass()
    @IBOutlet weak var userNameVW : UIView!
    @IBOutlet weak var emailVW : UIView!
    @IBOutlet weak var passwordVw : UIView!
    @IBOutlet weak var repasswordVW : UIView!
    
  
    @IBOutlet weak var userNameText : UITextField!
    @IBOutlet weak var emailText : UITextField!
    @IBOutlet weak var passwordText : UITextField!
    @IBOutlet weak var repasswordText : UITextField!
    
    @IBOutlet weak var remberBtn : UIButton!
    @IBOutlet weak var submitBtn : UIButton!
    
    @IBOutlet weak var scroolVW : UIScrollView!
    @IBOutlet weak var mainVw : UIView!
    
     @IBOutlet weak var constatnt : NSLayoutConstraint!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        jsonfetch.jsondata = self
        
        userNameText.delegate = self
        emailText.delegate = self
        passwordText.delegate = self
        repasswordText.delegate = self
                
                textFieldDesigin()
 
        
        //Mark: for scrollview width fixed
        print(UIScreen.main.bounds.width)
   
         if  UIDevice.current.model == "iPad"{
            constatnt.constant = 528
         }else{
            if UIScreen.main.bounds.width == 375.0{
            constatnt.constant = 257
            }else if UIScreen.main.bounds.width == 414.0{
                constatnt.constant = 284
                }
           }
        
    }
            
        func textFieldDesigin(){
                userNameText.textfieldRoundBoderShadow()
                emailText.textfieldRoundBoderShadow()
                passwordText.textfieldRoundBoderShadow()
                repasswordText.textfieldRoundBoderShadow()
                        
                 textfieldpaddingset(textfield: userNameText)
                 textfieldpaddingset(textfield: emailText)
                 textfieldpaddingset(textfield: passwordText)
                 textfieldpaddingset(textfield: repasswordText)
            
            if  UIDevice.current.model == "iPad"{
                
            let attributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                                       .font : UIFont.systemFont(ofSize: 24, weight: .regular)]

            userNameText.attributedPlaceholder = NSAttributedString(string: "User Name", attributes:attributes)
            emailText.attributedPlaceholder = NSAttributedString(string: "E-mail", attributes:attributes)
            passwordText.attributedPlaceholder = NSAttributedString(string: "Password", attributes:attributes)
            repasswordText.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes:attributes)
                
            }else{
                
            let attributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                                       .font : UIFont.systemFont(ofSize: 19, weight: .regular)]

            userNameText.attributedPlaceholder = NSAttributedString(string: "User Name", attributes:attributes)
            emailText.attributedPlaceholder = NSAttributedString(string: "E-mail", attributes:attributes)
            passwordText.attributedPlaceholder = NSAttributedString(string: "Password", attributes:attributes)
            repasswordText.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes:attributes)
                
            }
                  
            designBtnLbl(name : remberBtn, radius : 0, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
            designBtnLbl(name : submitBtn, radius : 30, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
                
                hideKeyboardWhenTappedAround()
                
            }
    
    
    func sendRegistrationdata(){
        
               let parms = [
               "actiontype":"register",
               "user_name":userNameText.text!,
               "email":emailText.text!,
               "password":passwordText.text!

                ]
               print(parms)
               
               MBProgressHUD.showAdded(to: (self.view)!, animated: true)
               
               jsonfetch.fetchData(parms, methodtype: "post", url: BaseUrl , jsonname: "Login Code")
        
    }
    
    
    
    @IBAction func RegistrationActn(_ sender : Any){
        ToastManager.shared.style.backgroundColor = UIColor.clear
        ToastManager.shared.style.messageColor = UIColor.red
        ToastManager.shared.style.titleFont =  UIFont.systemFont(ofSize: 20.0)

        
      //  ToastManager.shared.style.messageFont.withSize(20)
        
        if  UIDevice.current.model == "iPad"{
            ToastManager.shared.style.imageSize = CGSize.init(width: 55, height: 55)
            var point : CGPoint = CGPoint(x: 580.0, y: 55.0)
            
            if userNameText.text == ""{
                userNameVW.makeToast("Fiil in the blank", duration: 2.0, position: .center)
                userNameText.makeToast("", duration: 2.0, point: point, title: "", image: UIImage(named: "warning_icon.png")) { didTap in
                                     if didTap {
                                         print("userNameText completion from tap")
                                     } else {
                                         print("userNameText completion without tap")
                                     }
                                 }
                }else if emailText.text == ""{
                emailVW.makeToast("Fiil in the blank", duration: 2.0, position: .center)
                 emailText.makeToast("", duration: 2.0, point: point, title: "", image: UIImage(named: "warning_icon.png")) { didTap in
                                     if didTap {
                                         print("emailText completion from tap")
                                     } else {
                                         print("emailText completion without tap")
                                     }
                                 }
                
            }else if passwordText.text == ""{
                passwordVw.makeToast("Fiil in the blank", duration: 2.0, position: .center)
                 passwordText.makeToast("", duration: 2.0, point: CGPoint(x: 310.0, y: 30.0), title: "", image: UIImage(named: "warning_icon.png")) { didTap in
                                     if didTap {
                                         print("passwordText completion from tap")
                                     } else {
                                         print("passwordText completion without tap")
                                     }
                                 }
                
            }else if repasswordText.text == ""{
                repasswordVW.makeToast("Fiil in the blank", duration: 2.0, position: .center)
                 repasswordText.makeToast("", duration: 2.0, point: point, title: "", image: UIImage(named: "warning_icon.png")) { didTap in
                                     if didTap {
                                         print("repasswordText completion from tap")
                                     } else {
                                         print("repasswordText completion without tap")
                                     }
                                 }
            }else{
            if passwordText.text == repasswordText.text{
                sendRegistrationdata()
            }else{
                
            repasswordVW.makeToast("Password not match", duration: 2.0, position: .center)
             repasswordText.makeToast("", duration: 2.0, point: point, title: "", image: UIImage(named: "warning_icon.png")) { didTap in
                                 if didTap {
                                     print("completion from tap")
                                 } else {
                                     print("completion without tap")
                                    }
                                }
                            }
                        }
            
            
            
                     }else{
            ToastManager.shared.style.imageSize = CGSize.init(width: 30, height: 30)
            var point : CGPoint = CGPoint(x: 310.0, y: 30.0)
            
            if userNameText.text == ""{
                userNameVW.makeToast("Fiil in the blank", duration: 2.0, position: .center)
                userNameText.makeToast("", duration: 2.0, point: point, title: "", image: UIImage(named: "warning_icon.png")) { didTap in
                                     if didTap {
                                         print("userNameText completion from tap")
                                     } else {
                                         print("userNameText completion without tap")
                                     }
                                 }
                }else if emailText.text == ""{
                emailVW.makeToast("Fiil in the blank", duration: 2.0, position: .center)
                 emailText.makeToast("", duration: 2.0, point: point, title: "", image: UIImage(named: "warning_icon.png")) { didTap in
                                     if didTap {
                                         print("emailText completion from tap")
                                     } else {
                                         print("emailText completion without tap")
                                     }
                                 }
                
            }else if passwordText.text == ""{
                passwordVw.makeToast("Fiil in the blank", duration: 2.0, position: .center)
                 passwordText.makeToast("", duration: 2.0, point: point, title: "", image: UIImage(named: "warning_icon.png")) { didTap in
                                     if didTap {
                                         print("passwordText completion from tap")
                                     } else {
                                         print("passwordText completion without tap")
                                     }
                                 }
                
            }else if repasswordText.text == ""{
                repasswordVW.makeToast("Fiil in the blank", duration: 2.0, position: .center)
                 repasswordText.makeToast("", duration: 2.0, point: point, title: "", image: UIImage(named: "warning_icon.png")) { didTap in
                                     if didTap {
                                         print("repasswordText completion from tap")
                                     } else {
                                         print("repasswordText completion without tap")
                                     }
                                 }
            }else{
            if passwordText.text == repasswordText.text{
                sendRegistrationdata()
            }else{
                
            repasswordVW.makeToast("Password not match", duration: 2.0, position: .center)
             repasswordText.makeToast("", duration: 2.0, point: CGPoint(x: 310.0, y: 30.0), title: "", image: UIImage(named: "warning_icon.png")) { didTap in
                                 if didTap {
                                     print("completion from tap")
                                 } else {
                                     print("completion without tap")
                                    }
                                }
                            }
                        }
                     }
                }
    
     @IBAction func LoginActn(_ sender : Any){
        
        self.navigationController?.popViewController(animated: true)
    
                }
    
    
            }

extension RegistrationViewController: UITextFieldDelegate{
            func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                
                if textField == userNameText
                {
                    emailText.becomeFirstResponder()
                   
                }else if textField == emailText
                {
                    passwordText.becomeFirstResponder()
                   
                }else if textField == passwordText
                {
                    repasswordText.becomeFirstResponder()
                   
                }else {
                    repasswordText.resignFirstResponder()
                 
                }
          
                return true
              
                }
     
        }

extension RegistrationViewController : jsonDataDelegate{
    func didReceivedData(_ data: Any, jsonname: String) {
        
        
        ToastManager.shared.style.backgroundColor = UIColor.black
        ToastManager.shared.style.messageColor = UIColor.white
        ToastManager.shared.style.titleFont =  UIFont.systemFont(ofSize: 30.0)
        
        
        print("Raw Data",data)
        print("jsonname",jsonname)
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
              let jsonData = try JSONDecoder().decode(RegistrationData.self, from: convertToData(givingValue: data)!)
            print("Status==>",jsonData.data?.status)
          
            
              message = (jsonData.data?.message)!
              
              if jsonData.data?.status == "Yes"{
                              
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
