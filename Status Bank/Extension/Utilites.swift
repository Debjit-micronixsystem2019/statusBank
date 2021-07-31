//
//  utilites.swift
//  Faso
//
//  Created by admin on 1/23/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    func textfieldRoundBoderShadow(){
        // self.layer.masksToBounds = false
       /*  self.layer.shadowRadius = 2.0
         self.layer.shadowColor = UIColor.black.cgColor
         self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
         self.layer.shadowOpacity = 0.5*/
        
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 3.0
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowColor = UIColor.black.cgColor

               self.borderStyle = .none
               self.backgroundColor = UIColor.groupTableViewBackground // Use anycolor that give you a 2d look.

               //To apply corner radius
            if  UIDevice.current.model == "iPad"{
                self.layer.cornerRadius = self.frame.size.height / 2
            }else{
                self.layer.cornerRadius = 30
            }
        

               //To apply border
               self.layer.borderWidth = 0.25
               self.layer.borderColor = UIColor.white.cgColor
    }
    
}


extension UIViewController {
    
    
    func designBtnLbl(name : UIButton?, radius : Int, color : UIColor)  {

        name?.layer.cornerRadius = CGFloat(radius)
        name?.layer.borderWidth = 1
        name?.layer.borderColor = color.cgColor
    }
    
    func textfieldpaddingset(textfield : UITextField){
        
        if  UIDevice.current.model == "iPad"{
            
        let paddingVw = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: textfield.frame.height))
        textfield.leftView = paddingVw
        textfield.leftViewMode = .always
            
        }else{
        let paddingVw = UIView(frame: CGRect(x: 0, y: 0, width: 75, height: textfield.frame.height))
        textfield.leftView = paddingVw
        textfield.leftViewMode = .always
        }
        
        
    }
    
    func setBackButton(){
        let yourBackImage = UIImage(named: "back")?.withRenderingMode(.alwaysOriginal)
        navigationController?.navigationBar.backIndicatorImage = yourBackImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
       // navigationController?.navigationItem.backBarButtonItem?.title = " "

    }
    
    
    func showAlertMessageokkk(alertTitle: String, alertMsg : String)
       {
           let alertController = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: .alert)
           let OKAction = UIAlertAction(title: "OK", style: .default) {
               (action: UIAlertAction) in
               self.navigationController?.popViewController(animated: true)
           }
           alertController.addAction(OKAction)
           self.present(alertController, animated: true, completion: nil)
      //    self.dismiss(animated: true, completion: nil)
        
       }

    func showAlertMessageNew(alertTitle: String, alertMsg : String, handlerOK : ((UIAlertAction) -> Void)?,handlerCancle : ((UIAlertAction) -> Void)?)
    {
        let alertController = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .destructive , handler : handlerOK)
        let CancleAction = UIAlertAction(title: "Cancle", style: .cancel, handler: handlerCancle)
        alertController.addAction(OKAction)
        alertController.addAction(CancleAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func showAlert(title: String, message: String, noOfButton: NSNumber, selectorMethod: ()) -> Void {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        if noOfButton == 2 {
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                print("OK")
                selectorMethod
                
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { action in
                print("CANCEL")
            }))
        }
        else{
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                print("OK")
                selectorMethod
            }))
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

extension UIButton{
    func btnShadow(){
     self.layer.masksToBounds = false
        self.layer.shadowRadius = 1.0
        self.layer.shadowColor = UIColor.black.cgColor
     self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowOpacity = 0.3
      
    }
}



