//
//  ProfileVWController.swift
//  Status Bank
//
//  Created by admin on 4/15/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class ProfileVWController: UIViewController {
    
    @IBOutlet weak var firstSubBtn : UIButton!
    @IBOutlet weak var secondSubBtn : UIButton!
    @IBOutlet weak var thirdSubBtn : UIButton!
    @IBOutlet weak var fourSubBtn : UIButton!
    
  
    override func viewDidLoad() {
        designBtnLbl(name : firstSubBtn, radius : 25, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        designBtnLbl(name : secondSubBtn, radius : 25, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        designBtnLbl(name : thirdSubBtn, radius : 25, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        designBtnLbl(name : fourSubBtn, radius : 25, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
   print("store_User_id",store_User_id)
        
    }
    
    @IBAction func firstSubBtnActn(_ sender : Any){
        
    }
    @IBAction func secondSubBtn(_ sender : Any){
        
    }
    @IBAction func thirdSubBtn(_ sender : Any){
        
    }
    @IBAction func fourSubBtn(_ sender : Any){
        
    }
   

}
